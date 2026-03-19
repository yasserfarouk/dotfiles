-- Pull in the wezterm API
local wezterm = require("wezterm")
local mux = wezterm.mux
local act = wezterm.action

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

-- =============================================================================
-- COLORS (matching Kitty's Tokyo Night theme)
-- =============================================================================
config.color_scheme = "Tokyo Night"

-- =============================================================================
-- FONTS (matching Kitty: JetBrainsMonoNL Nerd Font Mono, size 13.0, cell_width 95%)
-- =============================================================================
config.font = wezterm.font_with_fallback({
	{
		family = "JetBrainsMonoNL Nerd Font Mono",
		weight = "Regular",
	},
	{ family = "Symbols Nerd Font Mono" },
	"Noto Color Emoji",
})
config.font_size = 13.0
-- cell_width 95% equivalent - WezTerm uses cell_width as a multiplier
config.cell_width = 0.95
-- adjust_column_width -1 equivalent
config.line_height = 1.0

-- =============================================================================
-- CURSOR (matching Kitty: cursor_blink_interval 0 - disabled)
-- =============================================================================
config.default_cursor_style = "SteadyBlock"
-- Disable cursor blinking (cursor_blink_interval 0 in kitty)
config.cursor_blink_rate = 0

-- =============================================================================
-- SCROLLBACK (matching Kitty: scrollback_lines 10000)
-- =============================================================================
config.scrollback_lines = 10000

-- =============================================================================
-- BELL (matching Kitty: enable_audio_bell no, visual_bell_duration 0.1)
-- =============================================================================
config.audible_bell = "Disabled"
config.visual_bell = {
	fade_in_duration_ms = 50,
	fade_out_duration_ms = 50,
	target = "CursorColor",
}

-- =============================================================================
-- WINDOW (matching Kitty settings)
-- =============================================================================
-- window_padding_width 1.0 in kitty
config.window_padding = {
	left = 1,
	right = 1,
	top = 1,
	bottom = 1,
}
-- background_opacity 0.9 in kitty
config.window_background_opacity = 0.9
-- hide_window_decorations titlebar-only equivalent
config.window_decorations = "RESIZE"
-- inactive_text_alpha 0.5 in kitty
config.inactive_pane_hsb = {
	saturation = 0.9,
	brightness = 0.5,
}

-- =============================================================================
-- TAB BAR (matching Kitty settings)
-- =============================================================================
config.hide_tab_bar_if_only_one_tab = true
config.use_fancy_tab_bar = false
-- active_tab_font_style normal in kitty
config.window_frame = {
	font = wezterm.font({ family = "JetBrainsMonoNL Nerd Font Mono", weight = "Regular" }),
	font_size = 13.0,
}

-- =============================================================================
-- MISC
-- =============================================================================
config.use_cap_height_to_scale_fallback_fonts = true
config.front_end = "WebGpu"
-- confirm_os_window_close 0 in kitty
config.window_close_confirmation = "NeverPrompt"

-- =============================================================================
-- KEYBINDINGS (Windows equivalents for Kitty's Cmd-based Mac shortcuts)
-- On Windows, we use Ctrl+Shift as the leader (similar to kitty_mod = cmd on Mac)
-- =============================================================================
config.leader = { key = "a", mods = "CTRL", timeout_milliseconds = 1000 }

config.keys = {
	-- Splits (matching Kitty: cmd+shift+- for hsplit, cmd+\ for vsplit)
	{ key = "_", mods = "CTRL|SHIFT", action = act.SplitVertical({ domain = "CurrentPaneDomain" }) },
	{ key = "\\", mods = "CTRL", action = act.SplitHorizontal({ domain = "CurrentPaneDomain" }) },

	-- New tab (matching Kitty: cmd+shift+= for new tab)
	{ key = "+", mods = "CTRL|SHIFT", action = act.SpawnTab("CurrentPaneDomain") },

	-- Close pane (matching Kitty: cmd+x)
	{ key = "x", mods = "CTRL|SHIFT", action = act.CloseCurrentPane({ confirm = false }) },

	-- Navigate panes (matching Kitty: cmd+] and cmd+[ for next/prev window)
	{ key = "]", mods = "CTRL|SHIFT", action = act.ActivatePaneDirection("Next") },
	{ key = "[", mods = "CTRL|SHIFT", action = act.ActivatePaneDirection("Prev") },

	-- Tab navigation (matching Kitty: cmd+, and cmd+. for prev/next tab)
	{ key = ",", mods = "CTRL", action = act.ActivateTabRelative(-1) },
	{ key = ".", mods = "CTRL", action = act.ActivateTabRelative(1) },

	-- New tab (matching Kitty: cmd+n for new_tab_with_cwd)
	{ key = "n", mods = "CTRL|SHIFT", action = act.SpawnTab("CurrentPaneDomain") },

	-- New window (matching Kitty: cmd+enter for new_window_with_cwd)
	{ key = "Enter", mods = "CTRL|SHIFT", action = act.SpawnWindow },

	-- Close tab (matching Kitty: cmd+alt+x for close_tab)
	{ key = "x", mods = "CTRL|ALT", action = act.CloseCurrentTab({ confirm = false }) },

	-- Scrolling (matching Kitty: cmd+k/j for scroll up/down)
	{ key = "k", mods = "CTRL|SHIFT", action = act.ScrollByLine(-1) },
	{ key = "j", mods = "CTRL|SHIFT", action = act.ScrollByLine(1) },
	{ key = "UpArrow", mods = "CTRL|SHIFT", action = act.ScrollByLine(-1) },
	{ key = "DownArrow", mods = "CTRL|SHIFT", action = act.ScrollByLine(1) },

	-- Show scrollback (matching Kitty: cmd+h for show_scrollback)
	{ key = "h", mods = "CTRL|SHIFT", action = act.ActivateCopyMode },

	-- Font size (matching Kitty: cmd+equal/minus/0)
	{ key = "=", mods = "CTRL", action = act.IncreaseFontSize },
	{ key = "-", mods = "CTRL", action = act.DecreaseFontSize },
	{ key = "0", mods = "CTRL", action = act.ResetFontSize },

	-- Fullscreen (matching Kitty: cmd+shift+f for toggle_fullscreen)
	{ key = "f", mods = "CTRL|SHIFT|ALT", action = act.ToggleFullScreen },

	-- Pane resizing (matching Kitty: alt+arrow keys)
	{ key = "LeftArrow", mods = "ALT", action = act.AdjustPaneSize({ "Left", 1 }) },
	{ key = "RightArrow", mods = "ALT", action = act.AdjustPaneSize({ "Right", 1 }) },
	{ key = "UpArrow", mods = "ALT", action = act.AdjustPaneSize({ "Up", 1 }) },
	{ key = "DownArrow", mods = "ALT", action = act.AdjustPaneSize({ "Down", 1 }) },

	-- Move panes (matching Kitty: cmd+alt+arrow for move_window)
	{ key = "LeftArrow", mods = "CTRL|ALT", action = act.RotatePanes("CounterClockwise") },
	{ key = "RightArrow", mods = "CTRL|ALT", action = act.RotatePanes("Clockwise") },

	-- Pane selection by number (matching Kitty: cmd+1-9 for window selection)
	{ key = "1", mods = "CTRL|SHIFT", action = act.ActivatePaneByIndex(0) },
	{ key = "2", mods = "CTRL|SHIFT", action = act.ActivatePaneByIndex(1) },
	{ key = "3", mods = "CTRL|SHIFT", action = act.ActivatePaneByIndex(2) },
	{ key = "4", mods = "CTRL|SHIFT", action = act.ActivatePaneByIndex(3) },
	{ key = "5", mods = "CTRL|SHIFT", action = act.ActivatePaneByIndex(4) },
	{ key = "6", mods = "CTRL|SHIFT", action = act.ActivatePaneByIndex(5) },
	{ key = "7", mods = "CTRL|SHIFT", action = act.ActivatePaneByIndex(6) },
	{ key = "8", mods = "CTRL|SHIFT", action = act.ActivatePaneByIndex(7) },
	{ key = "9", mods = "CTRL|SHIFT", action = act.ActivatePaneByIndex(8) },
	{ key = "0", mods = "CTRL|SHIFT", action = act.ActivatePaneByIndex(9) },

	-- Clear terminal (matching Kitty: cmd+delete for clear_terminal reset)
	{ key = "Delete", mods = "CTRL|SHIFT", action = act.ClearScrollback("ScrollbackAndViewport") },

	-- Unicode input (matching Kitty: cmd+u for unicode_input)
	{ key = "u", mods = "CTRL|SHIFT", action = act.CharSelect },

	-- Launch lazygit (matching Kitty: cmd+g)
	{
		key = "g",
		mods = "CTRL|SHIFT",
		action = act.SpawnCommandInNewTab({
			args = { "lazygit" },
		}),
	},

	-- Ctrl+Enter for neovim (matching Kitty: send_text all \x1b[13;5u)
	{ key = "Enter", mods = "CTRL", action = act.SendString("\x1b[13;5u") },

	-- Ctrl+; for neovim copilot (matching Kitty: send_text all \x1b[59;5u)
	{ key = ";", mods = "CTRL", action = act.SendString("\x1b[59;5u") },

	-- Pass through ctrl+j/k/h/l for neovim navigation (matching Kitty: no_op)
	{ key = "j", mods = "CTRL", action = act.SendKey({ key = "j", mods = "CTRL" }) },
	{ key = "k", mods = "CTRL", action = act.SendKey({ key = "k", mods = "CTRL" }) },
	{ key = "h", mods = "CTRL", action = act.SendKey({ key = "h", mods = "CTRL" }) },
	{ key = "l", mods = "CTRL", action = act.SendKey({ key = "l", mods = "CTRL" }) },
}

-- and finally, return the configuration to wezterm
return config
