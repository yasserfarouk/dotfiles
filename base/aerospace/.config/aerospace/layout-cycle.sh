#!/usr/bin/env bash
# Whole-workspace layouts for the focused workspace, in cycle order:
#   grid (default; 3 windows → one left, two right; 4 → 2x2),
#   master-accordion (one left, the rest in an accordion on the right: one in front, the others behind),
#   main (one left, the rest stacked right),
#   two (two stacked left, the rest stacked right),
#   vertical, horizontal, accordion
#   layout-cycle.sh            go to the next layout
#   layout-cycle.sh MODE       go straight to MODE
#   layout-cycle.sh left|right|up|down   the focused window takes that half (stops auto re-arranging)
#   layout-cycle.sh regrid     rebuild grid/master-accordion/main/two after a new window appeared (on-window-detected)
# The mode is remembered per workspace in ~/.cache/aerospace-layout/<workspace>; no file = grid.
export PATH="/opt/homebrew/bin:/usr/local/bin:$PATH"
win=$AEROSPACE_WINDOW_ID  # the new window, in callbacks
unset AEROSPACE_WINDOW_ID  # otherwise every aerospace command would target that window
dir=$(dirname "$0")
state=$HOME/.cache/aerospace-layout
mkdir -p "$state"
modes=(grid master-accordion main two vertical horizontal accordion)

ws=$(aerospace list-workspaces --focused)
mode=$(cat "$state/$ws" 2>/dev/null || echo grid)

case ${1:-next} in
  regrid) # one run per burst (AeroSpace start reports every window), after the window is in the tree
    echo $$ >"$state/.regrid"; sleep 0.3; [ "$(cat "$state/.regrid")" = $$ ] || exit 0
    # skip floating windows (dialogs) and windows that opened on another workspace
    info=$(aerospace list-windows --all --format '%{window-id}|%{window-layout}|%{workspace}' |
      awk -F'|' -v w="$win" '$1 == w { print $2 "|" $3 }')
    [ "${info%%|*}" != floating ] || exit 0
    [ -z "$info" ] || [ "${info#*|}" = "$ws" ] || exit 0
    case $mode in grid | master-accordion | main | two) exec "$dir/arrange.sh" "$ws" "$mode" ;; esac; exit 0 ;;
  next) i=-1; for j in "${!modes[@]}"; do [ "${modes[j]}" = "$mode" ] && i=$j; done
    mode=${modes[(i + 1) % ${#modes[@]}]} ;;
  grid | master-accordion | main | two | vertical | horizontal | accordion) mode=$1 ;;
  left | right | up | down) echo manual >"$state/$ws"; exec "$dir/arrange.sh" "$ws" "$1" ;;
  *) echo "usage: $0 [next|regrid|grid|master-accordion|main|two|vertical|horizontal|accordion|left|right|up|down]" >&2; exit 2 ;;
esac
echo "$mode" >"$state/$ws"

case $mode in
  grid | master-accordion | main | two) exec "$dir/arrange.sh" "$ws" "$mode" ;;
  vertical) root=v_tiles ;; horizontal) root=h_tiles ;; accordion) root=h_accordion ;;
esac
aerospace flatten-workspace-tree --workspace "$ws"
aerospace layout --workspace "$ws" --root "$root" >/dev/null
