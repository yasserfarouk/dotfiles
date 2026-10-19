#!/usr/bin/env bash
# fzf preview for the Alt-i session switcher: window list + every pane of the active window.
s=$1
tmux list-windows -t "$s" -F '#{?window_active,*, } #I: #W (#{window_panes} panes)'
echo
panes=$(tmux list-panes -t "$s" -F '#{pane_id}')
n=$(echo "$panes" | wc -l | tr -d ' ')
total=${FZF_PREVIEW_LINES:-40}
per=$(( (total - $(tmux list-windows -t "$s" | wc -l) - 1 - 2 * n) / n ))
[ "$per" -lt 3 ] && per=3
for p in $panes; do
  tmux display-message -p -t "$p" -F '── pane #{pane_index}: #{pane_current_command} #{pane_current_path} ──'
  tmux capture-pane -ep -t "$p" | sed -e :a -e '/^[[:space:]]*$/{$d;N;ba' -e '}' | tail -n "$per"
done
