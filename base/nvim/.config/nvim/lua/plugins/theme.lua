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

			-- example of akinsho/nvim-bufferline.lua
			"BufferLineTabClose",
			"BufferlineBufferSelected",
			"BufferLineFill",
			"BufferLineBackground",
			"BufferLineSeparator",
			"BufferLineIndicatorSelected",
		},
		exclude_groups = {}, -- table: groups you don't want to clear
	})

	local status_ok, notify = pcall(require, "notify")
	if status_ok then
		notify.setup({
			background_colour = "#000000",
		})
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
	--

	-- Color
	"christianchiarulli/nvcode-color-schemes.vim",

	-- Icons
	"nvim-tree/nvim-web-devicons",
	{
		"lukas-reineke/headlines.nvim",
		dependencies = "nvim-treesitter/nvim-treesitter",
		config = function()
			require("headlines").setup({
				quarto = {
					query = vim.treesitter.query.parse(
						"markdown",
						[[
                (fenced_code_block) @codeblock
            ]]
					),
					codeblock_highlight = "CodeBlock",
					treesitter_language = "markdown",
				},
			})
		end,
	},
}
