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
| direnv | `base/direnv/.config/direnv/direnvrc` (`source …/bin/activate` of a missing venv is a silent no-op + `watch_file`, so venv-less worktrees don't error; `use venv [DIR]`) |
| Starship | `base/starship/.config/starship.toml` |
| workmux | `base/workmux/.config/workmux/config.yaml` (worktrees next to the repo as `<repo>-<name>`, session of the same name; the `base/programs/bin/workmux` wrapper adds the `<repo>-` on `add`; older ones in `<repo>/.worktrees/` keep their pinned `target-session`; `post_create` gives uv projects a fresh `.venv` per worktree, never a link; tmux `M-a` new → `base/programs/bin/wm-new`, `M-o` list → `wm-list`, `M-c`/prefix `C-c` switch to any running agent in sidebar order → `wm-agents`) |
| Folder shortcuts | `base/shortcuts/.config/shortcuts/dirs` (`name key path`; `~/bin/shortcut add/rm/ls/sync` → `$NAME` in `.exports`, yazi yamb bookmarks, zoxide, sesh `shortcuts.toml`, tmux `M-g` via `tmux-dir-pick` over `project-dirs`) |
| File/folder opener | `base/programs/bin/nvimkitty` (`nvimkitty FILE…` opens nvim in kitty, VS Code if kitty/nvim missing; `nvimkitty DIR…`/`nvimkitty yazi PATH…` opens yazi in kitty, Finder if missing; install also writes the Finder Quick Action `~/Library/Services/Open in Yazi.workflow` (ctrl-opt-cmd-Y) — macOS 26 refuses to make anything but Finder the `public.folder` handler, so Finder double-clicks stay in Finder; `nvimkitty install` builds `~/Applications/NvimKitty.app` and makes it the macOS default for md/txt/log/json/yaml/toml/ini/conf/… via `duti`; `status`/`uninstall`; run by `install.sh`) |
| Alfred + kitty | `base/programs/bin/alfred-kitty install` (generates Alfred workflow `user.workflow.4B1E6A10-0000-…` with file actions "Open in Yazi" → `nvimkitty yazi`, "Open in tmux" → `base/programs/bin/kitty-tmux` (session per folder; folder → yazi `y`, file → shell; switches the attached tmux client or opens kitty), keyword `note TEXT` → `base/programs/bin/tempnote` (writes TEXT to `~/temp/YYYYMMDD-HHMMSS-<first word>.md`, opens it with `nvimkitty`), keyword `proj` → folders from `base/programs/bin/project-dirs` (the same list as tmux `M-g`/`tmux-dir-pick`) → `kitty-tmux --project DIR` (existing session shown; else tmuxinator if DIR has `.tmuxinator.yml` or a `~/.config/tmuxinator` project with literal `root:` DIR, else a shell running `claude`; ⌘↩ → plain `kitty-tmux`, yazi), keyword `new KIND NAME` (⌃⌥⌘N) → `base/programs/bin/mknew` (project → `nec_projects/YYYY<snake>`, patent → `patents/YYYY<Camel>`, paper → `papers_current/YYYY<snake>` + git init, code → `~/code/projects/<kebab>` + git init, then `kitty-tmux --project` (claude); talk → `kitty-tmux --project ~/code/presentations --name talk-… --claude "/nec-presentation DESC"`; with Outlook frontmost also `--mail` → `base/programs/bin/outlook-save DIR`: .eml + attachments, AppleScript for legacy Outlook, File > Save As… GUI scripting for New Outlook), keyword `sendto` (⌃⌥⌘M) + file action "Send to project folder" → `base/programs/bin/sendto` (move Finder's selection or the stashed files into a `project-dirs` folder, ⌘ copy, never overwrites; yazi `g m` → `sendto --pick`), keywords `dl`/`shot` → `base/programs/bin/recent` (newest ~/Downloads items incl. files in its `_*` sorting folders, unpacked zip → folder / CleanShot captures on the Desktop; dl ↩ open, shot ↩ send, ⌘ the other, ⌥ reveal), and sets Alfred's terminal to Custom → `alfred-kitty run CMD` in kitty; run by `install.sh`) |
| Box mirror | `base/programs/bin/box-sync` (one-way rsync `~/Library/CloudStorage/Box-Box/Yasser/storage` → `~/code/storage`; `box-sync install [HH:MM]` writes launchd `com.yasser.box-sync`, daily 13:00, log `~/Library/Logs/box-sync.log`) |
| Agent global instructions | `base/agents/.config/agents/AGENTS.md` (symlinked as Claude/Codex/pi/opencode global instructions) |
