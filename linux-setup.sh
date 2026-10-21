#!/usr/bin/env bash
# Linux Setup Script
# Installs the tools referenced by the dotfiles (see the Brewfile for the macOS equivalent).
# Supports apt (Debian/Ubuntu), dnf (Fedora) and pacman (Arch).
#
# Root is used as little as possible: only for a handful of distro packages
# (zsh, compilers, ruby/perl, optional extras, GUI apps) and only if sudo works.
# Everything else is installed into ~/.local, ~/.cargo or ~/.nvm. Set NO_SUDO=1 to skip root entirely.
# Idempotent: already-installed tools are skipped.

set -e

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
# shellcheck source=lib/linux-common.sh
source "$SCRIPT_DIR/lib/linux-common.sh"

echo "========================================"
echo "Linux Development Environment Setup"
echo "========================================"
echo ""

detect_root
detect_package_manager

section "Locale and Required System Packages (root, optional)"
setup_locale
install_system_required

install_priority_tools
install_user_cli_tools

section "Optional Distro Extras (root, optional)"
install_system_optional
# clipboard helper used by tmux.conf on X11 desktops
if [ -n "${DISPLAY:-}" ] || [ -n "${WAYLAND_DISPLAY:-}" ]; then
    have xclip || have xsel || sys_install xclip 2>/dev/null || true
fi

install_tmuxinator
install_language_tools
install_ai_assistants

# ========================================
# GUI Applications (Desktop Linux only)
# ========================================
section "Installing GUI Applications"

if [ -n "${DISPLAY:-}" ] || [ -n "${WAYLAND_DISPLAY:-}" ]; then
    # kitty: official user-level installer (no root), lands in ~/.local/kitty.app
    if have kitty || [ -x "$HOME/.local/kitty.app/bin/kitty" ]; then
        echo "  kitty already installed"
    else
        echo "Installing kitty (user-level)..."
        if curl -fsSL https://sw.kovidgoyal.net/kitty/installer.sh | sh /dev/stdin launch=n; then
            ln -sf "$HOME/.local/kitty.app/bin/kitty" "$HOME/.local/kitty.app/bin/kitten" "$LOCAL_BIN/"
        else
            warn "kitty install failed"
        fi
    fi

    # wezterm: flatpak in user mode (no root once flatpak itself exists)
    if ! have flatpak; then
        sys_install flatpak 2>/dev/null || echo "  Note: flatpak not available (needs root), skipping wezterm"
    fi
    if have flatpak; then
        flatpak remote-add --user --if-not-exists flathub https://dl.flathub.org/repo/flathub.flatpakrepo || true
        flatpak install --user -y flathub org.wezfurlong.wezterm || true
    fi

    # The rest are distro packages and need root
    if [ "$HAVE_ROOT" -eq 1 ]; then
        echo "Installing Visual Studio Code..."
        case $PKG_MANAGER in
            apt)
                if ! have code; then
                    wget -qO- https://packages.microsoft.com/keys/microsoft.asc | gpg --dearmor > packages.microsoft.gpg
                    $SUDO install -D -o root -g root -m 644 packages.microsoft.gpg /etc/apt/keyrings/packages.microsoft.gpg
                    echo "deb [arch=amd64,arm64,armhf signed-by=/etc/apt/keyrings/packages.microsoft.gpg] https://packages.microsoft.com/repos/code stable main" | $SUDO tee /etc/apt/sources.list.d/vscode.list > /dev/null
                    rm -f packages.microsoft.gpg
                    $SUDO apt-get update
                    sys_install code
                fi
                GUI_PACKAGES=(inkscape vlc)
                ;;
            dnf)
                if ! have code; then
                    $SUDO rpm --import https://packages.microsoft.com/keys/microsoft.asc
                    echo -e "[code]\nname=Visual Studio Code\nbaseurl=https://packages.microsoft.com/yumrepos/vscode\nenabled=1\ngpgcheck=1\ngpgkey=https://packages.microsoft.com/keys/microsoft.asc" | $SUDO tee /etc/yum.repos.d/vscode.repo > /dev/null
                    sys_install code
                fi
                GUI_PACKAGES=(inkscape vlc)
                ;;
            pacman)
                if have yay; then
                    yay -S --needed --noconfirm visual-studio-code-bin
                elif have paru; then
                    paru -S --needed --noconfirm visual-studio-code-bin
                else
                    echo "  Note: Install yay or paru to install VS Code from AUR"
                fi
                GUI_PACKAGES=(inkscape vlc dbeaver)
                ;;
        esac
        sys_install_each "${GUI_PACKAGES[@]}"
        have flatpak && flatpak install --user -y flathub io.dbeaver.DBeaverCommunity || true
    else
        echo "No root: skipping VS Code, inkscape, vlc."
    fi
else
    echo "No display detected. Skipping GUI applications."
fi

install_nerd_fonts JetBrainsMono Hack

install_shell_extras 21-tem 17-tem

# ========================================
# Stow Dotfiles
# ========================================
echo ""
echo "========================================"
echo "Stowing Dotfiles"
echo "========================================"
echo ""

cd "$SCRIPT_DIR/base"
chmod +x ./stowall 2>/dev/null || true
./stowall 2>/dev/null || for d in */ ; do stow -v -R -t ~ "$d" || true; done

if [ -d "$SCRIPT_DIR/linux" ]; then
    cd "$SCRIPT_DIR/linux"
    chmod +x ./stowall 2>/dev/null || true
    ./stowall 2>/dev/null || for d in */ ; do stow -v -R -t ~ "$d" || true; done
fi

cd "$SCRIPT_DIR"

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
echo "3. Open nvim - lazy.nvim will auto-install plugins"
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
echo "  Nerd Fonts have been installed to ~/.local/share/fonts/"
echo "  Configure your terminal to use 'JetBrainsMono Nerd Font'"
echo "  for proper icon display in starship prompt and Neovim."
echo ""
echo "  Verify fonts work by running: echo -e '\\uf015 \\uf07c \\ue606'"
echo "  You should see a house, folder, and Node.js icon."
echo ""
