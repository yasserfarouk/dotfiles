#!/usr/bin/env bash
# WSL Setup Script
# This script installs CLI applications equivalent to the macOS Brewfile
# Designed for WSL (Windows Subsystem for Linux) - NO GUI apps

set -e

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

echo "========================================"
echo "WSL Development Environment Setup"
echo "========================================"
echo ""

# Get sudo password early so the script can run unattended
echo "This script requires sudo access. Please enter your password now."
sudo -v
# Keep sudo alive throughout the script
while true; do sudo -n true; sleep 60; kill -0 "$$" || exit; done 2>/dev/null &

# Detect package manager
detect_package_manager() {
    if command -v apt &> /dev/null; then
        PKG_MANAGER="apt"
        PKG_INSTALL="sudo apt install -y"
        PKG_UPDATE="sudo apt update && sudo apt upgrade -y"
    elif command -v dnf &> /dev/null; then
        PKG_MANAGER="dnf"
        PKG_INSTALL="sudo dnf install -y"
        PKG_UPDATE="sudo dnf upgrade -y"
    elif command -v pacman &> /dev/null; then
        PKG_MANAGER="pacman"
        PKG_INSTALL="sudo pacman -S --noconfirm"
        PKG_UPDATE="sudo pacman -Syu --noconfirm"
    else
        echo "ERROR: No supported package manager found (apt, dnf, or pacman)"
        exit 1
    fi
    echo "Detected package manager: $PKG_MANAGER"
}

detect_package_manager

# Update system
echo ""
echo "Updating system packages..."
eval $PKG_UPDATE

# ========================================
# PRIORITY 1: Essential tools (uv, neovim, tmux, stow)
# ========================================
echo ""
echo "========================================"
echo "Installing Priority Tools (uv, neovim, tmux, stow)"
echo "========================================"
echo ""

# Install stow first so we can stow dotfiles
echo "Installing stow..."
$PKG_INSTALL stow

# Install uv (Python package manager)
echo "Installing uv..."
curl -LsSf https://astral.sh/uv/install.sh | sh
export PATH="$HOME/.local/bin:$PATH"

# Install neovim
echo "Installing neovim..."
case $PKG_MANAGER in
    apt)
        # Add neovim PPA for latest version
        sudo add-apt-repository -y ppa:neovim-ppa/unstable || true
        sudo apt update
        sudo apt install -y neovim
        ;;
    dnf)
        sudo dnf install -y neovim
        ;;
    pacman)
        sudo pacman -S --noconfirm neovim
        ;;
esac

# Install tmux
echo "Installing tmux..."
$PKG_INSTALL tmux

# Install tree-sitter CLI (required for nvim-treesitter in Neovim 0.12+)
echo "Installing tree-sitter CLI..."
if command -v cargo &> /dev/null; then
    cargo install tree-sitter-cli || echo "  Warning: Failed to install tree-sitter-cli via cargo"
elif command -v npm &> /dev/null; then
    sudo npm install -g tree-sitter-cli || echo "  Warning: Failed to install tree-sitter-cli via npm"
else
    echo "  Note: Install Rust or npm first for tree-sitter-cli"
fi

# ========================================
# Core CLI Tools
# ========================================
echo ""
echo "========================================"
echo "Installing Core CLI Tools"
echo "========================================"
echo ""

