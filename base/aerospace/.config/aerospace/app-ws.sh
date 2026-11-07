#!/usr/bin/env bash
# Hyper (right ⌘ via Superkey) + letter: go to the app's home workspace and focus the app there.
#   app-ws.sh WORKSPACE|here BUNDLE-ID     (here = the focused workspace; F10 then a letter)
# A window of the app already on WORKSPACE gets focus. Otherwise, if the app is running:
# Safari/Edge/kitty get a new window there (their other windows stay where they are: links open
# where you click them, alt-shift-b sends a browser window home); any other app's window is pulled
# there. Not running: the app is launched (on-window-detected rules route Outlook/Teams/Koma).
export PATH="/opt/homebrew/bin:/usr/local/bin:$PATH"
ws=$1 bundle=$2
[ -n "$bundle" ] || { echo "usage: app-ws.sh WORKSPACE|here BUNDLE-ID" >&2; exit 2; }
[ "$ws" = here ] && ws=$(aerospace list-workspaces --focused)

aerospace workspace "$ws" 2>/dev/null
win=$(aerospace list-windows --workspace "$ws" --app-bundle-id "$bundle" --format '%{window-id}' | head -1)
[ -n "$win" ] && exec aerospace focus --window-id "$win"
aerospace list-apps --format '%{app-bundle-id}' | grep -qxF "$bundle" || exec open -b "$bundle"

ids() { aerospace list-windows --monitor all --app-bundle-id "$bundle" --format '%{window-id}' | sort; }
before=$(ids)
place_new() { # wait (≤5 s) for the app's new window, move it to $ws (focus may have wandered) and focus it
  local new
  for _ in $(seq 100); do
    new=$(comm -13 <(echo "$before") <(ids) | head -1)
    [ -n "$new" ] && { aerospace move-node-to-workspace --window-id "$new" "$ws" 2>/dev/null; aerospace workspace "$ws" 2>/dev/null; aerospace focus --window-id "$new"; return; }
    sleep 0.05
  done
}

case $bundle in
com.apple.Safari) osascript -e 'tell application "Safari" to make new document' >/dev/null; place_new ;;
com.microsoft.edgemac) open -nb "$bundle" --args --new-window; place_new ;;  # not by name: "Microsoft Edge" can resolve to Teams' WebView
net.kovidgoyal.kitty)
  sock=$(ls -t /tmp/mykitty-* 2>/dev/null | head -1)
  if [ -n "$sock" ] && kitten @ --to "unix:$sock" launch --type=os-window >/dev/null 2>&1; then :; else open -na kitty; fi
  place_new ;;
*)
  win=$(aerospace list-windows --monitor all --app-bundle-id "$bundle" --format '%{window-id}' | head -1)
  if [ -n "$win" ]; then
    aerospace move-node-to-workspace --window-id "$win" "$ws" && aerospace focus --window-id "$win"
  else
    open -b "$bundle"  # running without windows (e.g. Outlook after ⌘W): reopen its window
  fi ;;
esac
