# Windows Setup Script
# This script installs applications equivalent to the macOS Brewfile
# Prefers Scoop when possible, falls back to winget or chocolatey

# Requires PowerShell to be run as Administrator for some installations

Write-Host "========================================" -ForegroundColor Cyan
Write-Host "Windows Development Environment Setup" -ForegroundColor Cyan
Write-Host "========================================" -ForegroundColor Cyan
Write-Host ""

# Function to check if running as administrator
function Test-Administrator {
    $currentUser = New-Object Security.Principal.WindowsPrincipal([Security.Principal.WindowsIdentity]::GetCurrent())
    return $currentUser.IsInRole([Security.Principal.WindowsBuiltInRole]::Administrator)
}

if (-not (Test-Administrator)) {
    Write-Host "WARNING: Not running as Administrator. Some installations may fail." -ForegroundColor Yellow
    Write-Host "Consider running PowerShell as Administrator for best results." -ForegroundColor Yellow
    Write-Host ""
    $continue = Read-Host "Continue anyway? (y/n)"
    if ($continue -ne 'y') {
        exit
    }
}

# Install Scoop if not already installed
Write-Host "Checking for Scoop..." -ForegroundColor Green
if (!(Get-Command scoop -ErrorAction SilentlyContinue)) {
    Write-Host "Installing Scoop..." -ForegroundColor Yellow
    Set-ExecutionPolicy -ExecutionPolicy RemoteSigned -Scope CurrentUser -Force
    Invoke-RestMethod -Uri https://get.scoop.sh | Invoke-Expression
    
    # Add extra buckets
    scoop bucket add extras
    scoop bucket add versions
    scoop bucket add nerd-fonts
    scoop bucket add java
} else {
    Write-Host "Scoop is already installed." -ForegroundColor Green
}

# Update Scoop
Write-Host "Updating Scoop..." -ForegroundColor Yellow
scoop update

# ========================================
# PRIORITY 1: Essential tools (uv, neovim)
# ========================================
Write-Host ""
Write-Host "========================================" -ForegroundColor Cyan
Write-Host "Installing Priority Tools (uv, neovim)" -ForegroundColor Cyan
Write-Host "========================================" -ForegroundColor Cyan
Write-Host ""

# Install uv (Python package manager) - FIRST
Write-Host "Installing uv (Python package manager)..." -ForegroundColor Yellow
powershell -ExecutionPolicy ByPass -c "irm https://astral.sh/uv/install.ps1 | iex"
$env:Path = "$env:USERPROFILE\.local\bin;$env:Path"

# Install neovim - SECOND
Write-Host "Installing neovim..." -ForegroundColor Yellow
scoop install neovim

Write-Host ""
Write-Host "========================================" -ForegroundColor Cyan
Write-Host "Installing Development Tools via Scoop" -ForegroundColor Cyan
Write-Host "========================================" -ForegroundColor Cyan
Write-Host ""

