# Dotfiles

Personal dotfiles managed with GNU Stow for symlink management across macOS, Linux, Windows, and WSL.

## Quick Start

```bash
# One command to install everything on any platform:
./setup.sh
```

The `setup.sh` script auto-detects your platform and runs the appropriate installer.

## Platform-Specific Installation

| Platform | Command | Description |
|----------|---------|-------------|
| macOS | `./setup.sh` or `brew bundle` | Uses Homebrew + Brewfile |
| Linux | `./linux-setup.sh` | Full install with GUI apps (apt/dnf/pacman) |
| WSL | `./wsl-setup.sh` | CLI-only install (no GUI apps) |
| Windows | `powershell -ExecutionPolicy Bypass -File windows-setup.ps1` | Uses Scoop + winget |

## How Package Parity Works

The `Brewfile` is the source of truth for macOS packages. The other platform scripts install equivalent packages:

| macOS (Brewfile) | Linux/WSL | Windows |
|------------------|-----------|---------|
| `brew install X` | apt/dnf/pacman or manual install | `scoop install X` or `winget install X` |
| `brew install --cask X` | flatpak or native package | Scoop extras or winget |
| `uv` (via brew) | `curl -LsSf https://astral.sh/uv/install.sh \| sh` | `irm https://astral.sh/uv/install.ps1 \| iex` |

### Priority Packages (installed first on all platforms)
1. **uv** - Python package/environment manager
2. **neovim** - Editor
3. **tmux** - Terminal multiplexer (Linux/macOS/WSL only)

### Core Tools Installed Everywhere
- **Shell**: zsh, starship prompt, fzf, zoxide
- **Search**: ripgrep, fd, fzf, the_silver_searcher
- **Git**: git, gh (GitHub CLI), lazygit, tig, git-lfs
- **Dev**: node, go, rust, python (via uv)
- **Utils**: bat, eza, jq, htop, tree, stow

## Post-Installation

After running the setup script:

```bash
# Update vim config paths, run stow, source shell files
./qupdate

# Install vim plugins, set zsh as default shell
./quick-install.sh
```

## Directory Structure

```
base/           # Cross-platform configs (stow packages)
├── nvim/       # Neovim config
├── vim/        # Vim config  
├── zsh/        # Zsh config
├── tmux/       # Tmux config
├── git/        # Git config
├── ...         # Other stow packages
mac/            # macOS-specific overrides
linux/          # Linux-specific overrides (.post* files)
```

Each subdirectory is a **stow package**. To symlink a package to `$HOME`:

```bash
cd base
stow nvim    # Creates ~/.config/nvim -> base/nvim/.config/nvim
stow zsh     # Creates ~/.zshrc -> base/zsh/.zshrc
./stowall    # Stow all packages at once
```

## Python Management

This repo uses **uv** (not pyenv) for Python management.

### Neovim Python Support

Two dedicated virtual environments are created for Neovim:

```
~/.local/share/uv/venvs/neovim2/
~/.local/share/uv/venvs/neovim3/
```

These are configured in `base/vim/.config/vim/settings/init.vim`:

```vim
let g:python_host_prog = expand('~/.local/share/uv/venvs/neovim2/bin/python')
let g:python3_host_prog = expand('~/.local/share/uv/venvs/neovim3/bin/python')
```

### Creating Project Environments

```bash
# In any project directory:
mkenv    # Creates .venv with Python 3.12 via uv
```

## Updating Packages

### macOS
```bash
brew update && brew upgrade
brew bundle --file=Brewfile    # Sync with Brewfile
```

### Linux/WSL
Re-run the setup script or update packages via your package manager:
```bash
sudo apt update && sudo apt upgrade    # Debian/Ubuntu
sudo dnf upgrade                        # Fedora
sudo pacman -Syu                        # Arch
```

### Windows
```powershell
scoop update *
```

## Adding New Packages

To keep packages in sync across platforms:

1. **macOS**: Add to `Brewfile`, run `brew bundle`
2. **Linux**: Add to `linux-setup.sh` in the appropriate `CORE_PACKAGES` array
3. **WSL**: Add to `wsl-setup.sh` (same as Linux, but no GUI packages)
4. **Windows**: Add to `windows-setup.ps1` in `$scoopPackages` or `$wingetPackages`

## Key Files

| File | Purpose |
|------|---------|
| `setup.sh` | Unified cross-platform installer |
| `Brewfile` | macOS package definitions |
| `linux-setup.sh` | Linux installer (with GUI) |
| `wsl-setup.sh` | WSL installer (CLI only) |
| `windows-setup.ps1` | Windows installer |
| `qupdate` | Post-install config updates |
| `quick-install.sh` | Vim plugins + shell setup |
| `base/stowall` | Stow all base packages |

## Fonts

This setup requires **Nerd Fonts** for proper icon display in the terminal, Neovim, and starship prompt.

### Recommended Fonts
- **JetBrains Mono Nerd Font** (primary)
- **Hack Nerd Font** (alternative)

### Installation

