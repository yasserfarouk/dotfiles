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

-- Start at login so the toggle hotkey is always available
hs.autoLaunch(true)
