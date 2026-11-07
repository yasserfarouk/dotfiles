#!/usr/bin/env bash
# Point AeroSpace's Koma entries (Hyper+K, the → workspace 9 rule: lines tagged "Koma App") at the
# current Koma App web app. Safari gives a web app a new bundle id each time it is (re)created
# (File > Add to Dock), so run this after recreating it.
#   koma-app-id.sh [PATH-TO-APP]   default: ~/Applications/Koma App.app
export PATH="/opt/homebrew/bin:/usr/local/bin:$PATH"
app=${1:-"$HOME/Applications/Koma App.app"}
cfg=$(realpath "$HOME/.config/aerospace/aerospace.toml")
id=$(defaults read "$app/Contents/Info.plist" CFBundleIdentifier 2>/dev/null) ||
  { echo "koma-app-id: no app at $app" >&2; exit 1; }
old=$(grep 'Koma App' "$cfg" | grep -oE 'com\.apple\.Safari\.WebApp\.[0-9A-Fa-f-]+' | sort -u)
[ -n "$old" ] || { echo "koma-app-id: no tagged Koma App lines in $cfg" >&2; exit 1; }
if [ "$old" = "$id" ]; then echo "koma-app-id: already $id"; exit 0; fi
sed -i '' -E "/Koma App/s/com\.apple\.Safari\.WebApp\.[0-9A-Fa-f-]+/$id/" "$cfg"
aerospace reload-config 2>/dev/null
echo "koma-app-id: $(echo $old) -> $id in $cfg"
