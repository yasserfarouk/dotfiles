return {
	"folke/snacks.nvim",
	priority = 1000,
	lazy = false,
	---@type snacks.Config
	opts = {
		-- your configuration comes here
		-- or leave it empty to use the default settings
		-- refer to the configuration section below
		bigfile = { enabled = true },
		dashboard = {

			sections = {
				{ section = "header" },
				{
					pane = 2,
					section = "terminal",
					cmd = "hostname",
					height = 5,
					padding = 1,
				},
				{
					pane = 2,
					icon = " ",
					desc = "Browse Repo",
					padding = 1,
					key = "b",
					action = function()
						Snacks.gitbrowse()
					end,
				},
				{ section = "keys", gap = 1, padding = 1 },
				{ pane = 2, icon = " ", title = "Recent Files", section = "recent_files", indent = 2, padding = 1 },
				{ pane = 2, icon = " ", title = "Projects", section = "projects", indent = 2, padding = 1 },
				{
					pane = 2,
					icon = " ",
					title = "Git Status",
					section = "terminal",
					enabled = function()
						return Snacks.git.get_root() ~= nil
					end,
					cmd = "git status --short --branch --renames",
					height = 5,
					padding = 1,
					ttl = 5 * 60,
					indent = 3,
				},
				{ section = "startup" },
			},
		},

		explorer = {
			enabled = true,
			finder = "explorer",
			sort = { fields = { "sort" } },
			focus = "list",
			auto_close = false,
			jump = { close = false },
			layout = { preset = "sidebar", preview = false },
			-- to show the explorer to the right, add the below to
			-- your config under `opts.picker.sources.explorer`
			-- layout = { layout = { position = "right" } },
			formatters = {
				file = { filename_only = true },
				severity = { pos = "right" },
			},
			matcher = { sort_empty = false, fuzzy = true },
			config = function(opts)
				return require("snacks.picker.source.explorer").setup(opts)
			end,
		},
		indent = { enabled = true },
		image = {
			enabled = true,
			doc = { inline = true },
			-- Other image-related options from snacks.nvim documentation
			max_width = 100, -- Example max width in columns
			max_height_percent = 0.6, -- Example max height as 60% of window height
			-- Add RST specific configuration here
			filetypes = {
				"markdown", -- Keep default ones if you use them
				"norg",
				"help",
				-- Add RST types:
				"rst",
				"rest",
				"restructuredtext",
			},

			img_dirs = {
				"img",
				"images",
				"assets",
				"_static",
				"_static/images",
				"static",
				"public",
				"media",
				"attachments",
			},
			source_patterns = {
				-- Keep existing default patterns if needed (example for markdown)
				markdown = { "!\\[.*\\]\\(([^)]+)\\)" }, -- Pattern(s) for markdown
				-- Add patterns specifically for RST filetypes
				-- This pattern looks for '.. image:: path' or '.. figure:: path'
				-- %s* -> optional leading space
				-- %.%.%s+  -> '.. ' followed by space
				-- (image|figure) -> 'image' or 'figure'
				-- ::%s* -> '::' followed by optional space
				-- (%S+)    -> captures the non-whitespace path
				rst = { "%s*%.%.%s+(image|figure)::%s*(%S+)" },
				rest = { "%s*%.%.%s+(image|figure)::%s*(%S+)" },
				restructuredtext = { "%s*%.%.%s+(image|figure)::%s*(%S+)" },
			},
		},
		input = { enabled = true },
		picker = { enabled = false },
		notifier = { enabled = true },
		quickfile = { enabled = true },
		scope = { enabled = false },
		scroll = { enabled = false },
		statuscolumn = { enabled = true },
		words = { enabled = true },
	},
	keys = {
		{ "<leader>e", ":lua Snacks.explorer()<cr>", desc = "explorer on root" },
		{ "<leader>E", ":lua Snacks.explorer.reveal()<cr>", desc = "explorer" },
		{ "<leader>.", ":lua Snacks.dashboard()<cr>", desc = "dashboard" },
	},
}
