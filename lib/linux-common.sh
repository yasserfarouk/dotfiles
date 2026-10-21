#!/usr/bin/env bash
# Shared helpers for linux-setup.sh and wsl-setup.sh (source this file, do not run it).
#
# Policy: root is used ONLY for distro packages that cannot reasonably be installed
# in $HOME (zsh, compilers, ruby/perl, optional extras) and only when sudo works.
# Everything else goes to ~/.local/bin, ~/.local/share, ~/.cargo or ~/.nvm.

LOCAL_BIN="$HOME/.local/bin"
mkdir -p "$LOCAL_BIN"
export PATH="$LOCAL_BIN:$HOME/.cargo/bin:$PATH"

have() { command -v "$1" >/dev/null 2>&1; }
warn() { echo "  Warning: $*"; }
section() {
    echo ""
    echo "========================================"
    echo "$1"
    echo "========================================"
    echo ""
}

# ----------------------------------------
# Architecture (names differ per project, so expose every flavour)
# ----------------------------------------
case "$(uname -m)" in
    x86_64|amd64)  ARCH=x86_64;  GOARCH=amd64; CAP_ARCH=x86_64; GL_ARCH=x64 ;;
    aarch64|arm64) ARCH=aarch64; GOARCH=arm64; CAP_ARCH=arm64;  GL_ARCH=arm64 ;;
    *) ARCH="$(uname -m)"; GOARCH="$ARCH"; CAP_ARCH="$ARCH"; GL_ARCH="$ARCH"
       echo "Warning: unsupported architecture $ARCH, release-binary installs will be skipped" ;;
esac

# ----------------------------------------
# Root detection (never required)
# ----------------------------------------
SUDO=""
HAVE_ROOT=0

# Sets HAVE_ROOT=1 if we are root or sudo works (passwordless, or after one prompt on a tty).
# Set NO_SUDO=1 to force a fully rootless run.
detect_root() {
    HAVE_ROOT=0
    SUDO=""
    if [ -n "${NO_SUDO:-}" ]; then
        echo "NO_SUDO set: running without root, system package steps will be skipped."
        return
    fi
    if [ "$(id -u)" -eq 0 ]; then
        HAVE_ROOT=1
    elif have sudo && sudo -n true 2>/dev/null; then
        HAVE_ROOT=1; SUDO=sudo
    elif have sudo && [ -t 0 ]; then
        echo "sudo is only used for a few distro packages (zsh, compilers, ruby/perl, extras)."
        read -r -p "Authenticate with sudo now? [y/N] " ans
        case "$ans" in
            [Yy]*) sudo -v && { HAVE_ROOT=1; SUDO=sudo; } ;;
        esac
    fi
    if [ "$HAVE_ROOT" -eq 1 ]; then
        if [ -n "$SUDO" ]; then
            # keep sudo alive for the duration of the script
            while true; do sudo -n true; sleep 60; kill -0 "$$" || exit; done 2>/dev/null &
        fi
    else
        echo "No root access: system package steps will be skipped; user-level tools still install."
    fi
}

detect_package_manager() {
    if have apt-get; then
        PKG_MANAGER="apt"
    elif have dnf; then
        PKG_MANAGER="dnf"
    elif have pacman; then
        PKG_MANAGER="pacman"
    else
        PKG_MANAGER=""
        echo "No supported package manager (apt, dnf, pacman) found: system packages will be skipped."
    fi
    [ -n "$PKG_MANAGER" ] && echo "Detected package manager: $PKG_MANAGER"
    return 0
}

# sys_install <pkg>...  (root only; no-op with a note otherwise)
sys_install() {
    [ "$HAVE_ROOT" -eq 1 ] && [ -n "$PKG_MANAGER" ] || return 1
    case $PKG_MANAGER in
        apt)    DEBIAN_FRONTEND=noninteractive $SUDO apt-get install -y "$@" ;;
        dnf)    $SUDO dnf install -y "$@" ;;
        pacman) $SUDO pacman -S --needed --noconfirm "$@" ;;
    esac
}

