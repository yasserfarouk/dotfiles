#!/usr/bin/env bash
# Shared by setup.sh, quick-install.sh, qupdate, linux-setup.sh and wsl-setup.sh (source it, do not run it).
#
#   stow_packages DIR        stow every package in DIR into $HOME (moving pre-existing real dotfiles aside)
#   choose_shell [MODE]      MODE zsh | bash | auto (default): sets DOTFILES_SHELL
#   save_shell_choice        writes DOTFILES_SHELL to ~/.config/dotfiles-shell (per machine, not in the repo)
#   saved_shell_choice       prints the recorded choice, if any
#   set_login_shell          chsh to DOTFILES_SHELL when possible; never fatal
#   parse_shell_arg ARG      --zsh / --bash / --shell=zsh|bash|auto → SHELL_MODE (returns 1 if ARG isn't one)
#
# auto: zsh when it is installed; otherwise install it when root is available (root = always zsh); otherwise bash.
# The choice file is read by ~/bin/preferred-shell (tmux, kitty) and ~/.bash_profile (zsh hand-off when chsh failed).

DOTFILES_SHELL_FILE="${DOTFILES_SHELL_FILE:-$HOME/.config/dotfiles-shell}"

_have() { command -v "$1" >/dev/null 2>&1; }
_warn() { echo "  Warning: $*" >&2; }

# Stow every package in DIR into $HOME. A fresh account already has real ~/.bashrc, ~/.profile, ~/.bash_logout…
# from /etc/skel, and stow refuses a whole package on any such conflict, so regular files directly in $HOME that a
# package would link are first moved to NAME.pre-dotfiles (NAME.pre-dotfiles.<time> if that exists).
stow_packages() {
    local dir=$1 pkg f name target bak failed=0
    [ -d "$dir" ] || return 0
    if ! _have stow; then
        _warn "stow not found, cannot link the packages in $dir"
        return 1
    fi
    for pkg in "$dir"/*/; do
        pkg=${pkg%/}
        for f in "$pkg"/.[!.]* "$pkg"/*; do
            [ -e "$f" ] || [ -L "$f" ] || continue
            name=${f##*/}
            [ "$name" = .DS_Store ] && continue
            target=$HOME/$name
            if [ -f "$target" ] && [ ! -L "$target" ] && ! [ "$target" -ef "$f" ]; then
                bak=$target.pre-dotfiles
                [ -e "$bak" ] && bak=$bak.$(date +%Y%m%d%H%M%S)
                mv "$target" "$bak" && echo "  moved existing ~/$name to ${bak/#$HOME/~}"
            fi
        done
        if ! (cd "$dir" && stow -R -t "$HOME" "${pkg##*/}"); then
            _warn "failed to stow ${pkg##*/} (from $dir)"
            failed=1
        fi
    done
    return $failed
}

parse_shell_arg() {
    case $1 in
        --zsh) SHELL_MODE=zsh ;;
        --bash) SHELL_MODE=bash ;;
        --shell=*) SHELL_MODE=${1#--shell=} ;;
        *) return 1 ;;
    esac
    case $SHELL_MODE in
        zsh|bash|auto) ;;
        *) echo "ERROR: unknown shell '$SHELL_MODE' (use zsh, bash or auto)" >&2; exit 2 ;;
    esac
}

saved_shell_choice() {
    local s
    s=$(cat "$DOTFILES_SHELL_FILE" 2>/dev/null) || return 1
    case $s in zsh|bash) echo "$s" ;; *) return 1 ;; esac
}

save_shell_choice() {
    mkdir -p "$(dirname "$DOTFILES_SHELL_FILE")"
    echo "$DOTFILES_SHELL" >"$DOTFILES_SHELL_FILE"
}

# Root without asking when possible: we are root, or sudo works without a password. On a terminal, offer sudo
# once (default no), so a machine without root never hangs on a password prompt.
_ROOT_CMD=unset
_root_cmd() {
    if [ "$_ROOT_CMD" = unset ]; then
        _ROOT_CMD=none
        if [ -n "${NO_SUDO:-}" ]; then
            :
        elif [ "$(id -u)" -eq 0 ]; then
            _ROOT_CMD=
        elif _have sudo && sudo -n true 2>/dev/null; then
            _ROOT_CMD=sudo
        elif _have sudo && [ -t 0 ]; then
            local ans
            read -r -p "zsh is not installed. Use sudo to install it? [y/N] " ans
            case $ans in [Yy]*) sudo -v && _ROOT_CMD=sudo ;; esac
        fi
    fi
    [ "$_ROOT_CMD" != none ]
}

_install_zsh() {
    _have zsh && return 0
    case "$(uname -s)" in Linux) ;; *) return 1 ;; esac
    _root_cmd || return 1
    echo "Installing zsh (root)..."
    local s=$_ROOT_CMD
    if _have apt-get; then $s apt-get update -qq && $s apt-get install -y zsh
    elif _have dnf; then $s dnf install -y zsh
    elif _have yum; then $s yum install -y zsh
    elif _have pacman; then $s pacman -S --needed --noconfirm zsh
    elif _have zypper; then $s zypper install -y zsh
    elif _have apk; then $s apk add zsh
    else return 1
    fi
    hash -r
    _have zsh
}

choose_shell() {
    local mode=${1:-auto}
    case $mode in
        zsh)
            if ! _install_zsh; then
                echo "ERROR: --zsh: zsh is not installed and cannot be installed (no root). Use --bash or leave it out." >&2
                return 1
            fi ;;
        bash) ;;
        auto)
            if _install_zsh; then mode=zsh; else mode=bash; fi ;;
        *) echo "ERROR: unknown shell '$mode'" >&2; return 1 ;;
    esac
    DOTFILES_SHELL=$mode
    echo "Shell: $DOTFILES_SHELL"
}

_current_login_shell() {
    local s=
    if _have getent; then s=$(getent passwd "$(id -un)" 2>/dev/null | cut -d: -f7); fi
    if [ -z "$s" ] && _have dscl; then s=$(dscl . -read "/Users/$(id -un)" UserShell 2>/dev/null | awk '{print $2}'); fi
    echo "${s:-$SHELL}"
}

# chsh to DOTFILES_SHELL. Fails softly (no chsh, shell not in /etc/shells without root, LDAP accounts, …): with zsh
# chosen, ~/.bash_profile then hands interactive bash logins over to zsh.
set_login_shell() {
    local path current
    path=$(command -v "$DOTFILES_SHELL") || { _warn "$DOTFILES_SHELL not found"; return 1; }
    current=$(_current_login_shell)
    if [ "${current##*/}" = "$DOTFILES_SHELL" ]; then
        echo "Login shell is already $current"
        return 0
    fi
    if [ -r /etc/shells ] && ! grep -qx "$path" /etc/shells; then
        if _root_cmd; then
            echo "$path" | $_ROOT_CMD tee -a /etc/shells >/dev/null
        else
            _warn "$path is not in /etc/shells and there is no root to add it; login shell stays $current"
            return 1
        fi
    fi
    echo "Changing login shell to $path (may ask for your password)"
    if ! _have chsh || ! chsh -s "$path"; then
        _warn "could not change the login shell; it stays $current"
        [ "$DOTFILES_SHELL" = zsh ] && echo "  bash logins will hand over to zsh (see ~/.bash_profile)"
        return 1
    fi
    echo "You will need to log out for this to take effect"
}
