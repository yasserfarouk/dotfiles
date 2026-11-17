#!/usr/bin/env bash
# Unified Install Script
# Detects the platform and runs the appropriate setup script, stows the dotfiles, then ./quick-install.sh.
# Usage: ./setup.sh [--zsh | --bash | --shell=zsh|bash|auto]   (passed on to quick-install.sh;
#   no option = auto: zsh if installed, else install it when root is available, else bash)

set -e

QUICK_ARGS=()
for a in "$@"; do
    case $a in
        --zsh|--bash|--shell=*) QUICK_ARGS+=("$a") ;;
        -h|--help) sed -n '2,4p' "$0" | sed 's/^# \{0,1\}//'; exit 0 ;;
        *) echo "Unknown option: $a" >&2; exit 2 ;;
    esac
done

echo "========================================"
echo "Dotfiles Setup - Platform Detection"
echo "========================================"
echo ""

# Detect the platform
detect_platform() {
    case "$(uname -s)" in
        Darwin)
            PLATFORM="macos"
            ;;
        Linux)
            # Check if running in WSL
            if grep -qEi "(Microsoft|WSL)" /proc/version 2>/dev/null; then
                PLATFORM="wsl"
            else
                PLATFORM="linux"
            fi
            ;;
        CYGWIN*|MINGW*|MSYS*)
            PLATFORM="windows"
            ;;
        *)
            echo "ERROR: Unknown platform: $(uname -s)"
            exit 1
            ;;
    esac
    echo "Detected platform: $PLATFORM"
}

detect_platform

# Get the directory where this script is located
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

# shellcheck source=lib/dotfiles-shell.sh
source "$SCRIPT_DIR/lib/dotfiles-shell.sh"

# Stow base/ and the platform folder (real dotfiles from /etc/skel are moved aside to NAME.pre-dotfiles)
stow_dotfiles() {
    echo ""
    echo "========================================"
    echo "Stowing Dotfiles"
    echo "========================================"
    echo ""
    stow_packages "$SCRIPT_DIR/base" || true
    case $PLATFORM in
        macos) stow_packages "$SCRIPT_DIR/mac" || true ;;
        linux|wsl) stow_packages "$SCRIPT_DIR/linux" || true ;;
    esac
}

case $PLATFORM in
    macos)
        echo ""
        echo "Running macOS setup..."
        echo "This will use Homebrew and the Brewfile"
        echo ""
        
        # install.sh bootstraps Homebrew, runs `brew bundle` (no cleanup) and
        # the user-level post-install steps. No sudo except the Homebrew bootstrap.
        if [ -f "$SCRIPT_DIR/install.sh" ]; then
            bash "$SCRIPT_DIR/install.sh"
        else
            echo "ERROR: install.sh not found"
            exit 1
        fi
        ;;
        
    linux)
        echo ""
        echo "Running Linux setup (with GUI apps)..."
        echo ""
        
        if [ -f "$SCRIPT_DIR/linux-setup.sh" ]; then
            bash "$SCRIPT_DIR/linux-setup.sh"
        else
            echo "ERROR: linux-setup.sh not found"
            exit 1
        fi
        ;;
        
    wsl)
        echo ""
        echo "Running WSL setup (CLI only, no GUI apps)..."
        echo ""
        
        if [ -f "$SCRIPT_DIR/wsl-setup.sh" ]; then
            bash "$SCRIPT_DIR/wsl-setup.sh"
        else
            echo "ERROR: wsl-setup.sh not found"
            exit 1
        fi
        ;;
        
    windows)
        echo ""
        echo "Detected Windows (Git Bash/MSYS/Cygwin)"
        echo "Please run windows-setup.ps1 in PowerShell instead:"
        echo ""
        echo "  powershell -ExecutionPolicy Bypass -File windows-setup.ps1"
        echo ""
        exit 0
        ;;
esac

# Stow dotfiles after packages are installed
stow_dotfiles

# Enable versioned git hooks (gitleaks secret scanning)
git -C "$SCRIPT_DIR" config core.hooksPath .githooks

# Fetch tmux plugins listed in ~/.tmux.conf (tpm itself is cloned by the platform installers)
if [ -x "$HOME/.tmux/plugins/tpm/bin/install_plugins" ] && command -v tmux >/dev/null 2>&1; then
    echo "Installing tmux plugins..."
    "$HOME/.tmux/plugins/tpm/bin/install_plugins" || echo "Warning: tpm plugin install failed (press prefix + I inside tmux)"
fi

# Run quick-install for final setup (vim plugins, etc.)
echo ""
echo "========================================"
echo "Running Final Setup"
echo "========================================"
echo ""

if [ -f "$SCRIPT_DIR/quick-install.sh" ]; then
    bash "$SCRIPT_DIR/quick-install.sh" ${QUICK_ARGS[@]+"${QUICK_ARGS[@]}"}
fi

echo ""
echo "========================================"
echo "Setup Complete!"
echo "========================================"
echo ""
echo "Platform: $PLATFORM"
echo ""
echo "Next steps:"
echo "  1. Restart your terminal (or log out and in, if the login shell changed)"
echo "  2. Open nvim - lazy.nvim will auto-install plugins"
echo "  Switch shells later with ./quick-install.sh --zsh or --bash"
echo ""