# sys_install_each <pkg>...  (one at a time so a missing package does not abort the rest)
sys_install_each() {
    local p
    for p in "$@"; do
        echo "  Installing $p..."
        sys_install "$p" || warn "failed to install $p"
    done
}

# ----------------------------------------
# System packages (the only root-requiring part)
# ----------------------------------------
setup_locale() {
    [ "$HAVE_ROOT" -eq 1 ] || { echo "No root: skipping locale generation."; export LANG="${LANG:-C.UTF-8}"; return 0; }
    case $PKG_MANAGER in
        apt)
            sys_install locales
            $SUDO sed -i 's/# en_US.UTF-8 UTF-8/en_US.UTF-8 UTF-8/' /etc/locale.gen
            $SUDO locale-gen
            $SUDO update-locale LANG=en_US.UTF-8 LC_ALL=en_US.UTF-8
            ;;
        dnf)    sys_install glibc-langpack-en ;;
        pacman)
            $SUDO sed -i 's/#en_US.UTF-8 UTF-8/en_US.UTF-8 UTF-8/' /etc/locale.gen
            $SUDO locale-gen
            ;;
    esac
    export LANG=en_US.UTF-8
    export LC_ALL=en_US.UTF-8
}

# Packages that genuinely need the distro: shell, compilers (cargo builds), ruby (tmuxinator),
# perl+make (stow / diff-so-fancy), unzip (zip extraction, SDKMAN), git/curl bootstrap.
install_system_required() {
    if [ "$HAVE_ROOT" -ne 1 ] || [ -z "$PKG_MANAGER" ]; then
        local missing=()
        local c
        for c in git curl zsh cc ruby perl make zip unzip; do have "$c" || missing+=("$c"); done
        if [ ${#missing[@]} -gt 0 ]; then
            echo "No root: please ask an admin to install: ${missing[*]}"
            echo "  (zsh and compilers cannot be installed user-level; the rest of the setup continues)"
        fi
        return 0
    fi
    case $PKG_MANAGER in
        apt)
            $SUDO apt-get update
            SYS_REQUIRED=(git curl wget zsh build-essential ruby perl make zip unzip xz-utils ca-certificates)
            ;;
        dnf)
            SYS_REQUIRED=(git curl wget zsh gcc gcc-c++ make ruby perl zip unzip xz)
            ;;
        pacman)
            SYS_REQUIRED=(git curl wget zsh base-devel ruby perl zip unzip xz)
            ;;
    esac
    # Skip the package manager entirely when everything is already there (quick re-runs)
    have zsh && have git && have cc && have ruby && have perl && have unzip && have zip && have curl \
        && { echo "Required system packages already present."; return 0; }
    sys_install_each "${SYS_REQUIRED[@]}"
}

# Optional distro extras the previous scripts installed (nice to have, all skipped without root).
# Everything that now has a user-level install (fzf, rg, fd, bat, jq, stow, direnv, node, eza,
# lazygit, gh, ...) is intentionally NOT here.
install_system_optional() {
    if [ "$HAVE_ROOT" -ne 1 ] || [ -z "$PKG_MANAGER" ]; then
        echo "No root: skipping optional distro extras (vim, tig, htop, pandoc, texlive, ...)."
        return 0
    fi
    local pkgs=()
    case $PKG_MANAGER in
        apt)
            pkgs=(tig silversearcher-ag htop tree neofetch cmake bison sqlite3 vim
                  pandoc imagemagick ffmpeg poppler-utils ghostscript antiword
                  texlive texlive-latex-extra texlive-fonts-recommended texlive-xetex latexmk
                  doxygen graphviz shellcheck cloc nmap httpie gzip p7zip-full entr trash-cli
                  golang-go vifm)
            ;;
        dnf)
            pkgs=(tig the_silver_searcher htop tree neofetch cmake bison sqlite vim
                  pandoc ImageMagick ffmpeg poppler-utils ghostscript antiword
                  doxygen graphviz ShellCheck cloc nmap httpie gzip p7zip entr trash-cli
                  golang vifm)
            ;;
        pacman)
            pkgs=(tig the_silver_searcher htop tree neofetch cmake bison sqlite vim
                  pandoc imagemagick ffmpeg poppler ghostscript antiword
                  texlive-core texlive-latexextra texlive-fontsrecommended texlive-xetex latexmk
                  doxygen graphviz shellcheck cloc nmap httpie gzip p7zip entr trash-cli
                  go vifm)
            ;;
    esac
    sys_install_each "${pkgs[@]}"
}

