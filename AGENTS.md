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
| Tmux | `base/tmux/.tmux.conf` (`M-u`/prefix-`?` → `base/programs/bin/tmux-keys`: fuzzy list of all root/prefix shortcuts with descriptions, Enter runs one; `M-r`/prefix-`R` → `base/programs/bin/tmux-run-popup`: run a command in a popup in the pane's folder, Enter = another, any key = close) |
| direnv | `base/direnv/.config/direnv/direnvrc` (`source …/bin/activate` of a missing venv is a silent no-op + `watch_file`, so venv-less worktrees don't error; `use venv [DIR]`) |
| AeroSpace | `base/aerospace/.config/aerospace/` (`aerospace.toml`; home workspaces 1 kitty, 2 Safari, 3 Edge (NEC), 4 Outlook/Teams/Zoom, 9 Koma App: Hyper (⌘⌥⌃⇧, right ⌘ via Superkey; Superkey's Meh off) + T/S/E/O/M/K/Z (Z = Zoom → 4) → `app-ws.sh WS BUNDLE` (go there, focus the app's window there, else open a new one (Safari/Edge/kitty) or pull its window there (others), else launch), Hyper+1…9 = workspace; F10 chord (`mode launch`): letter = that app in the current workspace (`app-ws.sh here`), shift+letter = its home workspace, esc/F10 cancel; letter workspaces: alt-ctrl-letter = go to workspace LETTER (A–Z), alt-shift-letter = move the window there and follow, except letters taken by AeroSpace (b h j k l m t), Hammerspoon (e) or tmux (B G N Q W) — for those alt-shift-space then shift-letter; alt-ctrl-] / alt-ctrl-[ = next/previous workspace with windows, add shift for the next/previous empty one (`ws-cycle.sh`; the persistent 1–9/A–Z workspaces make plain `workspace next` stop at every empty one); `on-window-detected` routes Outlook/Teams → 4, Koma App → 9 and meeting windows → Z (`meeting-ws.sh`: "Zoom Meeting"/"Zoom Webinar", Teams windows titled "<subject> | Microsoft Teams" that aren't a main-window section; each moved once; Google Meet links → Z via `browser-here.sh`) (its Safari web-app bundle id changes when the app is recreated: run `koma-app-id.sh` there), kitty/Safari/Edge are not routed (Finicky links open in the current workspace, see Browser per URL); `alt-shift-b` → `browser-home.sh` (Finder windows → 8, as separate windows: AeroSpace shows a hidden native tab as an empty tile); new tiled windows are re-gridded by `layout-cycle.sh regrid` → `arrange.sh` (two batched `aerospace eval` calls, order from `focus --dfs-index`); `install.sh` turns off macOS window/Dock/Finder animations; Karabiner's left ⌘+hjkl = arrows (`mac/karabiner`, stowed as a whole-folder link `~/.config/karabiner`, the layout Karabiner supports; it reloads on save)) |
| Starship | `base/starship/.config/starship.toml` |
| tmuxinator | `base/tmuxinator/.config/tmuxinator/*.yml` (one window running `base/programs/bin/tmux-ide`, which makes it two windows: `claude` (first, and the active one) and `nvim` (opened on `:DiffviewOpen` in git repos), each with a shell under it taking 20% of the height; a `window-resized` hook keeps the share; `kitty-tmux`'s claude-only sessions get the same shell via `tmux-ide --term`; `daiba.yml` is ssh-only) |
| workmux | `base/workmux/.config/workmux/config.yaml` (worktrees next to the repo as `<repo>-<name>`, session of the same name; the `base/programs/bin/workmux` wrapper adds the `<repo>-` on `add`; older ones in `<repo>/.worktrees/` keep their pinned `target-session`; `post_create` gives uv projects a fresh `.venv` per worktree, never a link; tmux `M-a` new → `base/programs/bin/wm-new` (default agent; put `/agent/` anywhere on the name line, e.g. `feat /codex/ fix bug`, to use another — only on a brand-new worktree, since reopening an existing one keeps its agent; prefix `A` fzf-picks the agent first), `M-o` list → `wm-list`, `M-c`/prefix `C-c` switch to any running agent in sidebar order → `wm-agents`, `M-N`/prefix `N` rename the current agent's session → `wm-rename` (worktree: `workmux rename`; a window sharing a session moves to its own new session; else `rename-session`), `M-B`/prefix `B` toggle `workmux sidebar`, `M-e`/prefix `e` nvim popup on fugitive git status; Alfred `wm` → `base/programs/bin/wm-dash`: `workmux dashboard` in its own kitty window titled `workmux-dashboard`, floated by an aerospace `on-window-detected` rule, centered at 75% of the screen under the mouse and raised; reused if already open) |
| Folder shortcuts | `base/shortcuts/.config/shortcuts/dirs` (`name key path`; `~/bin/shortcut add/rm/ls/sync` → `$NAME` in `.exports`, yazi yamb bookmarks, zoxide, sesh `shortcuts.toml`, tmux `M-g` via `tmux-dir-pick` over `project-dirs`) |
| File/folder opener | `base/programs/bin/nvimkitty` (`nvimkitty FILE…` opens nvim in kitty, VS Code if kitty/nvim missing; `nvimkitty DIR…`/`nvimkitty yazi PATH…` opens yazi in kitty, Finder if missing; install also writes the Finder Quick Action `~/Library/Services/Open in Yazi.workflow` (ctrl-opt-cmd-Y) — macOS 26 refuses to make anything but Finder the `public.folder` handler, so Finder double-clicks stay in Finder; `nvimkitty install` builds `~/Applications/NvimKitty.app` and makes it the macOS default via `duti` for the `exts` list: md/txt/json/yaml/toml, LaTeX (tex/sty/cls/bib/bst…, also TeXShop's `org.tug.*` types up front), csv/tsv, shell/python/C/Rust/Go/JS/… source (each extension's UTI is looked up with `mdls`; extensions with only a `dyn.*` UTI get one declared by the app); `status`/`uninstall`; run by `install.sh`) |
| Alfred + kitty | `base/programs/bin/alfred-kitty install` (generates Alfred workflow `user.workflow.4B1E6A10-0000-…` with file actions "Open in Yazi" → `nvimkitty yazi`, "Open in tmux" → `base/programs/bin/kitty-tmux` (session per folder; folder → yazi `y`, file → shell; switches the attached tmux client or opens kitty), keyword `note TEXT` → `base/programs/bin/tempnote` (writes TEXT to `~/temp/YYYYMMDD-HHMMSS-<first word>.md`, opens it with `nvimkitty`), keyword `proj` → folders from `base/programs/bin/project-dirs` (the same list as tmux `M-g`/`tmux-dir-pick`) → `kitty-tmux --project DIR` (existing session shown; else tmuxinator if DIR has `.tmuxinator.yml` or a `~/.config/tmuxinator` project with literal `root:` DIR, else a shell running `claude`; ⌘↩ → plain `kitty-tmux`, yazi), keyword `new KIND NAME` (⌃⌥⌘N) → `base/programs/bin/mknew` (project → `nec_projects/YYYY<snake>`, patent → `patents/YYYY<Camel>`, paper → `papers_current/YYYY<snake>` + git init, code → `~/code/projects/<kebab>` + git init, then `kitty-tmux --project` (claude); talk → `kitty-tmux --project ~/code/presentations --name talk-… --claude "/nec-presentation DESC"`; with Outlook frontmost also `--mail` → `base/programs/bin/outlook-save DIR`: .eml + attachments, AppleScript for legacy Outlook, File > Save As… GUI scripting for New Outlook), keyword `sendto` (⌃⌥⌘M) + file action "Send to project folder" → `base/programs/bin/sendto` (move Finder's selection or the stashed files into a `project-dirs` folder, ⌘ copy, never overwrites; with Outlook frontmost and nothing stashed ↩ saves its email + attachments there via `outlook-save`, ⌥ the files instead; yazi `g m` → `sendto --pick`), keywords `dl`/`shot` → `base/programs/bin/recent` (newest ~/Downloads items incl. files in its `_*` sorting folders, unpacked zip → folder / CleanShot captures on the Desktop; dl ↩ open, shot ↩ send, ⌘ the other, ⌥ reveal), keyword `term` (⌃⌥⌘T) → `alfred-kitty term DIR`: plain kitty shell in ~ (first item, so ⌃⌥⌘T ↩) or a `project-dirs` folder, keyword `wm` → `wm-dash` (workmux dashboard, centered floating kitty), keyword `alfredinstall` → `alfred-kitty install-notify` (reinstall from Alfred, then a notification), keyword `ak` → menu of all these keywords (opens Alfred on the chosen one), all these lists (proj, term, sendto, dl/shot, ak) fuzzy-filtered fzf-style by `base/programs/bin/alfred-fuzzy` (`fzf --filter`) instead of Alfred's word-prefix matching, and sets Alfred's terminal to Custom → `alfred-kitty run CMD` in kitty; run by `install.sh`) |
| Browser per URL | `base/finicky/.config/finicky/finicky.js` (Finicky is the default browser; a `rules` table `"pattern": "Browser"`, else `defaultBrowser` Safari; edit with `base/programs/bin/browser-rule ls/add/rm/default/edit/test`, `add` defaults to Microsoft Edge and also adds the `/*` form; `browser-rule install` starts Finicky at login, asks macOS to make it the default browser and builds `browser-rule helpers`: `~/Applications/{Safari,Edge}Here.app` (`com.yasser.{safari,edge}-here`), which Finicky hands Safari/Edge links to so they open in the current AeroSpace workspace via `base/aerospace/.config/aerospace/browser-here.sh` (a tab in the browser's window there, else a new window); aerospace `alt-shift-b` → `browser-home.sh` sends the focused browser window to the browser's main workspace (the other one with most of its windows; Safari's tabs merge into its window there, Edge's window moves)) |
| Box mirror | `base/programs/bin/box-sync` (one-way rsync `~/Library/CloudStorage/Box-Box/Yasser/storage` → `~/code/storage`; `box-sync install [HH:MM]` writes launchd `com.yasser.box-sync`, daily 13:00, log `~/Library/Logs/box-sync.log`) |
| Stay awake for agents | `base/programs/bin/agent-awake` (launchd `com.yasser.agent-awake`, a loop that every 60 s renews a 90 s `caffeinate -i` while `workmux status --all` shows an agent working or waiting, or done (waiting for your next prompt, e.g. from your phone) within the last 2 h (`AGENT_AWAKE_STATUSES`, `AGENT_AWAKE_DONE_SECS`); failures of the workmux query are logged with a timestamp and keep the Mac awake while tmux runs; idle sleep only, so closing the lid still sleeps; needs homebrew on PATH and a UTF-8 `LANG` under launchd or tmux mangles workmux's pane query; `install`/`uninstall`/`status`/`check`; run by `install.sh`) |
| Alfred inline translate | `base/programs/bin/alfred-translate [KEYWORD]` (gives the installed Translate workflow `dev.nikitadev.translate` the keyword `tr`, so `tr TEXT` shows the Google translation as the result (any language → English, English → Japanese: `output_language` en, `input_language` ja); ↩ copy, ⇧↩ paste, ⌥↩ Text View, ⌘L large type (patches `main.py` to add large-type/copy text); Alfred's built-in `translate` web search still opens the browser; idempotent, re-run after a workflow update; run by `install.sh`) |
| Alfred GitHub `ghe` | `base/programs/bin/alfred-github-ghe [URL]` (points the gharlan GitHub workflow's `ghe` at the NEC GHE.com tenant `https://nec-corporation-emu.ghe.com`, and patches its `src/workflow.php` so `*.ghe.com` uses `api.<tenant>.ghe.com` instead of `/api/v3`; idempotent, re-run after a workflow update; then `ghe > login <classic PAT: repo + read:org, SSO-authorized>`; `gh` stays github.com) |
| Agent global instructions | `base/agents/.config/agents/AGENTS.md` (symlinked as Claude/Codex/pi/opencode global instructions) |
