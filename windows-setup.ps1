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

Write-Host ""
Write-Host "========================================" -ForegroundColor Cyan
Write-Host "Installing Development Tools via Scoop" -ForegroundColor Cyan
Write-Host "========================================" -ForegroundColor Cyan
Write-Host ""

# Core development tools (available in Scoop)
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
    "pyenv",
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
    "neovim",
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
    "speedtest-cli"
)

foreach ($package in $scoopPackages) {
    Write-Host "Installing $package..." -ForegroundColor Yellow
    scoop install $package
}

# Install Nerd Fonts
Write-Host ""
Write-Host "Installing Nerd Fonts..." -ForegroundColor Cyan
scoop install JetBrains-Mono-NF
scoop install Hack-NF

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

# Install Python packages via pip
Write-Host ""
Write-Host "========================================" -ForegroundColor Cyan
Write-Host "Installing Python Packages" -ForegroundColor Cyan
Write-Host "========================================" -ForegroundColor Cyan
Write-Host ""

$pythonPackages = @(
    "pip",
    "pipx",
    "virtualenv",
    "neovim",          # For Neovim Python support
    "pygments",
    "rich-cli",
    "pre-commit",
    "black",
    "isort",
    "ruff",
    "jupyterlab",
    "sphinx",
    "bpytop"
)

foreach ($package in $pythonPackages) {
    Write-Host "Installing Python package: $package..." -ForegroundColor Yellow
    python -m pip install --user $package
}

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
