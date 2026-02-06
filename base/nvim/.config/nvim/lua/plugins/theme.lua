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
		dashboard.button("f", "󰈞  Find file", ":Telescope find_files<CR>"),
		dashboard.button("e", "  New file", ":ene <BAR> startinsert<CR>"),
		dashboard.button("P", "  Find project", ":Telescope project<CR>"),
		dashboard.button("p", "  Recent project", ":Telescope projects<CR>"),
		dashboard.button("r", "󰄉  Recently used files", ":Telescope oldfiles<CR>"),
		dashboard.button("t", "󰊄  Find text", ":Telescope live_grep<CR>"),
		dashboard.button("c", "  Configuration", ":e ~/.config/nvim/init.lua<CR>"),
		dashboard.button("z", "🛠️ Plugins", "<cmd>Lazy<CR>"),
		dashboard.button("q", "󰅚  Quit Neovim", ":qa<CR>"),
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
		-- enable = true,
		extra_groups = { -- table/string: additional groups that should be clear
			-- In particular, when you set it to 'all', that means all avaliable groups

			-- Inactive/non-current window backgrounds
			"NormalNC",
			"NormalFloat",
			"FloatBorder",
			"WinBar",
			"WinBarNC",
			"WinSeparator",

			-- example of akinsho/nvim-bufferline.lua
			"BufferLineTabClose",
			"BufferlineBufferSelected",
			"BufferLineFill",
			"BufferLineBackground",
			"BufferLineSeparator",
			"BufferLineIndicatorSelected",

			-- Sidebar/tree backgrounds
			"NvimTreeNormal",
			"NvimTreeNormalNC",
			"NeoTreeNormal",
			"NeoTreeNormalNC",

			-- Telescope
			"TelescopeNormal",
			"TelescopeBorder",
		},
		exclude_groups = {},
	})

	local status_ok, notify = pcall(require, "notify")
	if status_ok then
		notify.setup({
			background_colour = "#000000",
			stages = "fade_in_slide_out",
		})
		vim.notify = notify
	end
end

return {
	"rcarriga/nvim-notify",
	-- transparent background
	{
		"xiyaowong/nvim-transparent",
		dependencies = { "rcarriga/nvim-notify" },
		config = transparentconf,
	},
	-- Dim inactive windows (toggleable with <leader>vd)
	{
		"levouh/tint.nvim",
		event = "VeryLazy",
		config = function()
			require("tint").setup({
				tint = -30, -- Darken inactive windows (negative = darker)
				saturation = 0.6, -- Reduce saturation slightly
				tint_background_colors = false, -- Keep transparent backgrounds
				highlight_ignore_patterns = {
					"WinSeparator",
					"Status.*",
					"EndOfBuffer",
				},
			})
			-- Start with tint disabled
			require("tint").disable()
		end,
		keys = {
			{
				"<leader>vd",
				function()
					require("tint").toggle()
					-- Toggle cursorline highlight to make active window clearer
					local tint = require("tint")
					if tint.enabled() then
						vim.opt.cursorline = true
						vim.api.nvim_set_hl(0, "CursorLine", { bg = "#3a3a3a" })
					else
						-- Restore default cursorline (let colorscheme handle it)
						vim.opt.cursorline = false
						vim.cmd("hi clear CursorLine")
					end
				end,
				desc = "dim inactive windows",
			},
		},
	},
	-- UI improvements
	{
		"stevearc/dressing.nvim",
		event = "BufReadPre",
		opts = {
			input = { relative = "editor" },
			select = {
				backend = { "telescope", "fzf", "builtin" },
			},
		},
		disable = false,
	},
}
