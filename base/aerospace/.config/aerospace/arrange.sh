#!/usr/bin/env bash
# Arrange a workspace's tiled windows as two columns (or rows), the second one stacked:
#   grid   1 → full, 2 → left|right, 3 → one left, two right, 4 → 2x2, n → n/2 left, the rest right
#   main   one window left, all the others stacked on the right
#   master-accordion   one window left, all the others in an accordion on the right (one in front)
#   two    two windows stacked on the left, all the others stacked on the right
#   left|right|up|down   the focused window takes that whole half, the others share the other half
# Usage: arrange.sh WORKSPACE grid|main|master-accordion|two|left|right|up|down
# (focus walks over the windows and comes back; another workspace gets focused briefly)
export PATH="/opt/homebrew/bin:/usr/local/bin:$PATH"
unset AEROSPACE_WINDOW_ID  # set for callbacks; aerospace commands would all target that window

ws=$1 kind=$2
case $kind in
  up | down) root=v_tiles prev=up next=down ;;
  *) root=h_tiles prev=left next=right ;;
esac
orig=$(aerospace list-windows --focused --format '%{window-id}')
aerospace flatten-workspace-tree --workspace "$ws"
aerospace layout --workspace "$ws" --root "$root" >/dev/null
tiled=($(aerospace list-windows --workspace "$ws" --format '%{window-id}|%{window-layout}' |
  awk -F'|' '$2 != "floating" { print $1 }'))
(( ${#tiled[@]} >= 2 )) || exit 0

# the focused window goes to the edge it is to fill
bound='--boundaries workspace --boundaries-action fail'
case $kind in
  left | right | up | down) for _ in "${tiled[@]}"; do aerospace move --window-id "$orig" $bound "$kind" 2>/dev/null || break; done ;;
esac

# list-windows is not in screen order: walk focus from the first window to the last
walk="--ignore-floating $bound"
# (bounded and stopping when focus stops moving; retried in case a new window is not laid out yet)
focused() { aerospace list-windows --focused --format '%{window-id}'; }
for try in 1 2 3 4 5; do
  aerospace focus --window-id "${tiled[0]}"
  for _ in "${tiled[@]}"; do
    w=$(focused); aerospace focus $walk $prev 2>/dev/null || break; [ "$(focused)" != "$w" ] || break
  done
  ids=($(focused))
  for _ in "${tiled[@]}"; do
    aerospace focus $walk $next 2>/dev/null || break
    w=$(focused); [ "$w" != "${ids[${#ids[@]} - 1]}" ] || break; ids+=("$w")
  done
  (( ${#ids[@]} == ${#tiled[@]} )) && break
  sleep 0.3
done
aerospace focus --window-id "${orig:-${ids[0]}}"
(( ${#ids[@]} == ${#tiled[@]} )) || exit 1
n=${#ids[@]}
case $kind in
  grid) first=$((n / 2)) ;;
  two) first=$((n > 2 ? 2 : 1)) ;;
  right | down) first=$((n - 1)) ;;
  *) first=1 ;;
esac

# stack windows from..to-1: join the last two (a container across the root's direction), then
# move each earlier one into it (join-with would nest a new container instead)
stack() {
  (( $2 - $1 >= 2 )) || return 0
  aerospace join-with --window-id "${ids[$2 - 2]}" $next
  for ((i = $2 - 3; i >= $1; i--)); do aerospace move --window-id "${ids[i]}" $next; done
}
stack "$first" "$n"
stack 0 "$first"
[ "$kind" != master-accordion ] || (( n < 3 )) || aerospace layout --window-id "${ids[1]}" v_accordion
aerospace balance-sizes --workspace "$ws"