# ----------------------------------------
# GitHub release helper
# ----------------------------------------
# install_gh_release <owner/repo> <asset-ERE> <binary[ binary...]> [path-ERE]
#   Downloads the latest release asset whose URL matches <asset-ERE> (musl builds preferred),
#   extracts it (tar.gz/tar.xz/zip/gz/raw binary) and installs <binary>(ies) to ~/.local/bin.
#   [path-ERE] disambiguates when an archive holds several files with the same name.
#   Skips if every binary is already on PATH. Honors GITHUB_TOKEN (never printed) for rate limits.
install_gh_release() {
    local repo="$1" pattern="$2" bins="$3" hint="${4:-.}"
    local b absent=0
    for b in $bins; do have "$b" || absent=1; done
    if [ "$absent" -eq 0 ]; then
        echo "  $bins already installed, skipping"
        return 0
    fi
    have curl || { warn "curl missing, cannot install $bins"; return 1; }
    [ "$ARCH" = x86_64 ] || [ "$ARCH" = aarch64 ] || { warn "unsupported arch, skipping $bins"; return 1; }

    echo "  Installing $bins from github.com/$repo ..."
    local auth=()
    [ -n "${GITHUB_TOKEN:-}" ] && auth=(-H "Authorization: Bearer $GITHUB_TOKEN")
    local urls url
    urls=$(curl -fsSL "${auth[@]}" "https://api.github.com/repos/$repo/releases/latest" 2>/dev/null \
        | grep -oE '"browser_download_url": *"[^"]+"' | sed -E 's/^[^:]*: *"//; s/"$//' || true)
    url=$(printf '%s\n' "$urls" | grep -E "$pattern" | grep -m1 musl || true)
    [ -n "$url" ] || url=$(printf '%s\n' "$urls" | grep -m1 -E "$pattern" || true)
    if [ -z "$url" ]; then
        warn "no release asset matching '$pattern' for $repo (API rate limit? set GITHUB_TOKEN)"
        return 1
    fi

    local tmp file
    tmp=$(mktemp -d)
    file="$tmp/${url##*/}"
    mkdir -p "$tmp/x"
    if ! curl -fsSL -o "$file" "$url"; then
        warn "download failed: $url"; rm -rf "$tmp"; return 1
    fi
    case "$file" in
        *.tar.gz|*.tgz) tar -xzf "$file" -C "$tmp/x" ;;
        *.tar.xz)       tar -xJf "$file" -C "$tmp/x" ;;
        *.zip)
            unzip -q "$file" -d "$tmp/x" 2>/dev/null \
                || bsdtar -xf "$file" -C "$tmp/x" 2>/dev/null \
                || python3 -m zipfile -e "$file" "$tmp/x" ;;
        *.gz)           gunzip -c "$file" > "$tmp/x/${bins%% *}" ;;
        *)              cp "$file" "$tmp/x/${bins%% *}" ;;
    esac

    local src rc=0
    for b in $bins; do
        src=$(find "$tmp/x" -type f -name "$b" | grep -E "$hint" | head -1 || true)
        if [ -n "$src" ]; then
            install -m 755 "$src" "$LOCAL_BIN/$b"
        else
            warn "$b not found inside ${url##*/}"; rc=1
        fi
    done
    rm -rf "$tmp"
    return $rc
}

