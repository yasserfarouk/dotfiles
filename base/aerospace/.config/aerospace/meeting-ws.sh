#!/usr/bin/env bash
# Meeting windows go to workspace Z (on-window-detected for Zoom and Teams; Google Meet links are
# sent there by browser-here.sh). Called with AEROSPACE_WINDOW_ID = the new window. Its title can
# settle late (Teams), so it is checked for up to 5 s. A meeting window is moved once only, so
# taking it out of Z by hand sticks.
# Z is shown on another screen when that screen's visible workspace is empty (summon-workspace),
# else on the focused one.  `meeting-ws.sh --show` does only that (browser-here.sh, Google Meet).
#   Zoom:  "Zoom Meeting", "Zoom Webinar"
#   Teams: "<subject> | Microsoft Teams" whose first part is not a main-window section
#          (Chat, Calendar, …); "Microsoft Teams" alone (still loading) is not a meeting.
export PATH="/opt/homebrew/bin:/usr/local/bin:$PATH"
win=$AEROSPACE_WINDOW_ID
unset AEROSPACE_WINDOW_ID  # otherwise every aerospace command would target that window
ws=Z

show_ws() { # show $ws: where it is already visible, else on another screen showing an empty workspace, else here
  local focused m vis
  if ! aerospace list-workspaces --monitor all --visible | grep -qxF "$ws"; then
    focused=$(aerospace list-monitors --focused --format '%{monitor-id}')
    for m in $(aerospace list-monitors --format '%{monitor-id}'); do
      [ "$m" = "$focused" ] && continue
      vis=$(aerospace list-workspaces --monitor "$m" --visible)
      [ -n "$vis" ] && [ "$(aerospace list-windows --workspace "$vis" --count)" = 0 ] || continue
      aerospace focus-monitor "$m" && aerospace summon-workspace "$ws" && return
    done
  fi
  aerospace workspace "$ws"
}

[ "${1:-}" = --show ] && { show_ws; exit; }
[ -n "$win" ] || exit 0
state=$HOME/.cache/aerospace-layout/.meetings
mkdir -p "${state%/*}"
grep -qxF "$win" "$state" 2>/dev/null && exit 0

is_meeting() { # BUNDLE TITLE
  case $1 in
  us.zoom.xos) [[ $2 =~ ^Zoom\ (Meeting|Webinar) ]] ;;
  com.microsoft.teams2)
    [[ $2 == *" | Microsoft Teams" ]] || return 1
    local first=${2%% | *}
    case $first in
    Activity | Chat | Teams | Calendar | Calls | OneDrive | Files | Apps | Copilot | Communities | \
      Assignments | Approvals | Planner | Help | Settings | Search | People | Notifications | "Microsoft Teams") return 1 ;;
    esac ;;
  *) return 1 ;;
  esac
}

for _ in $(seq 25); do
  info=$(aerospace list-windows --all --format '%{window-id}|%{app-bundle-id}|%{workspace}|%{window-title}' |
    awk -F'|' -v w="$win" '$1 == w { sub(/^[^|]*\|/, ""); print; exit }')
  [ -n "$info" ] || exit 0  # closed
  bundle=${info%%|*} rest=${info#*|}
  title=${rest#*|}
  if is_meeting "$bundle" "$title"; then
    echo "$win" >>"$state"
    [ "${rest%%|*}" = "$ws" ] || aerospace move-node-to-workspace --window-id "$win" "$ws"
    show_ws
    aerospace focus --window-id "$win"
    AEROSPACE_WINDOW_ID=$win exec "$(dirname "$0")/layout-cycle.sh" regrid
  fi
  sleep 0.2
done
