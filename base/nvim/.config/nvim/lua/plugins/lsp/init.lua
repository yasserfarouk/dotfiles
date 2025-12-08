return {
	-- LSP configuration and management
	{
		"neovim/nvim-lspconfig",
		event = "BufReadPre",
		dependencies = {
			{
				"folke/lazydev.nvim",
				opts = {
					library = { plugins = { "neotest", "nvim-dap-ui" }, types = true },
				},
			},
			{ "j-hui/fidget.nvim", config = true },
			"williamboman/mason.nvim",
			"williamboman/mason-lspconfig.nvim",
			"hrsh7th/cmp-nvim-lsp",
			"hrsh7th/cmp-nvim-lsp-signature-help",
		},
		opts = {
			servers = {
				-- Python LSP - most important
				pyright = {
					settings = {
						pyright = {
							disableOrganizeImports = true, -- Using Ruff
						},
					},
				},
				-- JavaScript/TypeScript LSP
				ts_ls = {},
				-- Other servers
				texlab = {},
				dockerls = {},
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
			ensure_installed = {
				-- "stylua",
				-- "ruff",
				"debugpy",
				"codelldb",
			},
		},
		config = function(_, opts)
			require("mason").setup()
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
		cmd = { "TroubleToggle", "Trouble" },
		opts = { use_diagnostic_signs = true },
		keys = {
			{ "<leader>id", "<cmd>TroubleToggle document_diagnostics<cr>", desc = "Document Diagnostics" },
			{ "<leader>ii", "<cmd>LspInfo<cr>", desc = "LSP Info" },
			{ "<leader>il", "<cmd>Trouble loclist<cr>", desc = "Location List" },
			{ "<leader>iq", "<cmd>Trouble quickfix<cr>", desc = "Quick Fix" },
		},
	},
	-- { "ray-x/lsp_signature.nvim", event = "VeryLazy" },
	-- symbol preview
	{
		"hedyhli/outline.nvim",

		keys = {
			{ "<leader>vv", "<cmd>Outline<cr>", desc = "Symbol Sidebar" },
			{ "<leader>co", "<cmd>Outline<cr>", desc = "Symbols sidebar" },
		},
		config = function()
			require("outline").setup({
				-- Your setup opts here (leave empty to use defaults)
			})
		end,
	},
}