Fonts are automatically installed by the setup scripts:
- **macOS**: Installed via Homebrew casks (`font-jetbrains-mono-nerd-font`, `font-hack-nerd-font`)
- **Linux/WSL**: Downloaded to `~/.local/share/fonts/`
- **Windows**: Installed via Scoop (`JetBrains-Mono-NF`, `Hack-NF`)

### Terminal Configuration

After installation, configure your terminal to use a Nerd Font:

| Terminal | Setting Location |
|----------|------------------|
| **Windows Terminal** | Settings > Profiles > Defaults > Appearance > Font face > "JetBrainsMono Nerd Font" |
| **iTerm2** (macOS) | Preferences > Profiles > Text > Font > "JetBrainsMono Nerd Font" |
| **Alacritty** | `~/.config/alacritty/alacritty.yml` → `font.normal.family: "JetBrainsMono Nerd Font"` |
| **Kitty** | `~/.config/kitty/kitty.conf` → `font_family JetBrainsMono Nerd Font` |
| **WezTerm** | `~/.wezterm.lua` → `font = wezterm.font("JetBrainsMono Nerd Font")` |
| **GNOME Terminal** | Preferences > Profiles > Custom font > "JetBrainsMono Nerd Font" |
| **Konsole** | Settings > Edit Current Profile > Appearance > Font > "JetBrainsMono Nerd Font" |

### Verifying Font Installation

Run this command to check if icons display correctly:
```bash
echo -e "\uf015 \uf07c \uf1c0 \ue606 \uf121"
```
You should see: a house, folder, database, node.js logo, and code brackets icons.

If you see boxes or question marks, your terminal is not using a Nerd Font.

### WSL-Specific Notes

For WSL, install fonts on the **Windows side** and configure Windows Terminal:
1. Download fonts from [Nerd Fonts releases](https://github.com/ryanoasis/nerd-fonts/releases)
2. Extract and right-click → "Install for all users"
3. Set the font in Windows Terminal settings

Alternatively, if using WSLg with a Linux GUI terminal (kitty, wezterm), the fonts installed in `~/.local/share/fonts/` will work.

## AI Coding Assistants

The setup scripts install these AI coding CLI tools:
- **OpenCode** - `opencode`
- **Claude Code** - `claude`

These require API keys to be configured. See their respective documentation for setup.

## Neovim Utilities

Custom Lua utilities live in `base/nvim/.config/nvim/lua/yasser/utils/`.

### `utils/job.lua` — Background job runner with statusline feedback

Runs any shell command asynchronously without blocking Neovim, tracks running
and failed jobs, and exposes a statusline segment that reflects the current
state. Optionally collects stdout/stderr and shows it in a scratch buffer when
the job completes.

#### Basic usage

```lua
local job = require("yasser.utils.job")

-- Fire-and-forget: run silently, statusline indicator only
job.run("pandoc input.md -o output.pdf && open output.pdf")

-- Show stdout/stderr in a bottom split when done
job.run("make test", { show_output = true })

-- React to success or failure
job.run("npm run build", {
  on_success = function()
    vim.notify("Build succeeded", vim.log.levels.INFO)
  end,
  on_failure = function(exit_code)
    vim.notify("Build failed (exit " .. exit_code .. ")", vim.log.levels.ERROR)
  end,
})

-- Combine options
job.run("pytest --tb=short", {
  show_output = true,
  on_failure  = function() vim.notify("Tests failed", vim.log.levels.WARN) end,
})
```

#### Statusline integration

Add the segment to your statusline builder function:

```lua
-- in lua/yasser/statusline.lua (or equivalent)
local function my_statusline()
  return table.concat({
    -- ... other segments ...
    require("yasser.utils.job").statusline(),
  })
end
```

| State | Display |
|-------|---------|
| One job running | `⚙ ` |
| Three concurrent jobs | `⚙ 3 ` |
| One or more jobs failed | `❌ ` |
| Idle / all succeeded | _(empty)_ |

The failure indicator persists until the next `job.run()` call. To dismiss it
manually (e.g. bound to a key):

```lua
vim.keymap.set("n", "<leader>jc", require("yasser.utils.job").clear,
  { desc = "clear job failure indicator" })
```

#### Real-world example — Pandoc compilation

```lua
-- lua/plugins/markdown.lua
local job = require("yasser.utils.job")

local function pandoc_pdf()
  local f = vim.fn.shellescape(vim.fn.expand("%"))
  local o = vim.fn.shellescape(vim.fn.expand("%:r") .. ".pdf")
  job.run(string.format(
    "pandoc %s -s --pdf-engine=xelatex -o %s && open %s",
    f, o, o
  ))
end
```

## Troubleshooting

### Stow Conflicts
If stow fails with "existing target is not a symlink":
```bash
# Back up the conflicting file first
mv ~/.zshrc ~/.zshrc.bak
# Then re-run stow
cd base && stow zsh
```

### Neovim Treesitter Errors (0.12+)
Neovim 0.12 requires the new nvim-treesitter main branch. If you see treesitter errors:
```vim
:Lazy update nvim-treesitter
:TSUninstall all
:TSUpdate
```

### Missing Icons in Terminal
See the [Fonts](#fonts) section above to configure your terminal with a Nerd Font.
