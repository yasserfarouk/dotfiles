# Kitty instead of tmux (+ workmux): analysis, parked

Status (2026-11-12): **not adopted**, tmux stays. Saved for a possible later switch.
Based on kitty 0.49.2, workmux 0.1.277, `base/tmux/.tmux.conf`, the `wm-*`/`tmux-*` scripts,
kitty's sessions docs and workmux's kitty guide and backend (`src/multiplexer/kitty.rs`).

## Verdict

About 85–90% of the tmux muscle memory can be kept in a kitty-only mode (same `C-space` prefix and
`M-…` keys, as the modes would never be active together). What can't be kept:

- **Agents live inside kitty.** No server and no detach: quitting, crashing or updating kitty kills every
  agent and ssh connection. kitty 0.50's `restore_session_after_logout` brings back layouts and
  scrollback, but only the shell restarts. Mitigation: `workmux add --continue` / `claude --continue`.
- **workmux on kitty** (experimental) has window mode only (`mode: session` errors out), no sidebar
  (the sidebar code is tmux-only), works only inside the current OS window, and new tabs go at the end.
  Its tabs are launched without `--add-to-session`, so they don't join kitty sessions (one-line patch
  in `create_window`, or fix it afterwards in `wm-new`).

## Design, if adopted

- **Switch:** `~/.config/mux-mode` (`tmux`|`kitty`). `kitty.conf` has `include mux.conf`, a symlink to
  `mux-tmux.conf` (empty) or `mux-kitty.conf` (tmux-style keys). A `mux-mode` script relinks it and
  reloads kitty. `kitty-tmux`, `mknew`, `alfred-kitty`, `wm-dash` and `agent-awake` read the mode, and
  the workmux wrapper adds `--mode window`.
- **Mapping:** tmux session → kitty session (one OS window, `tab_bar_filter session:~`, `goto_session`);
  window → tab; pane → window (`splits` layout).
- **Popups:** `kitten panel --edge=center-sized --lines N --columns M --hide-on-focus-loss` (floating,
  centred; size in cells, so a helper converts %).
- **Keys:** splits `launch --location=hsplit/vsplit --cwd=current`; swap `move_window`; zoom
  `toggle_layout stack`; kill `close_window`/`close_tab`/`close_session`; pickers `goto_session` /
  `select_tab`; `M-p`/`M-n` need a small kitten; join-pane ≈ `detach_window ask`; copy mode ≈
  `show_scrollback` + `hints`; sync ≈ `broadcast`; status bar via `tab_bar.py` with a timer; `M-B`
  sidebar → a narrow left panel looping `workmux status` + tab status icons (workmux's
  `tab_bar.py`/`workmux_watcher.py`).
- **tmuxinator → `kmux`:** a small Ruby script that runs the *same* `~/.config/tmuxinator/*.yml`
  (ERB with `@args`), compiles it to `~/.local/state/kmux/<name>.kitty-session` and runs
  `kitten @ action goto_session` (an existing session is just shown). `tmux-ide` becomes a built-in
  `ide` layout (claude tab and nvim tab, each with a 20% shell via `--bias`; no resize hook needed).
  Multi-command windows (daiba) are typed in with `kitten @ send-text`. Hooks run before opening.
  Extras: `kmux ls/kill/edit/save/debug`. A `mux()` shell function dispatches to `tmuxinator` or
  `kmux` by mode, so `c`, `p`, `tc`, `tp`… stay the same.
- **ssh:** works unchanged (the `ssh()` wrapper; plain ssh now sends `xterm-256color`). No local holder
  for the connection, so run tmux on the remote host (`tmux new -A -s main`, typed by a kmux profile).
  `kitten ssh` hosts gain splits that open on the same remote host and folder. Pass `C-space` through
  to a remote tmux when ssh is in the foreground (like `pass_keys.py` does for vim).

## Open questions (spike first)

1. Do panel popups behave with AeroSpace (not tiled, focus returns), and is their startup fast enough?
2. Do workmux tabs join the active kitty session?
3. Can `close_session` and a rename target a session by name?
4. Can launchd's `agent-awake` find the kitty socket (`listen_on unix:/tmp/mykitty` → `/tmp/mykitty-PID`)?

## Effort

Spike about 2 h. Core (mode switch, keys, popups, `kmux`) about 1.5 days. Script ports (`kitty-tmux`,
`wm-*`, `tmux-dir-pick`, `tmux-keys`, `mknew`, `alfred-kitty`, `wm-dash`, `agent-awake`) about 1 day.
Polish (status bar, sidebar substitute, session cycling) about half a day.