# ----------------------------------------
# User-level tool installers
# ----------------------------------------
install_uv() {
    if have uv; then echo "  uv already installed"; return 0; fi
    echo "Installing uv..."
    curl -LsSf https://astral.sh/uv/install.sh | sh || warn "uv install failed"
}

install_neovim() {
    local ver=""
    if have nvim; then
        ver=$(nvim --version 2>/dev/null | head -1 | sed -E 's/^NVIM v([0-9]+\.[0-9]+).*/\1/')
        # >= 0.10 is good enough (distro packages are often far older)
        if [ -n "$ver" ] && [ "$(printf '%s\n0.10\n' "$ver" | sort -V | head -1)" = "0.10" ]; then
            echo "  neovim $ver already installed"
            return 0
        fi
        echo "  neovim '${ver:-unknown}' is too old, installing a current release to ~/.local"
    fi
    [ "$ARCH" = x86_64 ] || [ "$ARCH" = aarch64 ] || { warn "unsupported arch for nvim tarball"; return 1; }
    local tmp
    tmp=$(mktemp -d)
    if curl -fsSL -o "$tmp/nvim.tar.gz" "https://github.com/neovim/neovim/releases/latest/download/nvim-linux-${CAP_ARCH}.tar.gz" \
        && tar -xzf "$tmp/nvim.tar.gz" -C "$tmp"; then
        rm -rf "$HOME/.local/nvim"
        mv "$tmp"/nvim-linux-* "$HOME/.local/nvim"
        ln -sf "$HOME/.local/nvim/bin/nvim" "$LOCAL_BIN/nvim"
    else
        warn "neovim download failed"
    fi
    rm -rf "$tmp"
}

install_tmux() {
    if have tmux; then echo "  tmux already installed"; return 0; fi
    # tmux needs libevent/ncurses to build, so prefer the distro package when root is available
    if sys_install tmux 2>/dev/null; then return 0; fi
    echo "  No root: trying a static tmux build from mjakob-gh/build-static-tmux (third-party build)"
    install_gh_release mjakob-gh/build-static-tmux "tmux\\.linux-${GOARCH}\\.gz\$" tmux \
        || warn "tmux not installed: ask an admin for the tmux package (needs >= 3.2 for popups)"
}

install_stow() {
    if have stow; then echo "  stow already installed"; return 0; fi
    # stow is plain perl: build it into ~/.local when perl+make exist, otherwise use root
    if have perl && have make && have curl; then
        echo "  Building stow into ~/.local ..."
        local tmp
        tmp=$(mktemp -d)
        if curl -fsSL -o "$tmp/stow.tar.gz" https://ftp.gnu.org/gnu/stow/stow-latest.tar.gz \
            && tar -xzf "$tmp/stow.tar.gz" -C "$tmp" \
            && (cd "$tmp"/stow-*/ && ./configure --prefix="$HOME/.local" >/dev/null && make install >/dev/null); then
            rm -rf "$tmp"
            return 0
        fi
        rm -rf "$tmp"
        warn "user-level stow build failed"
    fi
    sys_install stow || warn "stow not installed (needs perl+make, or root)"
}

install_starship() {
    if have starship; then echo "  starship already installed"; return 0; fi
    curl -fsSL https://starship.rs/install.sh | sh -s -- -y -b "$LOCAL_BIN" || warn "starship install failed"
}

install_tpm() {
    if [ -d "$HOME/.tmux/plugins/tpm" ]; then echo "  tpm already installed"; return 0; fi
    have git || { warn "git missing, cannot clone tpm"; return 1; }
    git clone --depth 1 https://github.com/tmux-plugins/tpm "$HOME/.tmux/plugins/tpm" || warn "tpm clone failed"
}

