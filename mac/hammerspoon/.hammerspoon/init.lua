-- `hs -c CODE` from the shell (e.g. hs -c "hs.reload()")
require("hs.ipc")

-- Maximize every standard window as soon as it is created
-- local filter = hs.window.filter.new():setDefaultFilter({})
-- filter:subscribe(hs.window.filter.windowCreated, function(win)
-- 	if win:isStandard() then
-- 		win:maximize() -- fills the screen, keeps the menu bar and Dock
-- 	end
-- end)

-- alt-shift-e: toggle AeroSpace window management.
-- Lives here (not in aerospace.toml) because a disabled AeroSpace ignores its own hotkeys.
hs.hotkey.bind({"alt", "shift"}, "e", function()
	hs.execute("/opt/homebrew/bin/aerospace enable toggle")
	hs.alert.show("AeroSpace toggled")
end)

-- A closed window (cmd-w…) leaves AeroSpace with nothing focused and the layout as it was:
-- on-window-closed.sh focuses a remaining window on the workspace and re-arranges it.
-- Global so the filter is not garbage-collected.
closedWindows = hs.window.filter.new(nil)
closedWindows:subscribe(hs.window.filter.windowDestroyed, function()
	hs.task.new(os.getenv("HOME") .. "/.config/aerospace/on-window-closed.sh", nil):start()
end)

-- Start at login so the toggle hotkey is always available
hs.autoLaunch(true)