# Core development tools (available in Scoop)
# Note: uv and neovim already installed above as priority
$scoopPackages = @(
    # Version Control & Git Tools
    "git",
    "gh",              # GitHub CLI
    "git-lfs",
    "tig",
    "lazygit",
    
    # Search & Navigation Tools
    "fzf",
    "ripgrep",         # rg
    "fd",
    "bat",
    "eza",             # Modern ls replacement
    "zoxide",
    "the_silver_searcher", # ag
    "grep",
    
    # Text Processing
    "jq",
    "yq",
    "miller",
    
    # System Tools
    "htop",
    "neofetch",
    "wget",
    "curl",
    "which",
    "7zip",
    "stow",
    
    # Terminal & Shell
    "starship",
    
    # Programming Languages
    # "python",
    "nodejs",
    "go",
    "rust",
    "ruby",
    "perl",
    
    # Language Version Managers
    "nvm",
    
    # Build Tools
    "cmake",
    "make",
    "gcc",
    "bison",
    
    # Database Tools
    "sqlite",
    "mysql",
    "mariadb",
    
    # Editors & IDEs
    # "neovim",  # Already installed as priority above
    "vim",
    
    # File Viewers & Processors
    "pandoc",
    "imagemagick",
    "ffmpeg",
    "poppler",         # PDF tools
    "ghostscript",
    
    # Markup & Documentation
    "markdown",
    "doxygen",
    "graphviz",
    "sphinx",
    
    # Code Quality & Linting
    "shellcheck",
    "cloc",
    "scc",
    
    # Network Tools
    "nmap",
    "httpie",
    
    # Container & Virtualization
    "docker",
    "podman",
    
    # Compression
    "unzip",
    "gzip",
    
    # Misc Development Tools
    "act",             # Run GitHub Actions locally
    "direnv",
    "entr",
    "hyperfine",
    "trash",
    "tree",
    "tldr",
    "diff-so-fancy",
    "asciinema",
    "glow",            # Markdown viewer
    "vifm",
    "yazi",
    
    # Monitoring
    "glances",
    
    # Benchmarking
    "speedtest-cli",
    
    # Tree-sitter CLI (required for nvim-treesitter in Neovim 0.12+)
    "tree-sitter"
)

foreach ($package in $scoopPackages) {
    Write-Host "Installing $package..." -ForegroundColor Yellow
    scoop install $package
}

# Install Nerd Fonts via Scoop
Write-Host ""
Write-Host "Installing Nerd Fonts via Scoop..." -ForegroundColor Cyan
scoop install JetBrains-Mono-NF
scoop install Hack-NF

# Install JetBrains Mono Nerd Font (fallback method - direct download)
Write-Host ""
Write-Host "Installing JetBrains Mono Nerd Font (direct download)..." -ForegroundColor Cyan
$fontUrl = "https://github.com/ryanoasis/nerd-fonts/releases/latest/download/JetBrainsMono.zip"
$dest = "$env:TEMP\JetBrainsMono.zip"
$fontDir = "$env:TEMP\JetBrainsMono"

try {
    Invoke-WebRequest -Uri $fontUrl -OutFile $dest
    Expand-Archive -Path $dest -DestinationPath $fontDir -Force

    # Install all .ttf files
    $fonts = Get-ChildItem -Path $fontDir -Filter "*.ttf" -Recurse
    $objShell = New-Object -ComObject Shell.Application
    $objFolder = $objShell.Namespace(0x14) # Windows Fonts folder
    foreach ($font in $fonts) {
        $objFolder.CopyHere($font.FullName, 0x10) # 0x10 = overwrite silently
    }
    Write-Host "JetBrains Mono Nerd Font installed successfully." -ForegroundColor Green

    # Cleanup
    Remove-Item -Path $dest -Force -ErrorAction SilentlyContinue
    Remove-Item -Path $fontDir -Recurse -Force -ErrorAction SilentlyContinue
} catch {
    Write-Host "Failed to install JetBrains Mono Nerd Font via direct download: $_" -ForegroundColor Yellow
    Write-Host "The Scoop installation should still work." -ForegroundColor Yellow
}

# Terminal Emulators (Scoop)
Write-Host ""
Write-Host "Installing Terminal Emulators..." -ForegroundColor Cyan
scoop install kitty
scoop install wezterm

# Additional GUI applications via Scoop
Write-Host ""
Write-Host "Installing GUI Applications..." -ForegroundColor Cyan
$scoopGuiApps = @(
    "inkscape",
    "vlc",
    "dbeaver",
    "vscode"           # Optional but commonly used
)

foreach ($app in $scoopGuiApps) {
    Write-Host "Installing $app..." -ForegroundColor Yellow
    scoop install $app
}

