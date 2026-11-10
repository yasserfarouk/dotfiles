#!/usr/bin/env bash
# Open a link in the AeroSpace workspace you clicked it from, not wherever the browser already is.
# Called by the Finicky helper apps ~/Applications/{Safari,Edge}Here.app (`browser-rule install`).
#   browser-here.sh safari|edge URL
# A browser window already in the focused workspace gets the link as a new tab; otherwise the link
# opens in a new window, which AeroSpace puts in the focused workspace. alt-shift-b
# (browser-home.sh) later sends that window back to the browser's main workspace.
export PATH="/opt/homebrew/bin:/usr/local/bin:$PATH"
browser=$1 url=$2
case $browser in
safari) bundle=com.apple.Safari ;;
edge) bundle=com.microsoft.edgemac ;;  # by bundle id: the name "Microsoft Edge" can resolve to Teams' WebView
*) echo "usage: browser-here.sh safari|edge URL" >&2; exit 2 ;;
esac

# a Google Meet meeting link opens in the meeting workspace Z instead (meeting-ws.sh: Teams/Zoom)
[[ $url =~ ^https?://meet\.google\.com/[a-z]{3}-[a-z]{4}-[a-z]{3} ]] && aerospace workspace Z 2>/dev/null

# not running, or no AeroSpace: the plain way (a fresh browser opens in the focused workspace anyway)
if ! aerospace list-apps --format '%{app-bundle-id}' 2>/dev/null | grep -qxF "$bundle" || ! win=$(aerospace list-windows --workspace focused --app-bundle-id "$bundle" --format '%{window-id}' 2>/dev/null); then
  exec open -b "$bundle" "$url"
fi
win=${win%%$'\n'*}

if [ -n "$win" ]; then  # a window here: new tab in it
  aerospace focus --window-id "$win"
  if [ "$browser" = safari ]; then
    osascript - "$win" "$url" <<'AS'
on run argv
  tell application "Safari"
    tell (first window whose id is (item 1 of argv as integer))
      set current tab to (make new tab with properties {URL:item 2 of argv})
    end tell
    activate
  end tell
end run
AS
  else
    open -b "$bundle" "$url"  # Chromium opens it in its last active window, the one just focused
  fi
elif [ "$browser" = safari ]; then
  new=$(osascript - "$url" <<'AS'
on run argv
  tell application "Safari"
    make new document with properties {URL:item 1 of argv}
    activate
    return id of front window
  end tell
end run
AS
)
  for _ in $(seq 40); do  # focus it once AeroSpace has seen it
    aerospace focus --window-id "$new" 2>/dev/null && break
    sleep 0.05
  done
else  # Edge: new window, then make sure it is here (focus can wander while it opens)
  ws=$(aerospace list-workspaces --focused)
  ids() { aerospace list-windows --monitor all --app-bundle-id "$bundle" --format '%{window-id}' | sort; }
  before=$(ids)
  open -nb "$bundle" --args --new-window "$url"
  for _ in $(seq 100); do
    new=$(comm -13 <(echo "$before") <(ids) | head -1)
    [ -n "$new" ] && { aerospace move-node-to-workspace --window-id "$new" "$ws" 2>/dev/null; aerospace workspace "$ws" 2>/dev/null; aerospace focus --window-id "$new"; break; }
    sleep 0.05
  done
fi
