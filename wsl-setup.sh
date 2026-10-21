#!/usr/bin/env bash
# WSL Setup Script
# Installs the CLI tools referenced by the dotfiles (no GUI apps; see setup-wsl-gui.sh for WSLg).
# Supports apt (Debian/Ubuntu), dnf (Fedora) and pacman (Arch).
#
# Root is used as little as possible: only for a handful of distro packages
# (zsh, compilers, ruby/perl, optional extras) and only if sudo works.
# Everything else is installed into ~/.local, ~/.cargo or ~/.nvm. Set NO_SUDO=1 to skip root entirely.
# Idempotent: already-installed tools are skipped.

set -e

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
# shellcheck source=lib/linux-common.sh
source "$SCRIPT_DIR/lib/linux-common.sh"

echo "========================================"
echo "WSL Development Environment Setup"
echo "========================================"
echo ""

detect_root
detect_package_manager

section "Locale and Required System Packages (root, optional)"
setup_locale
install_system_required

# stow first so dotfiles can be stowed even if later steps fail
install_priority_tools
install_user_cli_tools

section "Optional Distro Extras (root, optional)"
install_system_optional

install_tmuxinator
install_language_tools
install_ai_assistants
install_shell_extras 21-tem 17-tem 11-tem

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
            [ "$HAVE_ROOT" -eq 1 ] && export SUDO_VALIDATED=1
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

install_nerd_fonts JetBrainsMono

install_tpm_plugins
enable_git_hooks

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