# Check if winget is available for packages not in Scoop
Write-Host ""
Write-Host "========================================" -ForegroundColor Cyan
Write-Host "Installing Additional Tools via winget" -ForegroundColor Cyan
Write-Host "========================================" -ForegroundColor Cyan
Write-Host ""

if (Get-Command winget -ErrorAction SilentlyContinue) {
    $wingetPackages = @(
        # These packages are better installed via winget
        "OpenJS.NodeJS.LTS",
        "Microsoft.PowerShell",
        "Microsoft.WindowsTerminal",
        "Git.Git",
        "GitHub.GitLFS",
        "GitHub.cli",
        "Bitwarden.Bitwarden",
        "SlackTechnologies.Slack",
        "VideoLAN.VLC",
        "Oracle.JavaRuntimeEnvironment"
    )
    
    foreach ($package in $wingetPackages) {
        Write-Host "Installing $package..." -ForegroundColor Yellow
        winget install --id $package --silent --accept-package-agreements --accept-source-agreements
    }
} else {
    Write-Host "winget not found. Skipping winget installations." -ForegroundColor Yellow
    Write-Host "Note: winget is included in Windows 10 (1809+) and Windows 11" -ForegroundColor Yellow
}

# Install Python packages via uv
Write-Host ""
Write-Host "========================================" -ForegroundColor Cyan
Write-Host "Installing Python Packages via uv" -ForegroundColor Cyan
Write-Host "========================================" -ForegroundColor Cyan
Write-Host ""

# Install Python via uv
Write-Host "Installing Python 3.12 via uv..." -ForegroundColor Yellow
uv python install 3.12

# Install global tools using uv tool
$uvTools = @(
    "neovim-remote",
    "pre-commit",
    "black",
    "isort",
    "ruff",
    "rich-cli",
    "glances",
    "bpytop",
    "pygments",
    "jupyterlab",
    "sphinx"
)

foreach ($tool in $uvTools) {
    Write-Host "Installing uv tool: $tool..." -ForegroundColor Yellow
    uv tool install $tool
}

# Setup Neovim Python environments
Write-Host ""
Write-Host "Setting up Neovim Python Environments..." -ForegroundColor Cyan
$neovimVenvPath = "$env:USERPROFILE\.local\share\uv\venvs"
New-Item -ItemType Directory -Force -Path $neovimVenvPath | Out-Null

uv venv "$neovimVenvPath\neovim2" --python 3.12
uv venv "$neovimVenvPath\neovim3" --python 3.12

# Install neovim packages in both venvs
& "$neovimVenvPath\neovim3\Scripts\Activate.ps1"
uv pip install neovim flake8 neovim-remote
deactivate

& "$neovimVenvPath\neovim2\Scripts\Activate.ps1"
uv pip install neovim flake8
deactivate

# Install Node.js global packages
Write-Host ""
Write-Host "========================================" -ForegroundColor Cyan
Write-Host "Installing Node.js Global Packages" -ForegroundColor Cyan
Write-Host "========================================" -ForegroundColor Cyan
Write-Host ""

$nodePackages = @(
    "yarn",
    "prettier",
    "eslint",
    "typescript"
)

foreach ($package in $nodePackages) {
    Write-Host "Installing Node package: $package..." -ForegroundColor Yellow
    npm install -g $package
}

# Install Rust packages via cargo
Write-Host ""
Write-Host "========================================" -ForegroundColor Cyan
Write-Host "Installing Rust Packages (cargo)" -ForegroundColor Cyan
Write-Host "========================================" -ForegroundColor Cyan
Write-Host ""

$cargoPackages = @(
    "duf",
    "nerdfix",
    "viu"
)

foreach ($package in $cargoPackages) {
    Write-Host "Installing Rust package: $package..." -ForegroundColor Yellow
    cargo install $package
}

# Install Go packages
Write-Host ""
Write-Host "========================================" -ForegroundColor Cyan
Write-Host "Installing Go Packages" -ForegroundColor Cyan
Write-Host "========================================" -ForegroundColor Cyan
Write-Host ""

