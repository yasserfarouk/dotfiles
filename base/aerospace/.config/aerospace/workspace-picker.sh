#!/usr/bin/env bash
# Show every non-empty workspace with its apps (choose-gui, type to filter) and switch to the chosen one.
export PATH="/opt/homebrew/bin:/usr/local/bin:$PATH"

current=$(aerospace list-workspaces --focused)
items=$(aerospace list-windows --all --format '%{workspace}|%{app-name}' | awk -F'|' '
  { apps[$1] = apps[$1] (apps[$1] ? ", " : "") $2 }
  END { for (w in apps) print w "  —  " apps[w] }')
# make sure the focused workspace is listed even if empty
echo "$items" | grep -q "^$current  " || items=$(printf '%s\n%s  —  (empty)' "$items" "$current")
items=$(echo "$items" | sort -V)

choice=$(echo "$items" | choose -m -n 10 -w 30 -p "Workspace (now: $current)")
[ -n "$choice" ] && aerospace workspace "${choice%%  —*}"
