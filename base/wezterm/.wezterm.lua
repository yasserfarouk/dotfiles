-- Pull in the wezterm API
local wezterm = require("wezterm")
local mux = wezterm.mux

wezterm.on("gui-attached", function(domain)
	-- maximize all displayed windows on startup
	local workspace = mux.get_active_workspace()
	for _, window in ipairs(mux.all_windows()) do
		if window:get_workspace() == workspace then
			window:set_position(0, 0)
			window:set_inner_size(wezterm.screen.get_width(), wezterm.screen.get_height())
			-- window:gui_window():maximize()
		end
	end
end)
-- This table will hold the configuration.
local config = {}

-- In newer versions of wezterm, use the config_builder which will
-- help provide clearer error messages
if wezterm.config_builder then
	config = wezterm.config_builder()
end

-- This is where you actually apply your config choices

-- For example, changing the color scheme:
-- config.color_scheme = 'AdventureTime'
config.color_scheme = "Tokyo Night"
config.font = wezterm.font_with_fallback({
	"JetBrainsMono Nerd Font",
	{ family = "Symbols Nerd Font Mono" },
	"Noto Color Emoji",
})
config.hide_tab_bar_if_only_one_tab = true
config.window_decorations = "RESIZE"
config.scrollback_lines = 5000
config.use_cap_height_to_scale_fallback_fonts = true
config.window_background_opacity = 0.85
config.front_end = "WebGpu"

-- and finally, return the configuration to wezterm
return config
