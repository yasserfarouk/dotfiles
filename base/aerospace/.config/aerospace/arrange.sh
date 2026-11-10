#!/usr/bin/env bash
# Arrange a workspace's tiled windows as two columns (or rows), the second one stacked:
#   grid   1 → full, 2 → left|right, 3 → one left, two right, 4 → 2x2, n → n/2 left, the rest right
#   main   one window left, all the others stacked on the right
#   master-accordion   one window left, all the others in an accordion on the right (one in front)
#   two    two windows stacked on the left, all the others stacked on the right
#   left|right|up|down   the focused window takes that whole half, the others share the other half
# Usage: arrange.sh WORKSPACE grid|main|master-accordion|two|left|right|up|down   (WORKSPACE = the focused one)
# Fast: two `aerospace eval` round trips (each batches many commands), window order from
# `focus --dfs-index` (screen order after flattening) instead of walking focus with the arrows.
export PATH="/opt/homebrew/bin:/usr/local/bin:$PATH"
unset AEROSPACE_WINDOW_ID  # set for callbacks; aerospace commands would all target that window

ws=$1 kind=$2
case $kind in
  up | down) root=v_tiles next=down ;;
  *) root=h_tiles next=right ;;
esac
q() { printf '"%s"' "$1"; }  # quote an argument for aerospace's shell

# 1 (one round trip): focused window, flatten, root layout, the tiled windows, the focused window
# to the edge it is to fill, then the order: DFS index = screen order (a guessed count, errors past the
# end are harmless; bigger workspaces get a second query)
dfs() { local c= i; for ((i = $1; i < $2; i++)); do c+="focus --dfs-index $i; list-windows --focused --format $(q 'd %{window-id}'); "; done; echo "$c"; }
edge=
case $kind in
  left | right | up | down) for _ in 1 2 3 4 5 6 7 8; do edge+="move --boundaries workspace --boundaries-action fail $kind; "; done ;;
esac
w=$(q "$ws")
out=$(aerospace eval "workspace $w; list-windows --focused --format $(q 'o %{window-id}'); flatten-workspace-tree --workspace $w; layout --workspace $w --root $root; list-windows --workspace $w --format $(q 't %{window-id} %{window-layout}'); $edge$(dfs 0 8)" 2>/dev/null)
orig=$(awk '$1 == "o" { print $2 }' <<<"$out")
tiled=($(awk '$1 == "t" && $3 != "floating" { print $2 }' <<<"$out"))
n=${#tiled[@]}
(( n >= 2 )) || { [ -z "$orig" ] || aerospace focus --window-id "$orig"; exit 0; }
order() { awk -v t=" ${tiled[*]} " '$1 == "d" && index(t, " " $2 " ") && !seen[$2]++ { print $2 }'; }
ids=($(order <<<"$out"))
for try in 1 2 3; do  # more than 8 windows, or a new window not in the tree yet
  (( ${#ids[@]} == n )) && break
  sleep 0.05
  ids=($(aerospace eval "focus --window-id ${tiled[0]}; $(dfs 0 "$n")" 2>/dev/null | order))
done
if (( ${#ids[@]} != n )); then aerospace focus --window-id "${orig:-${tiled[0]}}"; exit 1; fi
case $kind in
  grid) first=$((n / 2)) ;;
  two) first=$((n > 2 ? 2 : 1)) ;;
  right | down) first=$((n - 1)) ;;
  *) first=1 ;;
esac

# 3: stack windows from..to-1: join the last two (a container across the root's direction), then
# move each earlier one into it (join-with would nest a new container instead)
cmd=
stack() {
  (( $2 - $1 >= 2 )) || return 0
  cmd+="join-with --window-id ${ids[$2 - 2]} $next; "
  for ((i = $2 - 3; i >= $1; i--)); do cmd+="move --window-id ${ids[i]} $next; "; done
}
stack "$first" "$n"
stack 0 "$first"
[ "$kind" != master-accordion ] || (( n < 3 )) || cmd+="layout --window-id ${ids[1]} v_accordion; "
aerospace eval "${cmd}balance-sizes --workspace $(q "$ws"); focus --window-id ${orig:-${ids[0]}}"
