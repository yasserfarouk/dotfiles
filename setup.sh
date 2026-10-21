#!/usr/bin/env bash
# Unified Install Script
# Detects the platform and runs the appropriate setup script

set -e

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

# Function to stow dotfiles
stow_dotfiles() {
    echo ""
    echo "========================================"
    echo "Stowing Dotfiles"
    echo "========================================"
    echo ""
    
    # Stow base configs (cross-platform)
    echo "Stowing base configs..."
    cd "$SCRIPT_DIR/base"
    if [ -f "./stowall" ]; then
        chmod +x ./stowall
        ./stowall
    else
        for d in */ ; do
            stow -v -R -t ~ "$d" || echo "Warning: Failed to stow $d"
        done
    fi
    
    # Stow platform-specific configs
    case $PLATFORM in
        macos)
            if [ -d "$SCRIPT_DIR/mac" ]; then
                echo "Stowing macOS-specific configs..."
                cd "$SCRIPT_DIR/mac"
                if [ -f "./stowall" ]; then
                    chmod +x ./stowall
                    ./stowall
                else
                    for d in */ ; do
                        stow -v -R -t ~ "$d" || echo "Warning: Failed to stow $d"
                    done
                fi
            fi
            ;;
        linux|wsl)
            if [ -d "$SCRIPT_DIR/linux" ]; then
                echo "Stowing Linux-specific configs..."
                cd "$SCRIPT_DIR/linux"
                if [ -f "./stowall" ]; then
                    chmod +x ./stowall
                    ./stowall
                else
                    for d in */ ; do
                        stow -v -R -t ~ "$d" || echo "Warning: Failed to stow $d"
                    done
                fi
            fi
            ;;
    esac
    
    cd "$SCRIPT_DIR"
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
    bash "$SCRIPT_DIR/quick-install.sh"
fi

echo ""
echo "========================================"
echo "Setup Complete!"
echo "========================================"
echo ""
echo "Platform: $PLATFORM"
echo ""
echo "Next steps:"
echo "  1. Restart your terminal"
echo "  2. Change shell to zsh: chsh -s \$(which zsh)"
echo "  3. Open nvim - lazy.nvim will auto-install plugins"
echo ""