# Define packages for each package manager
case $PKG_MANAGER in
    apt)
        CORE_PACKAGES=(
            # Version Control
            git
            git-lfs
            tig
            
            # Search & Navigation
            fzf
            ripgrep
            fd-find
            bat
            silversearcher-ag
            
            # Text Processing
            jq
            
            # System Tools
            htop
            wget
            curl
            tree
            neofetch
            
            # Terminal & Shell
            zsh
            
            # Build Tools
            build-essential
            cmake
            make
            gcc
            bison
            
            # Database
            sqlite3
            
            # Editors
            vim
            
            # File Processing
            pandoc
            imagemagick
            ffmpeg
            poppler-utils
            ghostscript
            antiword
            
            # LaTeX
            texlive
            texlive-latex-extra
            texlive-fonts-recommended
            texlive-xetex
            latexmk
            
            # Documentation
            doxygen
            graphviz
            
            # Code Quality
            shellcheck
            cloc
            
            # Network
            nmap
            
            # Compression
            unzip
            gzip
            p7zip-full
            
            # Misc
            direnv
            entr
            software-properties-common
            
            # Language support
            nodejs
            npm
            golang-go
            ruby
            perl
        )
        ;;
    dnf)
        CORE_PACKAGES=(
            git
            git-lfs
            tig
            fzf
            ripgrep
            fd-find
            bat
            the_silver_searcher
            jq
            htop
            wget
            curl
            tree
            neofetch
            zsh
            cmake
            make
            gcc
            bison
            sqlite
            vim
            pandoc
            ImageMagick
            ffmpeg
            poppler-utils
            ghostscript
            antiword
            # LaTeX
            texlive
            texlive-latex
            texlive-xetex
            latexmk
            doxygen
            graphviz
            ShellCheck
            cloc
            nmap
            unzip
            gzip
            p7zip
            direnv
            entr
            nodejs
            npm
            golang
            ruby
            perl
        )
        ;;
    pacman)
        CORE_PACKAGES=(
            git
            git-lfs
            tig
            fzf
            ripgrep
            fd
            bat
            the_silver_searcher
            jq
            htop
            wget
            curl
            tree
            neofetch
            zsh
            cmake
            make
            gcc
            bison
            sqlite
            vim
            pandoc
            imagemagick
            ffmpeg
            poppler
            ghostscript
            antiword
            # LaTeX
            texlive-core
            texlive-latexextra
            texlive-fontsrecommended
            texlive-xetex
            latexmk
            doxygen
            graphviz
            shellcheck
            cloc
            nmap
            unzip
            gzip
            p7zip
            direnv
            entr
            nodejs
            npm
            go
            ruby
            perl
        )
        ;;
esac

echo "Installing core packages..."
for package in "${CORE_PACKAGES[@]}"; do
    echo "  Installing $package..."
    $PKG_INSTALL "$package" || echo "  Warning: Failed to install $package"
done

# ========================================
# Tools installed via other methods
# ========================================
echo ""
echo "========================================"
echo "Installing Additional Tools"
echo "========================================"
echo ""

# Install lazygit
echo "Installing lazygit..."
case $PKG_MANAGER in
    apt)
        LAZYGIT_VERSION=$(curl -s "https://api.github.com/repos/jesseduffield/lazygit/releases/latest" | grep -Po '"tag_name": "v\K[^"]*')
        curl -Lo lazygit.tar.gz "https://github.com/jesseduffield/lazygit/releases/latest/download/lazygit_${LAZYGIT_VERSION}_Linux_x86_64.tar.gz"
        tar xf lazygit.tar.gz lazygit
        sudo install lazygit /usr/local/bin
        rm lazygit.tar.gz lazygit
        ;;
    dnf)
        sudo dnf copr enable atim/lazygit -y
        sudo dnf install -y lazygit
        ;;
    pacman)
        sudo pacman -S --noconfirm lazygit
        ;;
esac

# Install lazydocker
echo "Installing lazydocker..."
curl https://raw.githubusercontent.com/jesseduffield/lazydocker/master/scripts/install_update_linux.sh | bash

# Install GitHub CLI
echo "Installing GitHub CLI..."
case $PKG_MANAGER in
    apt)
        type -p curl >/dev/null || sudo apt install curl -y
        curl -fsSL https://cli.github.com/packages/githubcli-archive-keyring.gpg | sudo dd of=/usr/share/keyrings/githubcli-archive-keyring.gpg
        sudo chmod go+r /usr/share/keyrings/githubcli-archive-keyring.gpg
        echo "deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/githubcli-archive-keyring.gpg] https://cli.github.com/packages stable main" | sudo tee /etc/apt/sources.list.d/github-cli.list > /dev/null
        sudo apt update
        sudo apt install -y gh
        ;;
    dnf)
        sudo dnf install -y gh
        ;;
    pacman)
        sudo pacman -S --noconfirm github-cli
        ;;
esac

# Install eza (modern ls)
echo "Installing eza..."
case $PKG_MANAGER in
    apt)
        sudo mkdir -p /etc/apt/keyrings
        wget -qO- https://raw.githubusercontent.com/eza-community/eza/main/deb.asc | sudo gpg --dearmor -o /etc/apt/keyrings/gierens.gpg
        echo "deb [signed-by=/etc/apt/keyrings/gierens.gpg] http://deb.gierens.de stable main" | sudo tee /etc/apt/sources.list.d/gierens.list
        sudo chmod 644 /etc/apt/keyrings/gierens.gpg /etc/apt/sources.list.d/gierens.list
        sudo apt update
        sudo apt install -y eza
        ;;
    dnf)
        sudo dnf install -y eza
        ;;
    pacman)
        sudo pacman -S --noconfirm eza
        ;;
