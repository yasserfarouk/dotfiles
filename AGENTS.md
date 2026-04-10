# AGENTS.md

Dotfiles repo using GNU Stow for symlink management across macOS, Linux, Windows, and WSL.

## Structure

```
base/           # Cross-platform configs (stow packages)
mac/            # macOS-specific overrides
linux/          # Linux-specific overrides (includes .post* shell files)
```

Each subdirectory in `base/`, `mac/`, `linux/` is a stow package. Run `stow <package>` from within those directories to symlink configs to `$HOME`.

## Installation Commands

```bash
# Unified installer (auto-detects platform):
./setup.sh

# Platform-specific:
./install.sh           # macOS (uses Brewfile)
./linux-setup.sh       # Linux with GUI apps
./wsl-setup.sh         # WSL (CLI only, no GUI)
# Windows (PowerShell):
powershell -ExecutionPolicy Bypass -File windows-setup.ps1
```

## Key Conventions

- **Python management**: Uses `uv` (not pyenv). Neovim Python venvs at `~/.local/share/uv/venvs/neovim{2,3}/`
- **Java management**: Uses SDKMAN (`sdk install java <version>`, `sdk use java <version>`)
- **Shell configs**: Base configs in `base/`, platform overrides via `.post*` files (e.g., `.postzsh`, `.postbashrc`) sourced after main configs
- **Neovim**: Uses lazy.nvim (not vim-plug) - plugins auto-install on first run
- **Prompt**: Starship for both zsh and bash
- **Stow helpers**: `base/stowall` and `base/stowthis` scripts for batch stowing
- **Priority packages**: `uv`, `neovim`, `tmux` installed first in all setup scripts

## Neovim Python Paths

Set in `base/vim/.config/vim/settings/init.vim`:
```vim
let g:python_host_prog = expand('~/.local/share/uv/venvs/neovim2/bin/python')
let g:python3_host_prog = expand('~/.local/share/uv/venvs/neovim3/bin/python')
```

## Post-install

```bash
./qupdate              # Updates vim config paths, runs stow, sources shell files
./quick-install.sh     # Sets zsh as default shell, runs qupdate
```

## File Locations

| Config | Path |
|--------|------|
| Brewfile | `./Brewfile` (macOS packages) |
| Shell exports | `base/common_shell/.exports` |
| Neovim | `base/nvim/.config/nvim/` (uses lazy.nvim) |
| Vim | `base/vim/.config/vim/` |
| Tmux | `base/tmux/.tmux.conf` |
| Starship | `base/starship/.config/starship.toml` |
