#!/usr/bin/env bash
# alt-shift-b: send the focused browser window back to the browser's home workspace (Safari 2,
# Edge 3, as for the Hyper keys; Finder 8; any other app: the other workspace holding most of its
# windows) — the undo of browser-here.sh opening links in place (and of Finder windows opening in
# the current workspace). Finder windows move as separate windows: AeroSpace treats a native
# Finder tab as its own window, so a hidden tab would leave an empty tile. Safari: its tabs move into the first Safari
# window there (the emptied window closes); with none there, or another app, the window moves.
# You stay in the current workspace.
export PATH="/opt/homebrew/bin:/usr/local/bin:$PATH"
note() { osascript -e "display notification \"$1\" with title \"Browser → home\""; }

IFS='|' read -r win bundle ws < <(aerospace list-windows --focused --format '%{window-id}|%{app-bundle-id}|%{workspace}')
[ -n "$win" ] || exit 0
case $bundle in  # home workspaces of the Hyper keys (app-ws.sh)
com.apple.Safari) home=2 ;;
com.microsoft.edgemac) home=3 ;;
com.apple.finder) home=8 ;;
*) home=$(aerospace list-windows --monitor all --app-bundle-id "$bundle" --format '%{workspace}' |
  grep -vxF "$ws" | sort | uniq -c | sort -k1,1nr | awk 'NR == 1 { print $2 }') ;;
esac
[ -n "$home" ] || { note "No other workspace has this app's windows"; exit 0; }
[ "$home" != "$ws" ] || { note "Already in its home workspace $home"; exit 0; }
target=$(aerospace list-windows --workspace "$home" --app-bundle-id "$bundle" --format '%{window-id}' | head -1)

if [ "$bundle" = com.apple.Safari ] && [ -n "$target" ]; then
  # moving the last tab closes the source window
  osascript - "$win" "$target" <<'AS' || exit 1
on run argv
  tell application "Safari"
    set src to first window whose id is (item 1 of argv as integer)
    set dst to first window whose id is (item 2 of argv as integer)
    repeat with t in (get tabs of src)
      move t to end of tabs of dst
    end repeat
    set current tab of dst to last tab of dst
  end tell
end run
AS
else
  aerospace move-node-to-workspace --window-id "$win" "$home"
fi
