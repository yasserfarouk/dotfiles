# Windows Setup Script
# This script installs applications equivalent to the macOS Brewfile
# Scoop is the primary installer: everything installs per-user, NO administrator rights needed.
# Steps that truly need admin (system-wide fonts, winget machine installs) are gated behind an
# admin check and skipped otherwise. Safe to re-run (installed packages are skipped).

Write-Host "========================================" -ForegroundColor Cyan
Write-Host "Windows Development Environment Setup" -ForegroundColor Cyan
Write-Host "========================================" -ForegroundColor Cyan
Write-Host ""

# Function to check if running as administrator
function Test-Administrator {
    $currentUser = New-Object Security.Principal.WindowsPrincipal([Security.Principal.WindowsIdentity]::GetCurrent())
    return $currentUser.IsInRole([Security.Principal.WindowsBuiltInRole]::Administrator)
}

$IsAdmin = Test-Administrator
if ($IsAdmin) {
    Write-Host "Running as Administrator (not required; only used for optional system-wide steps)." -ForegroundColor Yellow
} else {
    Write-Host "Running without Administrator rights: user-level (Scoop) installs only." -ForegroundColor Green
}
Write-Host ""

# Install Scoop if not already installed
Write-Host "Checking for Scoop..." -ForegroundColor Green
if (!(Get-Command scoop -ErrorAction SilentlyContinue)) {
    Write-Host "Installing Scoop..." -ForegroundColor Yellow
    Set-ExecutionPolicy -ExecutionPolicy RemoteSigned -Scope CurrentUser -Force
    Invoke-RestMethod -Uri https://get.scoop.sh | Invoke-Expression
} else {
    Write-Host "Scoop is already installed." -ForegroundColor Green
}

# Add extra buckets (git is needed to add buckets)
if (-not (Get-Command git -ErrorAction SilentlyContinue)) { scoop install git }
$existingBuckets = @(scoop bucket list 6>$null | ForEach-Object { $_.Name })
foreach ($bucket in @("extras", "versions", "nerd-fonts", "java")) {
    if ($existingBuckets -notcontains $bucket) { scoop bucket add $bucket }
}

# Install a Scoop package unless it is already installed
function Install-ScoopPackage {
    param([string]$Name)
    $installedApps = @(scoop list 6>$null | ForEach-Object { $_.Name })
    $short = ($Name -split '/')[-1]
    if ($installedApps -contains $short) {
        Write-Host "  $Name already installed" -ForegroundColor Gray
    } else {
        Write-Host "Installing $Name..." -ForegroundColor Yellow
        scoop install $Name
    }
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
Install-ScoopPackage "uv"
$env:Path = "$env:USERPROFILE\.local\bin;$env:Path"

# Install neovim - SECOND
Install-ScoopPackage "neovim"

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
    "gitleaks",
    "tig",
    "lazygit",
    
    # Search & Navigation Tools
    "fzf",
    "ripgrep",         # rg
    "fd",
    "bat",
    "eza",             # Modern ls replacement
    "zoxide",
    "broot",
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
    Install-ScoopPackage $package
}

# Install Nerd Fonts via Scoop
Write-Host ""
Write-Host "Installing Nerd Fonts via Scoop..." -ForegroundColor Cyan
Install-ScoopPackage "JetBrains-Mono-NF"
Install-ScoopPackage "Hack-NF"

# System-wide JetBrains Mono Nerd Font (direct download) - needs Administrator, skipped otherwise.
# The Scoop font packages above already install the fonts per-user.
if ($IsAdmin) {
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
} else {
    Write-Host ""
    Write-Host "Skipping system-wide font install (needs Administrator). Scoop fonts are installed per-user." -ForegroundColor Yellow
}

# Terminal Emulators (Scoop)
Write-Host ""
Write-Host "Installing Terminal Emulators..." -ForegroundColor Cyan
Install-ScoopPackage "wezterm"
Write-Host "  Note: kitty has no Windows build, skipping (wezterm is used instead)." -ForegroundColor Yellow

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
    Install-ScoopPackage $app
}

# winget is only used for GUI apps that are not in Scoop. Machine-wide installs may need
# Administrator/UAC, so this block is skipped unless running elevated.
Write-Host ""
Write-Host "========================================" -ForegroundColor Cyan
Write-Host "Installing Additional Apps via winget (admin only)" -ForegroundColor Cyan
Write-Host "========================================" -ForegroundColor Cyan
Write-Host ""

if (-not $IsAdmin) {
    Write-Host "Not running as Administrator: skipping winget apps (Windows Terminal, PowerShell, Bitwarden, Slack, Java runtime)." -ForegroundColor Yellow
} elseif (Get-Command winget -ErrorAction SilentlyContinue) {
    $wingetPackages = @(
        # Everything CLI-ish (git, gh, node, git-lfs, vlc, ...) already comes from Scoop above
        "Microsoft.PowerShell",
        "Microsoft.WindowsTerminal",
        "Bitwarden.Bitwarden",
        "SlackTechnologies.Slack",
        "Oracle.JavaRuntimeEnvironment"
    )

    foreach ($package in $wingetPackages) {
        Write-Host "Installing $package..." -ForegroundColor Yellow
        winget install --id $package --silent --accept-package-agreements --accept-source-agreements
    }
} else {
    Write-Host "winget not found. Skipping winget installations." -ForegroundColor Yellow
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

foreach ($venv in @("neovim2", "neovim3")) {
    $venvDir = "$neovimVenvPath\$venv"
    if (-not (Test-Path "$venvDir\Scripts\python.exe")) {
        uv venv $venvDir --python 3.12
    }
    uv pip install --python "$venvDir\Scripts\python.exe" -U neovim flake8
}
uv pip install --python "$neovimVenvPath\neovim3\Scripts\python.exe" -U neovim-remote

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
    "typescript",
    "neovim",
    "write-good"
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
# (the real npm package is opencode-ai; opencode is also available via scoop/winget)
npm install -g opencode-ai

# Install Claude Code CLI
Write-Host "Installing Claude Code..." -ForegroundColor Yellow
npm install -g @anthropic-ai/claude-code

# Final setup steps
Write-Host ""
Write-Host "========================================" -ForegroundColor Cyan
Write-Host "Final Setup Steps" -ForegroundColor Cyan
Write-Host "========================================" -ForegroundColor Cyan
Write-Host ""

Write-Host "Setting up fzf key bindings..." -ForegroundColor Yellow
# Note: User will need to configure this in their shell profile

# Enable versioned git hooks (gitleaks secret scanning)
if (Get-Command git -ErrorAction SilentlyContinue) {
    git -C $PSScriptRoot config core.hooksPath .githooks
}

Write-Host ""
Write-Host "Skipped (Unix/macOS only, no Windows build):" -ForegroundColor Yellow
Write-Host "  - tmux, tpm, tmuxinator, sesh  (use WSL for the tmux workflow, or Windows Terminal/wezterm panes)" -ForegroundColor Gray
Write-Host "  - stow                         (link configs manually or use WSL)" -ForegroundColor Gray
Write-Host "  - aerospace, hammerspoon, karabiner, espanso-mac, finicky" -ForegroundColor Gray
Write-Host "  - kitty                        (no Windows build; wezterm installed instead)" -ForegroundColor Gray

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
Write-Host "5. tmux/sesh/tmuxinator/stow are Unix-only: use WSL (wsl-setup.sh) or Windows Terminal panes" -ForegroundColor White
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
