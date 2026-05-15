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
-- KEYBINDINGS
-- On Windows/Linux, CTRL|SHIFT acts as kitty_mod (which is cmd on macOS).
-- Mapping reference: kitty_mod → CTRL|SHIFT, cmd → CTRL|SHIFT
-- =============================================================================
config.leader = { key = "a", mods = "CTRL", timeout_milliseconds = 1000 }

config.keys = {
	-- ---------------------------------------------------------------------------
	-- CLIPBOARD (matching Kitty: kitty_mod+c copy, kitty_mod+v paste)
	-- ---------------------------------------------------------------------------
	{ key = "c", mods = "CTRL|SHIFT", action = act.CopyTo("Clipboard") },
	{ key = "v", mods = "CTRL|SHIFT", action = act.PasteFrom("Clipboard") },

	-- ---------------------------------------------------------------------------
	-- SPLITS (matching Kitty: kitty_mod+shift+- hsplit, kitty_mod+\ vsplit)
	-- ---------------------------------------------------------------------------
	{ key = "_", mods = "CTRL|SHIFT", action = act.SplitVertical({ domain = "CurrentPaneDomain" }) },
	{ key = "\\", mods = "CTRL", action = act.SplitHorizontal({ domain = "CurrentPaneDomain" }) },

	-- ---------------------------------------------------------------------------
	-- TABS (matching Kitty: kitty_mod+t / kitty_mod+n new tab, kitty_mod+enter new window)
	-- ---------------------------------------------------------------------------
	{ key = "+", mods = "CTRL|SHIFT", action = act.SpawnTab("CurrentPaneDomain") },
	{ key = "n", mods = "CTRL|SHIFT", action = act.SpawnTab("CurrentPaneDomain") },
	{ key = "Enter", mods = "CTRL|SHIFT", action = act.SpawnWindow },

	-- Close tab (matching Kitty: kitty_mod+alt+x close_tab)
	{ key = "x", mods = "CTRL|ALT", action = act.CloseCurrentTab({ confirm = false }) },

	-- Tab navigation (matching Kitty: cmd+, / cmd+. previous/next tab)
	{ key = ",", mods = "CTRL", action = act.ActivateTabRelative(-1) },
	{ key = ".", mods = "CTRL", action = act.ActivateTabRelative(1) },
	-- ctrl+tab / ctrl+shift+tab (matching Kitty: ctrl+tab next_tab)
	{ key = "Tab", mods = "CTRL", action = act.ActivateTabRelative(1) },
	{ key = "Tab", mods = "CTRL|SHIFT", action = act.ActivateTabRelative(-1) },

	-- Tab switch by number: ALT+1-9 (standard Windows/Linux convention)
	{ key = "1", mods = "ALT", action = act.ActivateTab(0) },
	{ key = "2", mods = "ALT", action = act.ActivateTab(1) },
	{ key = "3", mods = "ALT", action = act.ActivateTab(2) },
	{ key = "4", mods = "ALT", action = act.ActivateTab(3) },
	{ key = "5", mods = "ALT", action = act.ActivateTab(4) },
	{ key = "6", mods = "ALT", action = act.ActivateTab(5) },
	{ key = "7", mods = "ALT", action = act.ActivateTab(6) },
	{ key = "8", mods = "ALT", action = act.ActivateTab(7) },
	{ key = "9", mods = "ALT", action = act.ActivateTab(8) },

	-- Rename tab title (matching Kitty: kitty_mod+shift+t set_tab_title)
	{
		key = "t",
		mods = "CTRL|SHIFT",
		action = act.PromptInputLine({
			description = "Enter new tab title:",
			action = wezterm.action_callback(function(window, pane, line)
				if line then
					window:active_tab():set_title(line)
				end
			end),
		}),
	},

	-- Rename window/pane title (matching Kitty: kitty_mod+alt+t set_window_title)
	{
		key = "t",
		mods = "CTRL|ALT",
		action = act.PromptInputLine({
			description = "Enter new pane title:",
			action = wezterm.action_callback(function(window, pane, line)
				if line then
					pane:set_title(line)
				end
			end),
		}),
	},

	-- ---------------------------------------------------------------------------
	-- PANE MANAGEMENT (matching Kitty window management)
	-- ---------------------------------------------------------------------------
	-- Close pane (matching Kitty: kitty_mod+x close_window)
	{ key = "x", mods = "CTRL|SHIFT", action = act.CloseCurrentPane({ confirm = false }) },

	-- Navigate panes (matching Kitty: kitty_mod+] next_window, kitty_mod+[ previous_window)
	{ key = "]", mods = "CTRL|SHIFT", action = act.ActivatePaneDirection("Next") },
	{ key = "[", mods = "CTRL|SHIFT", action = act.ActivatePaneDirection("Prev") },

	-- Select pane by number (matching Kitty: kitty_mod+1-9 first/second.../ninth_window)
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

	-- Move pane forward/backward in stack (matching Kitty: kitty_mod+f/b move_window_forward/backward)
	{ key = "f", mods = "CTRL|SHIFT", action = act.RotatePanes("Clockwise") },
	{ key = "b", mods = "CTRL|SHIFT", action = act.RotatePanes("CounterClockwise") },

	-- Move panes directionally (matching Kitty: kitty_mod+alt+arrow move_window direction)
	{ key = "LeftArrow", mods = "CTRL|ALT", action = act.RotatePanes("CounterClockwise") },
	{ key = "RightArrow", mods = "CTRL|ALT", action = act.RotatePanes("Clockwise") },

	-- Detach pane to new tab (matching Kitty: kitty_mod+d detach_window new-tab)
	{
		key = "d",
		mods = "CTRL|SHIFT",
		action = wezterm.action_callback(function(_, pane)
			pane:move_to_new_tab()
		end),
	},

	-- Toggle pane zoom / full-screen pane (matching Kitty: kitty_mod+f goto_layout stack)
	{ key = "z", mods = "CTRL|SHIFT", action = act.TogglePaneZoomState },

	-- ---------------------------------------------------------------------------
	-- SCROLLING (matching Kitty: kitty_mod+k/j scroll_line_up/down)
	-- ---------------------------------------------------------------------------
	{ key = "k", mods = "CTRL|SHIFT", action = act.ScrollByLine(-1) },
	{ key = "j", mods = "CTRL|SHIFT", action = act.ScrollByLine(1) },
	{ key = "UpArrow", mods = "CTRL|SHIFT", action = act.ScrollByLine(-1) },
	{ key = "DownArrow", mods = "CTRL|SHIFT", action = act.ScrollByLine(1) },
	{ key = "PageUp", mods = "CTRL|SHIFT", action = act.ScrollByPage(-1) },
	{ key = "PageDown", mods = "CTRL|SHIFT", action = act.ScrollByPage(1) },
	{ key = "Home", mods = "CTRL|SHIFT", action = act.ScrollToTop },
	{ key = "End", mods = "CTRL|SHIFT", action = act.ScrollToBottom },

	-- Show scrollback / copy mode (matching Kitty: kitty_mod+h show_scrollback)
	{ key = "h", mods = "CTRL|SHIFT", action = act.ActivateCopyMode },

	-- ---------------------------------------------------------------------------
	-- FONT SIZE (matching Kitty: cmd+equal/minus/0)
	-- ---------------------------------------------------------------------------
	{ key = "=", mods = "CTRL", action = act.IncreaseFontSize },
	{ key = "-", mods = "CTRL", action = act.DecreaseFontSize },
	{ key = "0", mods = "CTRL", action = act.ResetFontSize },

	-- ---------------------------------------------------------------------------
	-- WINDOW DECORATIONS
	-- ---------------------------------------------------------------------------
	-- Fullscreen (matching Kitty: kitty_mod+f11 toggle_fullscreen)
	{ key = "F11", mods = "CTRL|SHIFT", action = act.ToggleFullScreen },
	{ key = "f", mods = "CTRL|SHIFT|ALT", action = act.ToggleFullScreen },

	-- Pane resizing (matching Kitty: alt+shift+arrow resize_window wider/taller/etc.)
	{ key = "LeftArrow", mods = "ALT|SHIFT", action = act.AdjustPaneSize({ "Left", 5 }) },
	{ key = "RightArrow", mods = "ALT|SHIFT", action = act.AdjustPaneSize({ "Right", 5 }) },
	{ key = "UpArrow", mods = "ALT|SHIFT", action = act.AdjustPaneSize({ "Up", 5 }) },
	{ key = "DownArrow", mods = "ALT|SHIFT", action = act.AdjustPaneSize({ "Down", 5 }) },
	-- Fine-grained resize with alt+arrow (1 cell at a time)
	{ key = "LeftArrow", mods = "ALT", action = act.AdjustPaneSize({ "Left", 1 }) },
	{ key = "RightArrow", mods = "ALT", action = act.AdjustPaneSize({ "Right", 1 }) },
	{ key = "UpArrow", mods = "ALT", action = act.AdjustPaneSize({ "Up", 1 }) },
	{ key = "DownArrow", mods = "ALT", action = act.AdjustPaneSize({ "Down", 1 }) },

	-- ---------------------------------------------------------------------------
	-- HINTS / QUICK SELECT (matching Kitty: kitty_mod+shift+e kitten hints)
	-- ---------------------------------------------------------------------------
	{
		key = "e",
		mods = "CTRL|SHIFT",
		action = act.QuickSelectArgs({
			label = "open url",
			patterns = {
				"https?://[\\w@:%./+~#?=&\\-]+",
			},
			action = wezterm.action_callback(function(window, pane)
				local url = window:get_selection_text_for_pane(pane)
				if url then
					wezterm.open_with(url)
				end
			end),
		}),
	},

	-- ---------------------------------------------------------------------------
	-- MISC
	-- ---------------------------------------------------------------------------
	-- Clear terminal scrollback (matching Kitty: kitty_mod+delete clear_terminal reset)
	{ key = "Delete", mods = "CTRL|SHIFT", action = act.ClearScrollback("ScrollbackAndViewport") },

	-- Unicode input (matching Kitty: kitty_mod+u unicode_input)
	{ key = "u", mods = "CTRL|SHIFT", action = act.CharSelect },

	-- Launch lazygit in new tab (matching Kitty: cmd+g / kitty_mod+g)
	{
		key = "g",
		mods = "CTRL|SHIFT",
		action = act.SpawnCommandInNewTab({
			args = { "lazygit" },
		}),
	},

	-- Ctrl+Enter for neovim CSI-u sequence (matching Kitty: send_text all \x1b[13;5u)
	{ key = "Enter", mods = "CTRL", action = act.SendString("\x1b[13;5u") },

	-- Ctrl+; for neovim copilot accept (matching Kitty: send_text all \x1b[59;5u)
	{ key = ";", mods = "CTRL", action = act.SendString("\x1b[59;5u") },

	-- Pass through ctrl+j/k/h/l for neovim navigation (matching Kitty: no_op passthrough)
	{ key = "j", mods = "CTRL", action = act.SendKey({ key = "j", mods = "CTRL" }) },
	{ key = "k", mods = "CTRL", action = act.SendKey({ key = "k", mods = "CTRL" }) },
	{ key = "h", mods = "CTRL", action = act.SendKey({ key = "h", mods = "CTRL" }) },
	{ key = "l", mods = "CTRL", action = act.SendKey({ key = "l", mods = "CTRL" }) },
}

-- and finally, return the configuration to wezterm
return config