# Run after stowing so ~/.tmux.conf exists
install_tpm_plugins() {
    if [ -x "$HOME/.tmux/plugins/tpm/bin/install_plugins" ] && have tmux && [ -e "$HOME/.tmux.conf" ]; then
        "$HOME/.tmux/plugins/tpm/bin/install_plugins" || warn "tpm plugin install failed (press prefix + I inside tmux)"
    fi
}

install_tmuxinator() {
    if have tmuxinator; then echo "  tmuxinator already installed"; return 0; fi
    if ! have gem; then warn "ruby/gem not available (needs root to install ruby), skipping tmuxinator"; return 1; fi
    gem install --user-install tmuxinator || { warn "tmuxinator gem install failed"; return 1; }
    local gembin
    gembin="$(ruby -e 'puts Gem.user_dir')/bin"
    [ -x "$gembin/tmuxinator" ] && ln -sf "$gembin/tmuxinator" "$LOCAL_BIN/tmuxinator"
    gem list -i neovim >/dev/null 2>&1 || gem install --user-install neovim || true
}

install_diff_so_fancy() {
    if have diff-so-fancy; then echo "  diff-so-fancy already installed"; return 0; fi
    curl -fsSL https://raw.githubusercontent.com/so-fancy/diff-so-fancy/master/third_party/build_fatpack/diff-so-fancy \
        -o "$LOCAL_BIN/diff-so-fancy" && chmod +x "$LOCAL_BIN/diff-so-fancy" || warn "diff-so-fancy install failed"
}

install_nvm_node() {
    export NVM_DIR="$HOME/.nvm"
    if [ ! -s "$NVM_DIR/nvm.sh" ]; then
        echo "  Installing nvm..."
        curl -fsSL https://raw.githubusercontent.com/nvm-sh/nvm/v0.40.3/install.sh | PROFILE=/dev/null bash \
            || { warn "nvm install failed"; return 1; }
    fi
    if ! have node; then
        set +e
        # shellcheck disable=SC1091
        . "$NVM_DIR/nvm.sh"
        nvm install --lts
        nvm alias default 'lts/*' >/dev/null
        set -e
    else
        echo "  node already installed"
    fi
}

# npm_global <pkg>: user-level; falls back to --prefix ~/.local if the npm prefix is not writable
npm_global() {
    local pkg="$1" prefix
    have npm || { warn "npm not available, skipping $pkg"; return 1; }
    npm ls -g --depth=0 "$pkg" >/dev/null 2>&1 && { echo "  $pkg already installed"; return 0; }
    prefix="$(npm config get prefix 2>/dev/null)"
    if [ -w "$prefix" ] && [ -w "$prefix/lib" ] 2>/dev/null; then
        npm install -g "$pkg" || warn "failed to install $pkg"
    else
        npm install -g --prefix "$HOME/.local" "$pkg" || warn "failed to install $pkg"
    fi
}

install_rust() {
    if have cargo; then return 0; fi
    echo "Installing Rust (rustup, user level)..."
    curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh -s -- -y \
        && . "$HOME/.cargo/env" || warn "rustup install failed"
}