esac

# Install starship prompt
echo "Installing starship..."
curl -sS https://starship.rs/install.sh | sh -s -- -y

# Install zoxide
echo "Installing zoxide..."
curl -sS https://raw.githubusercontent.com/ajeetdsouza/zoxide/main/install.sh | bash

# Install yazi file manager
echo "Installing yazi..."
case $PKG_MANAGER in
    apt)
        cargo install --locked yazi-fm yazi-cli 2>/dev/null || echo "  Note: Install Rust first for yazi"
        ;;
    dnf)
        cargo install --locked yazi-fm yazi-cli 2>/dev/null || echo "  Note: Install Rust first for yazi"
        ;;
    pacman)
        sudo pacman -S --noconfirm yazi
        ;;
esac

# Install diff-so-fancy
echo "Installing diff-so-fancy..."
mkdir -p ~/bin
curl https://raw.githubusercontent.com/so-fancy/diff-so-fancy/master/third_party/build_fatpack/diff-so-fancy > ~/bin/diff-so-fancy
chmod +x ~/bin/diff-so-fancy

# Install tldr
echo "Installing tldr..."
sudo npm install -g tldr || uv tool install tldr || echo "  Warning: Failed to install tldr"

# Install hyperfine
echo "Installing hyperfine..."
case $PKG_MANAGER in
    apt)
        wget https://github.com/sharkdp/hyperfine/releases/download/v1.18.0/hyperfine_1.18.0_amd64.deb
        sudo dpkg -i hyperfine_1.18.0_amd64.deb
        rm hyperfine_1.18.0_amd64.deb
        ;;
    dnf)
        sudo dnf install -y hyperfine
        ;;
    pacman)
        sudo pacman -S --noconfirm hyperfine
        ;;
esac

# Install act (GitHub Actions locally)
echo "Installing act..."
curl -s https://raw.githubusercontent.com/nektos/act/master/install.sh | sudo bash

# Install glow (markdown viewer)
echo "Installing glow..."
case $PKG_MANAGER in
    apt)
        sudo mkdir -p /etc/apt/keyrings
        curl -fsSL https://repo.charm.sh/apt/gpg.key | sudo gpg --dearmor -o /etc/apt/keyrings/charm.gpg
        echo "deb [signed-by=/etc/apt/keyrings/charm.gpg] https://repo.charm.sh/apt/ * *" | sudo tee /etc/apt/sources.list.d/charm.list
        sudo apt update
        sudo apt install -y glow
        ;;
    dnf)
        echo '[charm]
name=Charm
baseurl=https://repo.charm.sh/yum/
enabled=1
gpgcheck=1
gpgkey=https://repo.charm.sh/yum/gpg.key' | sudo tee /etc/yum.repos.d/charm.repo
        sudo dnf install -y glow
        ;;
    pacman)
        sudo pacman -S --noconfirm glow
        ;;
esac

# Install vifm
echo "Installing vifm..."
$PKG_INSTALL vifm || true

# ========================================
# Install Rust and Cargo packages
# ========================================
echo ""
echo "========================================"
echo "Installing Rust and Cargo Packages"
echo "========================================"
echo ""

if ! command -v cargo &> /dev/null; then
    echo "Installing Rust..."
    curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh -s -- -y
    source "$HOME/.cargo/env"
fi

CARGO_PACKAGES=(
    duf
    nerdfix
    viu
    scc
)

for package in "${CARGO_PACKAGES[@]}"; do
    echo "Installing cargo package: $package..."
    cargo install "$package" || echo "  Warning: Failed to install $package"
done

# ========================================
# Python packages via uv
# ========================================
echo ""
echo "========================================"
echo "Installing Python Packages via uv"
echo "========================================"
echo ""

# Install Python via uv
uv python install 3.12

# Install pipx-like global tools using uv tool
UV_TOOLS=(
    neovim-remote
    pre-commit
    black
    isort
    ruff
    rich-cli
    glances
    bpytop
    httpie
    asciinema
)

for tool in "${UV_TOOLS[@]}"; do
    echo "Installing uv tool: $tool..."
    uv tool install "$tool" || echo "  Warning: Failed to install $tool"
