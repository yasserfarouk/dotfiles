#!/usr/bin/env bash
# After a window closes (Hammerspoon's windowDestroyed, mac/hammerspoon init.lua; AeroSpace has no
# close callback): when nothing on the focused workspace has focus any more (macOS handed it to an app
# with no window here), focus the workspace's first tiled window, and re-arrange the workspace in its
# layout-cycle.sh mode so the remaining windows fill the space.
export PATH="/opt/homebrew/bin:/usr/local/bin:$PATH"
dir=$(cd "$(dirname "$0")" && pwd) state=$HOME/.cache/aerospace-layout
# one run per burst (closing an app destroys all its windows at once)
mkdir -p "$state"; echo $$ >"$state/.closed"; sleep 0.1; [ "$(cat "$state/.closed")" = $$ ] || exit 0

ws=$(aerospace list-workspaces --focused) || exit 0
tiled=$(aerospace list-windows --workspace "$ws" --format '%{window-id}|%{window-layout}' |
  awk -F'|' '$2 != "floating" { print $1 }')
[ -n "$tiled" ] || exit 0
focused=$(aerospace list-windows --focused --format '%{workspace}' 2>/dev/null)
[ "$focused" = "$ws" ] || aerospace focus --window-id "$(head -1 <<<"$tiled")"

mode=$(cat "$state/$ws" 2>/dev/null || echo grid)
case $mode in
  grid | master-accordion | main | two) exec lockf -k "$state/.lock" "$dir/arrange.sh" "$ws" "$mode" ;;
esac