Write-Host "Installing md-publisher..." -ForegroundColor Yellow
go install github.com/andremueller/md-publisher@latest

# ========================================
# AI Coding Assistants (OpenCode, Claude Code)
# ========================================
Write-Host ""
Write-Host "========================================" -ForegroundColor Cyan
Write-Host "Installing AI Coding Assistants" -ForegroundColor Cyan
Write-Host "========================================" -ForegroundColor Cyan
Write-Host ""

# Install OpenCode CLI
Write-Host "Installing OpenCode..." -ForegroundColor Yellow
npm install -g @anthropic/opencode

# Install Claude Code CLI
Write-Host "Installing Claude Code..." -ForegroundColor Yellow
npm install -g @anthropic/claude-code

# Final setup steps
Write-Host ""
Write-Host "========================================" -ForegroundColor Cyan
Write-Host "Final Setup Steps" -ForegroundColor Cyan
Write-Host "========================================" -ForegroundColor Cyan
Write-Host ""

Write-Host "Setting up fzf key bindings..." -ForegroundColor Yellow
# Note: User will need to configure this in their shell profile

Write-Host ""
Write-Host "========================================" -ForegroundColor Green
Write-Host "Installation Complete!" -ForegroundColor Green
Write-Host "========================================" -ForegroundColor Green
Write-Host ""
Write-Host "Next Steps:" -ForegroundColor Cyan
Write-Host "1. Close and reopen your terminal to refresh PATH" -ForegroundColor White
Write-Host "2. Configure your shell (PowerShell profile or install zsh)" -ForegroundColor White
Write-Host "3. Set up your dotfiles using stow" -ForegroundColor White
Write-Host "4. Configure Neovim by running: nvim and letting plugins install" -ForegroundColor White
Write-Host "5. Install tmux alternative or use Windows Terminal panes" -ForegroundColor White
Write-Host ""
Write-Host "AI Coding Assistants:" -ForegroundColor Cyan
Write-Host "  opencode    # OpenCode CLI" -ForegroundColor White
Write-Host "  claude      # Claude Code CLI" -ForegroundColor White
Write-Host ""
Write-Host "IMPORTANT - Fonts:" -ForegroundColor Yellow
Write-Host "  Nerd Fonts have been installed via Scoop." -ForegroundColor White
Write-Host "  Configure your terminal to use 'JetBrainsMono Nerd Font'" -ForegroundColor White
Write-Host "  for proper icon display in starship prompt and Neovim." -ForegroundColor White
Write-Host ""
Write-Host "  Windows Terminal: Settings > Profiles > Defaults > Appearance" -ForegroundColor Gray
Write-Host "                    > Font face > 'JetBrainsMono Nerd Font'" -ForegroundColor Gray
Write-Host ""
Write-Host "  Verify fonts work by running in PowerShell:" -ForegroundColor White
Write-Host "    Write-Host `"`u{f015} `u{f07c} `u{e606}`"" -ForegroundColor Gray
Write-Host "  You should see a house, folder, and Node.js icon." -ForegroundColor White
Write-Host ""
Write-Host "Note: Some macOS-specific tools don't have Windows equivalents:" -ForegroundColor Yellow
Write-Host "  - mas (Mac App Store CLI)" -ForegroundColor Gray
Write-Host "  - blueutil (Bluetooth utility)" -ForegroundColor Gray
Write-Host "  - aerospace (Window manager)" -ForegroundColor Gray
Write-Host "  - macOS-specific casks" -ForegroundColor Gray
Write-Host ""
Write-Host "Scoop packages installed in: $env:USERPROFILE\scoop" -ForegroundColor Cyan
Write-Host "Run 'scoop list' to see installed packages" -ForegroundColor Cyan
Write-Host "Run 'scoop update *' to update all packages" -ForegroundColor Cyan
Write-Host ""
