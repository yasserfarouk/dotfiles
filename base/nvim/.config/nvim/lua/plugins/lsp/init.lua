return {
	{
		"neovim/nvim-lspconfig",
		event = "BufReadPre",
		dependencies = {
			{ "folke/neoconf.nvim", cmd = "Neoconf", config = true },
			{ "folke/lazydev.nvim", ft = "lua", opts = {} },
			{ "j-hui/fidget.nvim", config = true },
			"williamboman/mason.nvim",
			"williamboman/mason-lspconfig.nvim",
			"hrsh7th/cmp-nvim-lsp",
		},
		opts = {
			servers = {
				pyright = {},
				lua_ls = {},
				jdtls = {},
				ts_ls = {},
				texlab = {},
				marksman = {},
			},
		},
		config = function(plugin, opts)
			require("plugins.lsp.servers").setup(plugin, opts)
		end,
	},
	{
		"williamboman/mason.nvim",
		cmd = "Mason",
		keys = { { "<leader>cm", "<cmd>Mason<cr>", desc = "Mason" } },
		opts = {
			ui = { border = "rounded" },
			ensure_installed = { "debugpy", "codelldb" },
		},
		config = function(_, opts)
			require("mason").setup(opts)
			local mr = require("mason-registry")
			for _, tool in ipairs(opts.ensure_installed) do
				local p = mr.get_package(tool)
				if not p:is_installed() then
					p:install()
				end
			end
		end,
	},
	{
		"folke/trouble.nvim",
		cmd = { "Trouble" },
		opts = {},
		keys = {
			{ "<leader>id", "<cmd>Trouble diagnostics toggle filter.buf=0<cr>", desc = "Document Diagnostics" },
			{ "<leader>ii", "<cmd>LspInfo<cr>", desc = "LSP Info" },
			{ "<leader>il", "<cmd>Trouble loclist toggle<cr>", desc = "Location List" },
			{ "<leader>iq", "<cmd>Trouble qflist toggle<cr>", desc = "Quick Fix" },
		},
	},
	{
		"glepnir/lspsaga.nvim",
		event = "LspAttach",
		opts = {
			ui = { border = "rounded", code_action = "💡" },
			symbol_in_winbar = { enable = true },
			lightbulb = { enable = false, virtual_text = true },
		},
		keys = {
			{ "<leader>vl", "<cmd>Lspsaga outline<cr>", desc = "Outline" },
		},
	},
	{
		"hedyhli/outline.nvim",
		cmd = "Outline",
		opts = { outline_window = { border = "rounded" } },
		keys = {
			{ "<leader>vv", "<cmd>Outline<cr>", desc = "Symbol Sidebar" },
			{ "<leader>co", "<cmd>Outline<cr>", desc = "Symbols sidebar" },
		},
	},
}