# ----------------------------------------
# Whole-inventory stages (shared by linux-setup.sh and wsl-setup.sh)
# ----------------------------------------
install_user_cli_tools() {
    section "Installing CLI tools (user-level, ~/.local/bin)"

    echo "git-lfs / gh / gitleaks"
    install_gh_release git-lfs/git-lfs "git-lfs-linux-${GOARCH}-v[0-9.]+\\.tar\\.gz\$" git-lfs
    install_gh_release cli/cli "gh_[0-9.]+_linux_${GOARCH}\\.tar\\.gz\$" gh
    # gitleaks: secret scanner used by .githooks
    install_gh_release gitleaks/gitleaks "gitleaks_[0-9.]+_linux_${GL_ARCH}\\.tar\\.gz\$" gitleaks

    echo "Search / navigation"
    install_gh_release junegunn/fzf "fzf-[0-9.]+-linux_${GOARCH}\\.tar\\.gz\$" fzf
    install_gh_release sharkdp/fd "fd-v[0-9.]+-${ARCH}-unknown-linux-(musl|gnu)\\.tar\\.gz\$" fd
    install_gh_release BurntSushi/ripgrep "ripgrep-[0-9.]+-${ARCH}-unknown-linux-(musl|gnu)\\.tar\\.gz\$" rg
    install_gh_release sharkdp/bat "bat-v[0-9.]+-${ARCH}-unknown-linux-(musl|gnu)\\.tar\\.gz\$" bat
    install_gh_release eza-community/eza "eza_${ARCH}-unknown-linux-(musl|gnu)\\.tar\\.gz\$" eza
    install_gh_release ajeetdsouza/zoxide "zoxide-[0-9.]+-${ARCH}-unknown-linux-musl\\.tar\\.gz\$" zoxide

    echo "Data tools"
    install_gh_release jqlang/jq "jq-linux-${GOARCH}\$" jq
    install_gh_release mikefarah/yq "yq_linux_${GOARCH}\$" yq

    echo "Terminal tools"
    install_gh_release jesseduffield/lazygit "lazygit_[0-9.]+_[Ll]inux_${CAP_ARCH}\\.tar\\.gz\$" lazygit
    install_gh_release jesseduffield/lazydocker "lazydocker_[0-9.]+_[Ll]inux_${CAP_ARCH}\\.tar\\.gz\$" lazydocker
    install_gh_release joshmedeski/sesh "sesh_[Ll]inux_${CAP_ARCH}\\.tar\\.gz\$" sesh
    install_gh_release raine/workmux "workmux-linux-${GOARCH}\\.tar\\.gz\$" workmux
    install_gh_release sxyazi/yazi "yazi-${ARCH}-unknown-linux-(musl|gnu)\\.zip\$" "yazi ya"
    if ! have broot; then
        install_gh_release Canop/broot "broot_[0-9.]+\\.zip\$" broot "${ARCH}-unknown-linux-musl/" \
            || BROOT_VIA_CARGO=1
    fi
    install_gh_release direnv/direnv "direnv\\.linux-${GOARCH}\$" direnv
    install_gh_release sharkdp/hyperfine "hyperfine-v[0-9.]+-${ARCH}-unknown-linux-(musl|gnu)\\.tar\\.gz\$" hyperfine
    install_gh_release nektos/act "act_Linux_${CAP_ARCH}\\.tar\\.gz\$" act
    install_gh_release charmbracelet/glow "glow_[0-9.]+_Linux_${CAP_ARCH}\\.tar\\.gz\$" glow

    echo "starship"
    install_starship
    echo "diff-so-fancy (git pager)"
    install_diff_so_fancy
}

install_priority_tools() {
    section "Installing Priority Tools (uv, neovim, tmux + tpm, stow)"
    install_uv
    export PATH="$LOCAL_BIN:$PATH"
    install_neovim
    install_tmux
    install_tpm
    install_stow
}

