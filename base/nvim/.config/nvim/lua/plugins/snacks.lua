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
		dashboard = { enabled = true },
		explorer = { enabled = true },
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