done

# ========================================
# Setup neovim Python environments
# ========================================
echo ""
echo "========================================"
echo "Setting up Neovim Python Environments"
echo "========================================"
echo ""

rm -rf ~/.local/share/uv/venvs/neovim2 2>/dev/null
rm -rf ~/.local/share/uv/venvs/neovim3 2>/dev/null

uv venv ~/.local/share/uv/venvs/neovim2 --python 3.12
uv venv ~/.local/share/uv/venvs/neovim3 --python 3.12

# Install neovim packages in both venvs
for venv in neovim2 neovim3; do
    source ~/.local/share/uv/venvs/$venv/bin/activate
    uv pip install neovim flake8
    deactivate
done

source ~/.local/share/uv/venvs/neovim3/bin/activate
uv pip install neovim-remote
deactivate

# ========================================
# Node.js packages
# ========================================
echo ""
echo "========================================"
echo "Installing Node.js Global Packages"
echo "========================================"
echo ""

NODE_PACKAGES=(
    yarn
    prettier
    eslint
    typescript
    neovim
    write-good
)

for package in "${NODE_PACKAGES[@]}"; do
    echo "Installing npm package: $package..."
    sudo npm install -g "$package" || echo "  Warning: Failed to install $package"
done

# ========================================
# Go packages
# ========================================
echo ""
echo "========================================"
echo "Installing Go Packages"
echo "========================================"
echo ""

go install github.com/andremueller/md-publisher@latest || echo "  Warning: Failed to install md-publisher"

# ========================================
# AI Coding Assistants (OpenCode, Claude Code)
# ========================================
echo ""
echo "========================================"
echo "Installing AI Coding Assistants"
echo "========================================"
echo ""

# Install OpenCode CLI
echo "Installing OpenCode..."
if command -v npm &> /dev/null; then
    sudo npm install -g @anthropic/opencode || echo "  Warning: Failed to install OpenCode via npm"
else
    echo "  Note: npm not available, skipping OpenCode npm install"
fi

# Alternative: Install via Homebrew if available
if command -v brew &> /dev/null; then
    brew install opencode || echo "  Note: OpenCode may already be installed or unavailable via brew"
fi

# Install Claude Code CLI (Anthropic's official CLI)
echo "Installing Claude Code..."
if command -v npm &> /dev/null; then
    sudo npm install -g @anthropic/claude-code || echo "  Warning: Failed to install Claude Code via npm"
else
    echo "  Note: npm not available, skipping Claude Code npm install"
fi

# ========================================
# Shell setup
# ========================================
echo ""
echo "========================================"
echo "Setting up Shell"
echo "========================================"
echo ""

# Install antigen for zsh
mkdir -p ~/antigen
curl -L git.io/antigen > ~/antigen/antigen.zsh

# ========================================
# Java with SDKMAN (version manager)
# ========================================
echo ""
echo "========================================"
echo "Installing Java with SDKMAN"
echo "========================================"
echo ""

# Install SDKMAN
if [ ! -d "$HOME/.sdkman" ]; then
    echo "Installing SDKMAN..."
    curl -s "https://get.sdkman.io" | bash
fi

# Source SDKMAN
export SDKMAN_DIR="$HOME/.sdkman"
[[ -s "$HOME/.sdkman/bin/sdkman-init.sh" ]] && source "$HOME/.sdkman/bin/sdkman-init.sh"

# Install latest Java LTS versions
echo "Installing Java versions..."
sdk install java 21-tem || echo "  Warning: Failed to install Java 21"
sdk install java 17-tem || echo "  Warning: Failed to install Java 17"
sdk install java 11-tem || echo "  Warning: Failed to install Java 11"

# Set Java 21 as default
sdk default java 21-tem || true

echo ""
echo "SDKMAN installed. Use 'sdk list java' to see available versions."
echo "Use 'sdk install java <version>' to install a specific version."
echo "Use 'sdk use java <version>' to switch versions."

# ========================================
# Stow Dotfiles
# ========================================
echo ""
echo "========================================"
echo "Stowing Dotfiles"
echo "========================================"
echo ""

