#!/usr/bin/env bash
# WSL2 GUI Applications Setup Script
# This script installs GUI applications for WSL2 (requires WSLg support)
# Can be run standalone or called from wsl-setup.sh

set -e

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

echo "========================================"
echo "WSL2 GUI Applications Setup"
echo "========================================"
echo ""

# Check if we're running in WSL2
if ! grep -qi microsoft /proc/version 2>/dev/null; then
    echo "Warning: This script is designed for WSL2. Proceeding anyway..."
fi

# Get sudo password early so the script can run unattended
if [ -z "$SUDO_VALIDATED" ]; then
    echo "This script requires sudo access. Please enter your password now."
    sudo -v
    # Keep sudo alive throughout the script
    while true; do sudo -n true; sleep 60; kill -0 "$$" || exit; done 2>/dev/null &
fi

# Detect package manager
detect_package_manager() {
    if command -v apt &> /dev/null; then
        PKG_MANAGER="apt"
        PKG_INSTALL="sudo apt install -y"
        PKG_UPDATE="sudo apt update"
    elif command -v dnf &> /dev/null; then
        PKG_MANAGER="dnf"
        PKG_INSTALL="sudo dnf install -y"
        PKG_UPDATE="sudo dnf check-update || true"
    elif command -v pacman &> /dev/null; then
        PKG_MANAGER="pacman"
        PKG_INSTALL="sudo pacman -S --noconfirm"
        PKG_UPDATE="sudo pacman -Sy"
    else
        echo "ERROR: No supported package manager found (apt, dnf, or pacman)"
        exit 1
    fi
    echo "Detected package manager: $PKG_MANAGER"
}

detect_package_manager

# Update package lists
echo ""
echo "Updating package lists..."
eval $PKG_UPDATE

# ========================================
# GUI Applications
# ========================================
echo ""
echo "========================================"
echo "Installing GUI Applications"
echo "========================================"
echo ""

case $PKG_MANAGER in
    apt)
        GUI_PACKAGES=(
            kitty
            inkscape
            vlc
        )
        ;;
    dnf)
        GUI_PACKAGES=(
            kitty
            inkscape
            vlc
        )
        ;;
    pacman)
        GUI_PACKAGES=(
            kitty
            wezterm
            inkscape
            vlc
            dbeaver
        )
        ;;
esac

for package in "${GUI_PACKAGES[@]}"; do
    echo "Installing GUI package: $package..."
    $PKG_INSTALL "$package" || echo "  Warning: Failed to install $package"
done

# ========================================
# Install VS Code
# ========================================
echo ""
echo "========================================"
echo "Installing Visual Studio Code"
echo "========================================"
echo ""

case $PKG_MANAGER in
    apt)
        # Install VS Code via Microsoft repository
        wget -qO- https://packages.microsoft.com/keys/microsoft.asc | gpg --dearmor > packages.microsoft.gpg
        sudo install -D -o root -g root -m 644 packages.microsoft.gpg /etc/apt/keyrings/packages.microsoft.gpg
        echo "deb [arch=amd64,arm64,armhf signed-by=/etc/apt/keyrings/packages.microsoft.gpg] https://packages.microsoft.com/repos/code stable main" | sudo tee /etc/apt/sources.list.d/vscode.list > /dev/null
        rm -f packages.microsoft.gpg
        sudo apt update
        sudo apt install -y code
        ;;
    dnf)
        sudo rpm --import https://packages.microsoft.com/keys/microsoft.asc
        echo -e "[code]\nname=Visual Studio Code\nbaseurl=https://packages.microsoft.com/yumrepos/vscode\nenabled=1\ngpgcheck=1\ngpgkey=https://packages.microsoft.com/keys/microsoft.asc" | sudo tee /etc/yum.repos.d/vscode.repo > /dev/null
        sudo dnf install -y code
        ;;
    pacman)
        # VS Code is available in AUR, try with yay or paru
        if command -v yay &> /dev/null; then
            yay -S --noconfirm visual-studio-code-bin
        elif command -v paru &> /dev/null; then
            paru -S --noconfirm visual-studio-code-bin
        else
            echo "  Note: Install yay or paru to install VS Code from AUR"
            echo "  Or install manually from https://code.visualstudio.com/"
        fi
        ;;
esac

# ========================================
# Install Flatpak and GUI apps via Flatpak
# ========================================
echo ""
echo "========================================"
echo "Installing Flatpak Applications"
echo "========================================"
echo ""

case $PKG_MANAGER in
    apt)
        sudo apt install -y flatpak
        ;;
    dnf)
        sudo dnf install -y flatpak
        ;;
    pacman)
        sudo pacman -S --noconfirm flatpak
        ;;
esac

# Add Flathub repository
sudo flatpak remote-add --if-not-exists flathub https://dl.flathub.org/repo/flathub.flatpakrepo

# Install GUI apps via Flatpak
echo "Installing WezTerm via Flatpak..."
flatpak install -y flathub org.wezfurlong.wezterm || echo "  Warning: Failed to install WezTerm"

echo "Installing DBeaver via Flatpak..."
flatpak install -y flathub io.dbeaver.DBeaverCommunity || echo "  Warning: Failed to install DBeaver"

# ========================================
# Install Nerd Fonts
# ========================================
echo ""
echo "========================================"
echo "Installing Nerd Fonts"
echo "========================================"
echo ""

mkdir -p ~/.local/share/fonts
cd ~/.local/share/fonts

# JetBrains Mono Nerd Font
echo "Installing JetBrains Mono Nerd Font..."
curl -fLo "JetBrains Mono Nerd Font.zip" https://github.com/ryanoasis/nerd-fonts/releases/download/v3.1.1/JetBrainsMono.zip
unzip -o "JetBrains Mono Nerd Font.zip" -d JetBrainsMono
rm "JetBrains Mono Nerd Font.zip"

# Hack Nerd Font
echo "Installing Hack Nerd Font..."
curl -fLo "Hack Nerd Font.zip" https://github.com/ryanoasis/nerd-fonts/releases/download/v3.1.1/Hack.zip
unzip -o "Hack Nerd Font.zip" -d Hack
rm "Hack Nerd Font.zip"

fc-cache -fv

cd "$SCRIPT_DIR"

# ========================================
# Final summary
# ========================================
echo ""
echo "========================================"
echo "WSL2 GUI Installation Complete!"
echo "========================================"
echo ""
echo "Installed:"
echo "  - GUI applications (kitty, inkscape, vlc)"
echo "  - Visual Studio Code"
echo "  - Flatpak apps (WezTerm, DBeaver)"
echo "  - Nerd Fonts (JetBrains Mono, Hack)"
echo ""
echo "WSL2 GUI Notes:"
echo "  - WSLg should handle X11/Wayland automatically"
echo "  - If GUI apps don't work, ensure you have WSL2 with WSLg support"
echo "  - Run 'wsl --update' in Windows PowerShell to update WSL"
echo ""
