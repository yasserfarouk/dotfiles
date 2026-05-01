return {
	-- LSP configuration and management
	{
		"neovim/nvim-lspconfig",
		event = "BufReadPre",
		dependencies = {
			{
				"folke/lazydev.nvim",
				ft = "lua",
				opts = {
					library = {
						{ plugins = { "neotest", "nvim-dap-ui" }, types = true },
						{ path = "luvit-meta/library", words = { "vim%.uv" } },
					},
				},
			},
			{ "j-hui/fidget.nvim", config = true },
			"williamboman/mason.nvim",
			"williamboman/mason-lspconfig.nvim",
			"b0o/schemastore.nvim", -- JSON/YAML schema catalog
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
				phpactor = {},
				-- Other servers
				texlab = {
					settings = {
						texlab = {
							build = {
								onSave = false,
							},
							chktex = {
								onOpenAndSave = true,
								onEdit = false,
							},
						},
					},
				},
				dockerls = {},
				-- YAML LSP (schema-aware via SchemaStore)
				yamlls = {
					settings = {
						yaml = {
							keyOrdering = false,
							format = { enable = false }, -- use prettier via conform
							validate = true,
							schemaStore = {
								-- disable built-in store; use schemastore.nvim instead
								enable = false,
								url = "",
							},
						},
					},
				},
				-- JSON LSP (schema-aware via SchemaStore)
				jsonls = {
					settings = {
						json = {
							format = { enable = false }, -- use prettier via conform
							validate = { enable = true },
						},
					},
				},
				-- Markdown LSP
				marksman = {},
			},
		},
		config = function(plugin, opts)
			-- Inject schemastore catalogs at config time (lazy-loaded)
			local ok, schemastore = pcall(require, "schemastore")
			if ok then
				if opts.servers.jsonls then
					opts.servers.jsonls.settings = opts.servers.jsonls.settings or {}
					opts.servers.jsonls.settings.json = opts.servers.jsonls.settings.json or {}
					opts.servers.jsonls.settings.json.schemas = schemastore.json.schemas()
				end
				if opts.servers.yamlls then
					opts.servers.yamlls.settings = opts.servers.yamlls.settings or {}
					opts.servers.yamlls.settings.yaml = opts.servers.yamlls.settings.yaml or {}
					opts.servers.yamlls.settings.yaml.schemas = schemastore.yaml.schemas()
				end
			end
			require("plugins.lsp.servers").setup(plugin, opts)
		end,
	},
	{
		"williamboman/mason.nvim",
		cmd = "Mason",
		keys = { { "<leader>cm", "<cmd>Mason<cr>", desc = "Mason" } },
		opts = {
			ensure_installed = {
				"stylua",      -- Lua formatter
				"ruff",        -- Python linter/formatter
				"prettierd",   -- JS/TS/YAML/JSON/Markdown formatter (fast)
				"prettier",    -- Fallback formatter
				"debugpy",
				"intelephense",
				"codelldb",
				-- YAML
				"yaml-language-server",
				"yamllint",
				-- JSON
				"json-lsp",
				"jsonlint",
				-- Markdown
				"marksman",
				"markdownlint-cli2",
				-- LaTeX
				"latexindent",
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
	-- Breadcrumbs/code navigation bar
	{
		"Bekaboo/dropbar.nvim",
		event = "BufReadPost",
		opts = {
			bar = {
				sources = function(buf, _)
					local sources = require("dropbar.sources")
					local utils = require("dropbar.utils")
					if vim.bo[buf].ft == "markdown" then
						return { sources.markdown }
					end
					if vim.bo[buf].buftype == "terminal" then
						return { sources.terminal }
					end
					return {
						sources.path,
						utils.source.fallback({
							sources.lsp,
							sources.treesitter,
						}),
					}
				end,
			},
		},
		keys = {
			{ "<leader>cb", function() require("dropbar.api").pick() end, desc = "Breadcrumb pick" },
		},
	},
}
