#!/usr/bin/env bash
# Move Safari's current tab to another workspace: pick the workspace (choose-gui, type to filter
# or type a new name), detach the tab with Window > Move Tab to New Window (keeps its history),
# then send that new window there and follow it. A lone tab just moves its window.
# Usage: safari-tab-to-workspace.sh [WORKSPACE]
export PATH="/opt/homebrew/bin:/usr/local/bin:$PATH"

ws=$1
if [ -z "$ws" ]; then
  current=$(aerospace list-workspaces --focused)
  items=$(aerospace list-windows --all --format '%{workspace}|%{app-name}' | awk -F'|' '
    { apps[$1] = apps[$1] (apps[$1] ? ", " : "") $2 }
    END { for (w in apps) print w "  —  " apps[w] }')
  items=$(printf '%s\n' "$items" | grep -v "^$current  " | sort -V)
  choice=$(echo "$items" | choose -m -e -n 10 -w 30 -p "Move Safari tab to workspace")
  ws=${choice%%  —*}
fi
[ -n "$ws" ] || exit 0

before=$(aerospace list-windows --focused --format '%{window-id}|%{app-bundle-id}')
[ "${before#*|}" = com.apple.Safari ] || { osascript -e 'display notification "Focus a Safari window first" with title "Safari tab → workspace"'; exit 1; }
before=${before%%|*}

ntabs=$(osascript -e 'tell application "Safari" to count tabs of front window')
if [ "${ntabs:-1}" -gt 1 ]; then
  osascript -e 'tell application "System Events" to tell process "Safari" to click menu item "Move Tab to New Window" of menu "Window" of menu bar item "Window" of menu bar 1' || exit 1
  # wait for AeroSpace to see and focus the new window
  for _ in $(seq 40); do
    win=$(aerospace list-windows --focused --format '%{window-id}')
    [ -n "$win" ] && [ "$win" != "$before" ] && break
    sleep 0.05
  done
  [ "$win" != "$before" ] || exit 1
else
  win=$before
fi

aerospace move-node-to-workspace --window-id "$win" "$ws" && aerospace workspace "$ws"
