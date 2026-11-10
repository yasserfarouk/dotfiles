#!/usr/bin/env bash
# Go to the next/previous workspace that has windows, or that is empty (persistent-workspaces keeps
# all of 1-9 and A-Z alive, so plain `workspace next` would step through every empty one).
#   ws-cycle.sh next|prev [busy|empty]     (busy = has windows, the default)
# Order is AeroSpace's (1-9, then A-Z), on the focused monitor, wrapping around; empty falls back
# to all monitors when the focused one has none.
export PATH="/opt/homebrew/bin:/usr/local/bin:$PATH"
dir=${1:-next} kind=${2:-busy}
case $dir in next | prev) ;; *) echo "usage: ws-cycle.sh next|prev [busy|empty]" >&2; exit 2 ;; esac
case $kind in busy) empty=(--empty no) ;; empty) empty=(--empty) ;; *) echo "usage: ws-cycle.sh next|prev [busy|empty]" >&2; exit 2 ;; esac

cur=$(aerospace list-workspaces --focused)
list=$(aerospace list-workspaces --monitor focused "${empty[@]}")
[ -n "$list" ] || [ "$kind" = busy ] || list=$(aerospace list-workspaces --monitor all --empty)
# the focused workspace counts as a position even when it is not in the list (e.g. empty, going busy)
all=$(aerospace list-workspaces --all | grep -xF -f <( { echo "$list"; echo "$cur"; } | grep -v '^$'))
[ "$dir" = prev ] && all=$(echo "$all" | tail -r)
target=$(echo "$all" | awk -v c="$cur" -v ok="$(echo "$list" | tr '\n' ' ')" '
  BEGIN { n = split(ok, a, " "); for (i = 1; i <= n; i++) good[a[i]] = 1 }
  { w[NR] = $0; if ($0 == c) p = NR }
  END { for (i = 1; i < NR; i++) { j = (p + i - 1) % NR + 1; if (w[j] in good) { print w[j]; exit } } }')
[ -n "$target" ] && aerospace workspace "$target"
