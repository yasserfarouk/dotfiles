return {
	{
		"neovim/nvim-lspconfig",
		event = "BufReadPre",
		dependencies = {
			{ "folke/neoconf.nvim", cmd = "Neoconf", config = true },
			{
				"folke/neodev.nvim",
				opts = {
					library = { plugins = { "neotest", "nvim-dap-ui" }, types = true },
				},
			},
			{ "j-hui/fidget.nvim", config = true },
			-- { "smjonas/inc-rename.nvim", config = true },
			"williamboman/mason.nvim",
			"williamboman/mason-lspconfig.nvim",
			"hrsh7th/cmp-nvim-lsp",
			"hrsh7th/cmp-nvim-lsp-signature-help",
		},
		opts = {
			servers = {
				texlab = {
					settings = {
						formatterLineLength = 0,
					},
				},
				dockerls = {},
				-- https://github.com/microsoft/pyright/discussions/5852#discussioncomment-6874502
				pyright = {
					settings = {
						pyright = {
							disableOrganizeImports = true, -- Using Ruff
						},
						-- python = {
						-- 	analysis = {
						-- 		ignore = { "*" }, -- Using Ruff
						-- 		typeCheckingMode = "off", -- Using mypy
						-- 	},
						-- },
					},
					-- capabilities = {
					-- 	textDocument = {
					-- 		publishDiagnostics = {
					-- 			tagSupport = {
					-- 				valueSet = { 2 },
					-- 			},
					-- 		},
					-- 		ruff = {},
					-- 	},
					-- },
				},
			},
			setup = {
				sumneko_lua = function(_, _)
					local lsp_utils = require("plugins.lsp.utils")
					lsp_utils.on_attach(function(client, buffer)
						-- stylua: ignore
						if client.name == "sumneko_lua" then
							vim.keymap.set("n", "<leader>dX", function() require("osv").run_this() end,
								{ buffer = buffer, desc = "OSV Run" })
							vim.keymap.set("n", "<leader>dL", function() require("osv").launch({ port = 8086 }) end,
								{ buffer = buffer, desc = "OSV Launch" })
						end
					end)
				end,
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
	-- {
	-- 	"jay-babu/mason-null-ls.nvim",
	-- 	event = { "BufReadPre", "BufNewFile" },
	-- 	dependencies = {
	-- 		"williamboman/mason.nvim",
	-- 		"nvimtools/none-ls.nvim",
	-- 	},
	-- 	config = function()
	-- 		local nls = require("null-ls")
	-- 		-- {
	-- 		-- 				sources = {
	-- 		-- 					nls.builtins.formatting.stylua,
	-- 		-- 					-- nls.builtins.diagnostics.ruff.with({ extra_args = { "--max-line-length=180" } }),
	-- 		-- 					nls.builtins.formatting.isort,
	-- 		-- 					nls.builtins.formatting.black,
	-- 		-- 					-- nls.builtins.diagnostics.pylint,
	-- 		-- 				},
	-- 		-- 			}
	-- 		nls.setup()
	-- 		require("mason").setup()
	-- 		require("mason-null-ls").setup({ handlers = {} })
	-- 	end,
	-- },
	-- {
	-- 	"nvimtools/none-ls.nvim",
	-- 	event = "BufReadPre",
	-- 	dependencies = { "mason.nvim" },
	-- 	config = function()
	-- 		local nls = require("null-ls")
	-- 		nls.setup({
	-- 			sources = {
	-- 				-- nls.builtins.formatting.stylua,
	-- 				-- nls.builtins.diagnostics.ruff.with({ extra_args = { "--max-line-length=180" } }),
	-- 				nls.builtins.formatting.isort,
	-- 				nls.builtins.formatting.black,
	-- 				-- nls.builtins.diagnostics.pylint,
	-- 			},
	-- 		})
	-- 	end,
	-- },
	{
		"folke/trouble.nvim",
		cmd = { "TroubleToggle", "Trouble" },
		opts = { use_diagnostic_signs = true },
		keys = {
			{ "<leader>id", "<cmd>TroubleToggle document_diagnostics<cr>", desc = "Document Diagnostics" },
			{ "<leader>ii", "<cmd>TroubleToggle workspace_diagnostics<cr>", desc = "Workspace Diagnostics" },
			{ "<leader>ii", "<cmd>Trouble<cr>", desc = "Show" },
			{ "<leader>il", "<cmd>Trouble loclist<cr>", desc = "Location List" },
			{ "<leader>iq", "<cmd>Trouble quickfix<cr>", desc = "Quick Fix" },
		},
	},
	{
		"glepnir/lspsaga.nvim",
		dependencies = { "neovim/nvim-lspconfig" },
		event = "VeryLazy",
		opts = {
			symbol_in_winbar = {
				enable = true,
			},
			ui = {
				code_action = "💡",
			},
			lightbulb = {
				enable = false,
				sign = false,
				debounce = 10,
				sign_priority = 0,
				virtual_text = true,
				enable_in_insert = false,
			},
		},
		-- config = true,
		keys = {
			{ "<leader>vl", "<cmd>Lspsaga outline<cr>", desc = "Lspsaga Sidebar" },
			{ "<leader>vW", "<cmd>lua vim.opt.winbar = ''<cr>", desc = "Winbar ON" },
			{
				"<leader>vw",
				"<cmd>lua vim.opt.winbar = require('lspsaga.symbol.winbar'):get_bar()<cr>",
				desc = "Winbar ON",
			},
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
			-- Example mapping to toggle outline
			--
			require("outline").setup({
				-- Your setup opts here (leave empty to use defaults)
			})
		end,
	},
	{
		"folke/neodev.nvim",
		opts = {
			library = { plugins = { "neotest", "nvim-dap-ui" }, types = true },
		},
		event = "VeryLazy",
	},
}
