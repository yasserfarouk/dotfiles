local windows = function()
	return vim.fn.has("win32") == 1 or vim.fn.has("win64") == 1 or vim.fn.has("win16") == 1
end
function alphaconf()
	local status_ok, alpha = pcall(require, "alpha")
	if not status_ok then
		return
	end

	local dashboard = require("alpha.themes.dashboard")
	dashboard.section.header.val = {
		[[                               __                ]],
		[[  ___     ___    ___   __  __ /\_\    ___ ___    ]],
		[[ / _ `\  / __`\ / __`\/\ \/\ \\/\ \  / __` __`\  ]],
		[[/\ \/\ \/\  __//\ \_\ \ \ \_/ |\ \ \/\ \/\ \/\ \ ]],
		[[\ \_\ \_\ \____\ \____/\ \___/  \ \_\ \_\ \_\ \_\]],
		[[ \/_/\/_/\/____/\/___/  \/__/    \/_/\/_/\/_/\/_/]],
	}
	dashboard.section.buttons.val = {
		dashboard.button("f", "  Find file", ":Telescope find_files<CR>"),
		dashboard.button("e", "  New file", ":ene <BAR> startinsert<CR>"),
		dashboard.button("P", "  Find project", ":Telescope project<CR>"),
		dashboard.button("p", "  Recent project", ":Telescope projects<CR>"),
		dashboard.button("r", "  Recently used files", ":Telescope oldfiles<CR>"),
		dashboard.button("t", "  Find text", ":Telescope live_grep<CR>"),
		dashboard.button("c", "  Configuration", ":e ~/.config/nvim/init.lua<CR>"),
		dashboard.button("z", "  Plugins", "<cmd>Lazy<CR>"),
		dashboard.button("q", "  Quit Neovim", ":qa<CR>"),
		dashboard.button("v", "🖊️  Vim File", ":TelescopeVim<CR>"),
	}
	local function footer()
		-- NOTE: requires the fortune-mod package to work
		-- local handle = io.popen("fortune")
		-- local fortune = handle:read("*a")
		-- handle:close()
		-- return fortune
		return "Yasser Mohammad"
	end

	dashboard.section.footer.val = footer()

	dashboard.section.footer.opts.hl = "Type"
	dashboard.section.header.opts.hl = "Include"
	dashboard.section.buttons.opts.hl = "Keyword"

	-- dashboard.opts.opts.noautocmd = true
	-- vim.cmd([[autocmd User AlphaReady echo 'ready']])
	alpha.setup(dashboard.opts)
end

function transparentconf()
	require("transparent").setup({
		enable = true,
		extra_groups = { -- table/string: additional groups that should be clear
			-- In particular, when you set it to 'all', that means all avaliable groups

			-- example of akinsho/nvim-bufferline.lua
			"BufferLineTabClose",
			"BufferlineBufferSelected",
			"BufferLineFill",
			"BufferLineBackground",
			"BufferLineSeparator",
			"BufferLineIndicatorSelected",
		},
		exclude = {}, -- table: groups you don't want to clear
	})

	local status_ok, notify = pcall(require, "notify")
	if status_ok then
		notify.setup({
			background_colour = "#000000",
		})
	end
end

return {
	{
		"goolord/alpha-nvim",
		config = alphaconf,
	},
	"rcarriga/nvim-notify",
	-- transparent background
	{
		"xiyaowong/nvim-transparent",
		dependencies = { "rcarriga/nvim-notify" },
		config = transparentconf,
	},
	-- {
	-- 	"nvim-lualine/lualine.nvim",
	-- 	config = function()
	-- 		require("yasser.theme.lualine")
	-- 	end,
	-- },
	-- {
	-- 	"akinsho/bufferline.nvim",
	-- 	dependencies = "kyazdani42/nvim-web-devicons",
	-- 	config = function()
	-- 		require("yasser.theme.bufferline")
	-- 	end,
	-- },
	-- show indent lines
	{
		"lukas-reineke/indent-blankline.nvim",
		config = function()
			vim.g.indent_blankline_char = "│"
			vim.g.yasser = true
			vim.g.indent_blankline_filetype_exclude =
				{ "help", "nvimtree", "fern", "packer", "dashboard", "alpha", "ALPHA" }
			vim.g.indent_blankline_buftype_exclude = { "terminal" }
			vim.g.indent_blankline_show_current_context = false
			vim.g.indent_blankline_context_patterns = {
				"class",
				"return",
				"function",
				"method",
				"^if",
				"^while",
				"jsx_element",
				"^for",
				"^object",
				"^table",
				"block",
				"arguments",
				"if_statement",
				"else_clause",
				"jsx_element",
				"jsx_self_closing_element",
				"try_statement",
				"catch_clause",
				"import_statement",
			}
		end,
		-- disable = windows(),
	},
	-- UI improvements
	-- {
	-- 	"stevearc/dressing.nvim",
	-- 	event = "BufReadPre",
	-- 	config = function()
	-- 		require("dressing").setup({
	-- 			input = { relative = "editor" },
	-- 			select = {
	-- 				backend = { "telescope", "fzf", "builtin" },
	-- 			},
	-- 		})
	-- 	end,
	-- 	disable = false,
	-- },
	--

	-- Color
	"christianchiarulli/nvcode-color-schemes.vim",
	"folke/tokyonight.nvim",

	-- Icons
	"kyazdani42/nvim-web-devicons",

	-- {
	-- 	"folke/noice.nvim",
	-- 	config = function()
	-- 		require("noice").setup({
	-- 	lsp = {
	--     -- override markdown rendering so that **cmp** and other plugins use **Treesitter**
	--     override = {
	--       ["vim.lsp.util.convert_input_to_markdown_lines"] = true,
	--       ["vim.lsp.util.stylize_markdown"] = true,
	--       ["cmp.entry.get_documentation"] = true,
	--     },
	--   },
	--   -- you can enable a preset for easier configuration
	--   presets = {
	--     bottom_search = true, -- use a classic bottom cmdline for search
	--     command_palette = true, -- position the cmdline and popupmenu together
	--     long_message_to_split = true, -- long messages will be sent to a split
	--     inc_rename = false, -- enables an input dialog for inc-rename.nvim
	--     lsp_doc_border = false, -- add a border to hover docs and signature help
	--   },	})
	-- 	end,
	-- 	dependencies = {
	-- 		-- if you lazy-load any plugin below, make sure to add proper `module="..."` entries
	-- 		"MunifTanjim/nui.nvim",
	-- 		-- OPTIONAL:
	-- 		--   `nvim-notify` is only needed, if you want to use the notification view.
	-- 		--   If not available, we use `mini` as the fallback
	-- 		"rcarriga/nvim-notify",
	-- 	}
	-- },

	-- {
	-- 	"utilyre/barbecue.nvim",
	-- 	event = "VeryLazy",
	-- 	enable = false,
	-- 	dependencies = {
	-- 		"neovim/nvim-lspconfig",
	-- 		"SmiteshP/nvim-navic",
	-- 		-- "nvim-tree/nvim-web-devicons",
	-- 	},
	-- 	config = true,
	-- },
}