# Function to safely stow a package, handling conflicts
stow_package() {
    local stow_dir="$1"
    local package="$2"
    local target="$HOME"
    
    echo "  Stowing $package..."
    
    # First, try to stow normally
    if stow --dir="$stow_dir" --target="$target" -R "$package" 2>/dev/null; then
        return 0
    fi
    
    # If that failed, check for conflicts and back them up
    echo "    Checking for conflicts in $package..."
    for file in "$stow_dir/$package"/.* "$stow_dir/$package"/*; do
        [ -e "$file" ] || continue
        local basename=$(basename "$file")
        [ "$basename" = "." ] || [ "$basename" = ".." ] && continue
        
        local target_file="$target/$basename"
        if [ -e "$target_file" ] && [ ! -L "$target_file" ]; then
            echo "    Backing up existing $basename to $basename.bak"
            mv "$target_file" "$target_file.bak"
        fi
    done
    
    # Try stow again after backing up conflicts
    stow --dir="$stow_dir" --target="$target" -R "$package" || echo "    Warning: Failed to stow $package"
}

# Stow base configs (cross-platform)
echo "Stowing base configs..."
BASE_DIR="$SCRIPT_DIR/base"
for d in "$BASE_DIR"/*/; do
    [ -d "$d" ] || continue
    package=$(basename "$d")
    stow_package "$BASE_DIR" "$package"
done

# Stow Linux-specific configs
if [ -d "$SCRIPT_DIR/linux" ]; then
    echo "Stowing Linux-specific configs..."
    LINUX_DIR="$SCRIPT_DIR/linux"
    for d in "$LINUX_DIR"/*/; do
        [ -d "$d" ] || continue
        package=$(basename "$d")
        stow_package "$LINUX_DIR" "$package"
    done
fi

# ========================================
# Optional: Install WSL2 GUI Applications
# ========================================
echo ""
echo "========================================"
echo "WSL2 GUI Applications (Optional)"
echo "========================================"
echo ""

if [ -f "$SCRIPT_DIR/setup-wsl-gui.sh" ]; then
    read -p "Do you want to install GUI applications? (WSL2 with WSLg required) [y/N] " install_gui
    case $install_gui in
        [Yy]* )
            echo "Installing GUI applications..."
            export SUDO_VALIDATED=1
            chmod +x "$SCRIPT_DIR/setup-wsl-gui.sh"
            "$SCRIPT_DIR/setup-wsl-gui.sh"
            ;;
        * )
            echo "Skipping GUI applications."
            echo "You can install them later by running: ./setup-wsl-gui.sh"
            ;;
    esac
else
    echo "Warning: setup-wsl-gui.sh not found. Skipping GUI installation."
fi

# ========================================
# Final summary
# ========================================
echo ""
echo "========================================"
echo "Installation Complete!"
echo "========================================"
echo ""
echo "Next Steps:"
echo "1. Close and reopen your terminal to refresh PATH"
echo "2. Change your default shell: chsh -s \$(which zsh)"
echo "3. Open nvim - lazy.nvim will auto-install plugins on first run"
echo ""
echo "Neovim Python environments:"
echo "  neovim2: ~/.local/share/uv/venvs/neovim2/bin/python"
echo "  neovim3: ~/.local/share/uv/venvs/neovim3/bin/python"
echo ""
echo "Java version management (SDKMAN):"
echo "  sdk list java          # List available versions"
echo "  sdk install java X     # Install a version"
echo "  sdk use java X         # Switch to a version"
echo ""
echo "AI Coding Assistants:"
echo "  opencode               # OpenCode CLI"
echo "  claude                 # Claude Code CLI"
echo ""
echo "IMPORTANT - Fonts:"
echo "  For proper icon display in starship prompt and Neovim,"
echo "  you need a Nerd Font configured in your terminal."
echo ""
echo "  For WSL, install fonts on Windows and configure Windows Terminal:"
echo "    1. Download JetBrainsMono Nerd Font from:"
echo "       https://github.com/ryanoasis/nerd-fonts/releases"
echo "    2. Extract and right-click -> 'Install for all users'"
echo "    3. In Windows Terminal: Settings > Profiles > Defaults > Appearance"
echo "       > Font face > 'JetBrainsMono Nerd Font'"
echo ""
echo "  Verify fonts work by running: echo -e '\\uf015 \\uf07c \\ue606'"
echo "  You should see a house, folder, and Node.js icon."
echo ""
echo "WSL-specific notes:"
echo "  - Use Windows Terminal for best experience"
echo "  - GUI apps supported via WSLg (run ./setup-wsl-gui.sh to install)"
echo "  - Use 'wslview' or 'xdg-open' to open files in Windows apps"
echo ""