install_language_tools() {
    section "Installing Node (nvm) and global npm packages"
    install_nvm_node
    local p
    for p in yarn prettier eslint typescript neovim write-good tree-sitter-cli tldr; do
        npm_global "$p"
    done

    section "Installing Rust and Cargo Packages"
    if have cc || have gcc; then
        install_rust
        local crates=(duf nerdfix viu scc)
        [ -n "${BROOT_VIA_CARGO:-}" ] && crates+=(broot)
        local c
        for c in "${crates[@]}"; do
            if have "$c"; then echo "  $c already installed"; else
                echo "Installing cargo package: $c..."
                cargo install --locked "$c" || cargo install "$c" || warn "failed to install $c"
            fi
        done
    else
        warn "no C compiler (needs root once: build-essential/gcc), skipping cargo packages"
    fi

    section "Installing Python Packages via uv"
    if have uv; then
        uv python install 3.12
        local tools=(neovim-remote pre-commit black isort ruff rich-cli glances bpytop httpie asciinema)
        local listed t
        listed="$(uv tool list 2>/dev/null || true)"
        for t in "${tools[@]}"; do
            if printf '%s\n' "$listed" | grep -q "^$t "; then echo "  $t already installed"; else
                echo "Installing uv tool: $t..."
                uv tool install "$t" || warn "failed to install $t"
            fi
        done

        section "Setting up Neovim Python Environments"
        local venv dir
        for venv in neovim2 neovim3; do
            dir="$HOME/.local/share/uv/venvs/$venv"
            [ -x "$dir/bin/python" ] || uv venv "$dir" --python 3.12
            uv pip install --python "$dir/bin/python" -U neovim flake8
        done
        uv pip install --python "$HOME/.local/share/uv/venvs/neovim3/bin/python" -U neovim-remote
    else
        warn "uv missing, skipping Python tools"
    fi

    section "Installing Go Packages"
    if have go; then
        have md-publisher || [ -x "$HOME/go/bin/md-publisher" ] \
            || go install github.com/andremueller/md-publisher@latest || warn "failed to install md-publisher"
    else
        warn "go not available (optional extra needing root), skipping md-publisher"
    fi
}

install_ai_assistants() {
    section "Installing AI Coding Assistants"
    # Correct npm package names (the old @anthropic/opencode and @anthropic/claude-code do not exist)
    have opencode || npm_global opencode-ai
    have claude || npm_global @anthropic-ai/claude-code
    have pi || npm_global @earendil-works/pi-coding-agent
}

install_nerd_fonts() {
    # usage: install_nerd_fonts <Font> ...   (user-level, ~/.local/share/fonts)
    section "Installing Nerd Fonts"
    mkdir -p "$HOME/.local/share/fonts"
    local f
    for f in "$@"; do
        if compgen -G "$HOME/.local/share/fonts/${f}*NerdFont*" >/dev/null; then
            echo "  $f Nerd Font already installed"; continue
        fi
        echo "Downloading $f Nerd Font..."
        local tmp
        tmp=$(mktemp -d)
        if curl -fsSL -o "$tmp/$f.tar.xz" "https://github.com/ryanoasis/nerd-fonts/releases/latest/download/$f.tar.xz" \
            && tar -xf "$tmp/$f.tar.xz" -C "$HOME/.local/share/fonts"; then
            :
        else
            warn "failed to install $f Nerd Font"
        fi
        rm -rf "$tmp"
    done
    have fc-cache && fc-cache -f >/dev/null 2>&1 || true
}

install_shell_extras() {
    section "Setting up Shell"
    if [ ! -f "$HOME/antigen.zsh" ]; then
        curl -fsSL https://raw.githubusercontent.com/zsh-users/antigen/master/bin/antigen.zsh -o "$HOME/antigen.zsh" \
            || warn "failed to download antigen"
    fi

    section "Installing Java with SDKMAN"
    if [ ! -d "$HOME/.sdkman" ]; then
        if have unzip && have zip; then
            curl -fsSL "https://get.sdkman.io" | bash || warn "SDKMAN install failed"
        else
            warn "SDKMAN needs zip and unzip (root package), skipping"
        fi
    fi
    export SDKMAN_DIR="$HOME/.sdkman"
    if [ -s "$HOME/.sdkman/bin/sdkman-init.sh" ]; then
        set +e
        # shellcheck disable=SC1091
        . "$HOME/.sdkman/bin/sdkman-init.sh"
        for v in "$@"; do
            sdk install java "$v" || echo "  Warning: Failed to install Java $v"
        done
        sdk default java "$1" || true
        set -e
    fi
}

enable_git_hooks() {
    git -C "$SCRIPT_DIR" config core.hooksPath .githooks 2>/dev/null || true
}
