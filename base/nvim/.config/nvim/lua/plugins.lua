-- Consolidated plugins configuration
-- All plugins in a single file for better maintainability

return {
	-- ============================================================================
	-- COLORSCHEME
	-- ============================================================================
	{ "folke/tokyonight.nvim", lazy = false, priority = 1000 },

	-- ============================================================================
	-- LSP & COMPLETION
	-- ============================================================================
	{
		"neovim/nvim-lspconfig",
		event = "BufReadPre",
		dependencies = {
			{ "folke/neoconf.nvim", cmd = "Neoconf", config = true },
			{ "folke/lazydev.nvim", ft = "lua", opts = {} },
			{ "j-hui/fidget.nvim", opts = {} },
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
		config = function(_, opts)
			local lsp_utils = require("plugins.lsp.utils")
			local icons = require("yasser.icons")

			-- Setup keymaps on LSP attach
			lsp_utils.on_attach(function(client, buffer)
				require("plugins.lsp.keymaps").on_attach(client, buffer)
			end)

			-- Configure diagnostics
			vim.diagnostic.config({
				signs = {
					text = {
						[vim.diagnostic.severity.ERROR] = icons.diagnostics.Error,
						[vim.diagnostic.severity.WARN] = icons.diagnostics.Warning,
						[vim.diagnostic.severity.HINT] = icons.diagnostics.Hint,
						[vim.diagnostic.severity.INFO] = icons.diagnostics.Info,
					},
				},
				virtual_text = { prefix = "●", severity = { min = vim.diagnostic.severity.WARNING } },
				underline = true,
				update_in_insert = false,
				severity_sort = true,
				float = { focusable = true, style = "minimal", border = "rounded", source = "always" },
			})

			-- Get capabilities and setup servers
			local capabilities = lsp_utils.capabilities()
			require("mason-lspconfig").setup({
				ensure_installed = vim.tbl_keys(opts.servers),
				automatic_enable = false,
			})

			for server_name, server_config in pairs(opts.servers) do
				local config = vim.tbl_deep_extend("force", { capabilities = capabilities }, server_config)
				vim.lsp.config(server_name, config)
				vim.lsp.enable(server_name)
			end
		end,
	},

	{
		"williamboman/mason.nvim",
		cmd = "Mason",
		keys = { { "<leader>cm", "<cmd>Mason<cr>", desc = "Mason" } },
		opts = { ui = { border = "rounded" }, ensure_installed = { "debugpy", "codelldb" } },
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
		"stevearc/conform.nvim",
		event = "BufWritePre",
		keys = {
			{
				"<leader>cf",
				function()
					require("conform").format({ timeout_ms = 3000 })
				end,
				desc = "Format",
			},
		},
		opts = {
			formatters_by_ft = {
				lua = { "stylua" },
				python = { "black", "isort" },
				javascript = { "prettier" },
				typescript = { "prettier" },
				json = { "prettier" },
				markdown = { "prettier" },
			},
		},
	},

	{
		"hrsh7th/nvim-cmp",
		event = "InsertEnter",
		dependencies = {
			"hrsh7th/cmp-nvim-lsp",
			"hrsh7th/cmp-buffer",
			"hrsh7th/cmp-path",
			"hrsh7th/cmp-cmdline",
		},
		config = function()
			local cmp = require("cmp")
			local kind_icons = {
				Text = "󰉿",
				Method = "󰡱",
				Function = "󰊕",
				Constructor = "",
				Field = "",
				Variable = "󰆧",
				Class = "󰌗",
				Interface = "",
				Module = "",
				Property = "",
				Unit = "",
				Value = "󰬺",
				Enum = "",
				Keyword = "󰌋",
				Snippet = "",
				Color = "󰸌",
				File = "󰈙",
				Reference = "",
				Folder = "󰉋",
				EnumMember = "",
				Constant = "󰇽",
				Struct = "",
				Event = "",
				Operator = "󰆕",
				TypeParameter = "󰴑",
			}

			cmp.setup({
				window = {
					completion = cmp.config.window.bordered({ border = "rounded" }),
					documentation = cmp.config.window.bordered({ border = "rounded" }),
				},
				sources = cmp.config.sources({
					{ name = "lazydev", group_index = 0 },
					{ name = "nvim_lsp" },
				}, {
					{ name = "buffer", keyword_length = 3 },
					{ name = "path" },
				}),
				formatting = {
					fields = { "kind", "abbr", "menu" },
					format = function(entry, vim_item)
						vim_item.kind = string.format("%s", kind_icons[vim_item.kind] or "")
						vim_item.menu = ({
							buffer = "",
							nvim_lsp = "",
							nvim_lua = "",
							path = "󰇘",
							lazydev = "",
						})[entry.source.name]
						return vim_item
					end,
				},
				mapping = cmp.mapping.preset.insert({
					["<C-p>"] = cmp.mapping.select_prev_item(),
					["<C-n>"] = cmp.mapping.select_next_item(),
					["<C-b>"] = cmp.mapping.scroll_docs(-4),
					["<C-f>"] = cmp.mapping.scroll_docs(4),
					["<C-Space>"] = cmp.mapping.complete(),
					["<C-e>"] = cmp.mapping.abort(),
					["<CR>"] = cmp.mapping.confirm({ behavior = cmp.ConfirmBehavior.Replace, select = false }),
					["<Tab>"] = cmp.mapping(function(fallback)
						if cmp.visible() then
							cmp.select_next_item()
						else
							fallback()
						end
					end, { "i", "s" }),
					["<S-Tab>"] = cmp.mapping(function(fallback)
						if cmp.visible() then
							cmp.select_prev_item()
						else
							fallback()
						end
					end, { "i", "s" }),
				}),
				completion = { completeopt = "menu,menuone,noinsert" },
				experimental = { ghost_text = true },
			})

			-- Cmdline completion
			cmp.setup.cmdline("/", {
				mapping = cmp.mapping.preset.cmdline(),
				sources = { { name = "buffer" } },
			})
			cmp.setup.cmdline(":", {
				mapping = cmp.mapping.preset.cmdline(),
				sources = cmp.config.sources({ { name = "path" } }, { { name = "cmdline" } }),
			})
		end,
	},

	{
		"folke/trouble.nvim",
		cmd = "Trouble",
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
		keys = { { "<leader>vl", "<cmd>Lspsaga outline<cr>", desc = "Outline" } },
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

	-- ============================================================================
	-- TREESITTER
	-- ============================================================================
	{
		"nvim-treesitter/nvim-treesitter",
		build = ":TSUpdate",
		event = "BufReadPost",
		opts = {
			ensure_installed = { "python", "lua", "java", "javascript", "php", "latex", "markdown" },
			highlight = { enable = true },
			indent = { enable = true, disable = { "python" } },
			autotag = { enable = true },
		},
	},

	{
		"nvim-treesitter/nvim-treesitter-textobjects",
		event = "BufReadPost",
		dependencies = "nvim-treesitter/nvim-treesitter",
		opts = {
			textobjects = {
				select = {
					enable = true,
					lookahead = true,
					keymaps = {
						["af"] = "@function.outer",
						["if"] = "@function.inner",
						["ac"] = "@class.outer",
						["ic"] = "@class.inner",
						["ab"] = "@block.outer",
						["ib"] = "@block.inner",
						["aa"] = "@parameter.outer",
						["ia"] = "@parameter.inner",
					},
				},
				move = {
					enable = true,
					set_jumps = true,
					goto_next_start = { ["]m"] = "@function.outer", ["]]"] = "@class.outer" },
					goto_next_end = { ["]M"] = "@function.outer", ["]["] = "@class.outer" },
					goto_previous_start = { ["[m"] = "@function.outer", ["[["] = "@class.outer" },
					goto_previous_end = { ["[M"] = "@function.outer", ["[]"] = "@class.outer" },
				},
			},
		},
		config = function(_, opts)
			require("nvim-treesitter.configs").setup(opts)
		end,
	},

	{ "windwp/nvim-ts-autotag", ft = { "html", "xml", "javascript", "typescript", "javascriptreact", "typescriptreact" } },
	{ "JoosepAlviste/nvim-ts-context-commentstring", event = "BufReadPost" },

	-- ============================================================================
	-- FUZZY FINDER (FZF-LUA - Modern, Fast)
	-- ============================================================================
	{
		"ibhagwan/fzf-lua",
		cmd = "FzfLua",
		dependencies = { "echasnovski/mini.icons" },
		keys = {
			-- Main search keymaps
			{ "<leader>/", "<cmd>FzfLua grep_curbuf<cr>", desc = "Buffer fuzzy find" },
			{ "<leader>f", "<cmd>FzfLua files<cr>", desc = "Find files" },
			{ "<leader>;", "<cmd>FzfLua files<cr>", desc = "Find files" },

			-- Search commands
			{ "<leader>s.", "<cmd>FzfLua files cwd=~/.config/nvim<cr>", desc = "Vim config files" },
			{ "<leader>sa", "<cmd>FzfLua files<cr>", desc = "Find files" },
			{ "<leader>sB", "<cmd>FzfLua git_branches<cr>", desc = "Git branches" },
			{ "<leader>sc", "<cmd>FzfLua colorschemes<cr>", desc = "Colorschemes" },
			{ "<leader>SC", "<cmd>FzfLua commands<cr>", desc = "Commands" },
			{ "<leader>sd", "<cmd>FzfLua diagnostics_document<cr>", desc = "Document diagnostics" },
			{ "<leader>sD", "<cmd>FzfLua diagnostics_workspace<cr>", desc = "Workspace diagnostics" },
			{ "<leader>sf", "<cmd>FzfLua files<cr>", desc = "Files" },
			{ "<leader>sg", "<cmd>FzfLua grep_curbuf<cr>", desc = "Buffer fuzzy find" },
			{ "<leader>sh", "<cmd>FzfLua git_bcommits<cr>", desc = "File history" },
			{ "<leader>sH", "<cmd>FzfLua help_tags<cr>", desc = "Help" },
			{ "<leader>sm", "<cmd>FzfLua marks<cr>", desc = "Marks" },
			{ "<leader>sM", "<cmd>FzfLua man_pages<cr>", desc = "Man pages" },
			{ "<leader>so", "<cmd>FzfLua vim_options<cr>", desc = "Vim options" },
			{ "<leader>sp", "<cmd>FzfLua oldfiles<cr>", desc = "Recent files" },
			{ "<leader>sr", "<cmd>FzfLua registers<cr>", desc = "Registers" },
			{ "<leader>ss", "<cmd>FzfLua lsp_document_symbols<cr>", desc = "Document symbols" },
			{ "<leader>st", "<cmd>FzfLua live_grep<cr>", desc = "Live grep" },
			{ "<leader>sw", "<cmd>FzfLua grep_cword<cr>", desc = "Word under cursor" },
			{ "<leader>s*", "<cmd>FzfLua grep_cword<cr>", desc = "Word under cursor" },
			{ "<leader>s;", "<cmd>FzfLua filetypes<cr>", desc = "Filetypes" },
			{ "<leader>s/", "<cmd>FzfLua command_history<cr>", desc = "Command history" },

			-- Buffer management
			{ "<leader>bb", "<cmd>FzfLua buffers<cr>", desc = "Buffers" },

			-- LSP
			{ "<leader>cd", "<cmd>FzfLua diagnostics_document<cr>", desc = "Document diagnostics" },
			{ "<leader>cD", "<cmd>FzfLua diagnostics_workspace<cr>", desc = "Workspace diagnostics" },
			{ "<leader>cq", "<cmd>FzfLua quickfix<cr>", desc = "Quickfix" },
			{ "<leader>cs", "<cmd>FzfLua lsp_document_symbols<cr>", desc = "Document symbols" },
			{ "<leader>cw", "<cmd>FzfLua lsp_workspace_symbols<cr>", desc = "Workspace symbols" },
		},
		opts = {
			winopts = {
				border = "rounded",
				preview = { default = "bat" },
			},
			fzf_opts = { ["--layout"] = "reverse" },
		},
	},

	-- ============================================================================
	-- SEARCH & REPLACE
	-- ============================================================================
	{
		"MagicDuck/grug-far.nvim",
		cmd = "GrugFar",
		keys = {
			{ "<leader>sr", "<cmd>GrugFar<cr>", desc = "Search & Replace" },
		},
		opts = {},
	},

	-- ============================================================================
	-- GIT
	-- ============================================================================
	{
		"lewis6991/gitsigns.nvim",
		event = "BufReadPre",
		opts = {},
		keys = {
			{ "<leader>gh", "<cmd>Gitsigns preview_hunk<cr>", desc = "Preview hunk" },
			{ "<leader>gB", "<cmd>Gitsigns toggle_current_line_blame<cr>", desc = "Line blame" },
		},
	},

	{
		"tpope/vim-fugitive",
		cmd = { "Git", "G", "Gdiffsplit", "Gread", "Gwrite", "Ggrep", "GMove", "GDelete", "GBrowse" },
		keys = {
			{ "<leader>ga", "<cmd>Git add .<cr>", desc = "Add all" },
			{ "<leader>gA", "<cmd>Git add %<cr>", desc = "Add current" },
			{ "<leader>gb", "<cmd>Git blame<cr>", desc = "Blame" },
			{ "<leader>gc", "<cmd>Git commit<cr>", desc = "Commit" },
			{ "<leader>gd", "<cmd>Git diff<cr>", desc = "Diff" },
			{ "<leader>gg", "<cmd>Git<cr>", desc = "Status" },
			{ "<leader>gl", "<cmd>Git log<cr>", desc = "Log" },
			{ "<leader>gp", "<cmd>Git push<cr>", desc = "Push" },
			{ "<leader>gP", "<cmd>Git pull<cr>", desc = "Pull" },
			{ "<leader>gD", "<cmd>Gdiffsplit<cr>", desc = "Diff split" },
		},
	},

	{ "tpope/vim-rhubarb", dependencies = "tpope/vim-fugitive" },

	{
		"sindrets/diffview.nvim",
		cmd = "DiffviewOpen",
		keys = { { "<leader>gV", "<cmd>DiffviewOpen<cr>", desc = "Diff view" } },
	},

	{
		"akinsho/git-conflict.nvim",
		event = "BufReadPre",
		opts = { default_mappings = false, disable_diagnostics = true },
		keys = {
			{ "<leader>gCo", "<cmd>GitConflictChooseOurs<cr>", desc = "Choose ours" },
			{ "<leader>gCt", "<cmd>GitConflictChooseTheirs<cr>", desc = "Choose theirs" },
			{ "<leader>gCb", "<cmd>GitConflictChooseBoth<cr>", desc = "Choose both" },
			{ "<leader>gC0", "<cmd>GitConflictChooseNone<cr>", desc = "Choose none" },
			{ "]x", "<cmd>GitConflictNextConflict<cr>", desc = "Next conflict" },
			{ "[x", "<cmd>GitConflictPrevConflict<cr>", desc = "Prev conflict" },
		},
	},

	-- ============================================================================
	-- EDITING
	-- ============================================================================
	{
		"echasnovski/mini.pairs",
		event = "InsertEnter",
		opts = {},
	},

	{
		"terrortylor/nvim-comment",
		keys = {
			{ "gcc", mode = "n", desc = "Comment toggle current line" },
			{ "gc", mode = { "n", "o" }, desc = "Comment toggle linewise" },
			{ "gc", mode = "x", desc = "Comment toggle linewise (visual)" },
			{ "gbc", mode = "n", desc = "Comment toggle current block" },
			{ "gb", mode = { "n", "o" }, desc = "Comment toggle blockwise" },
			{ "gb", mode = "x", desc = "Comment toggle blockwise (visual)" },
		},
		config = function()
			require("nvim_comment").setup()
		end,
	},

	{ "tpope/vim-surround", event = "BufReadPost" },
	{ "tpope/vim-repeat", event = "BufReadPost" },
	{ "tpope/vim-abolish", event = "BufReadPost" },

	{
		"abecodes/tabout.nvim",
		event = "InsertEnter",
		dependencies = { "nvim-treesitter/nvim-treesitter" },
		opts = {},
	},

	-- ============================================================================
	-- NAVIGATION
	-- ============================================================================
	{ "wsdjeg/vim-fetch" },
	{ "tpope/vim-unimpaired", event = "BufReadPost" },
	{ "michaeljsmith/vim-indent-object", event = "BufReadPost" },
	{ "tmhedberg/indent-motion", event = "BufReadPost" },

	{
		"alexghergh/nvim-tmux-navigation",
		event = "VeryLazy",
		opts = {
			disable_when_zoomed = true,
			keybindings = {
				left = "<C-h>",
				down = "<C-j>",
				up = "<C-k>",
				right = "<C-l>",
				last_active = "<C-\\>",
				next = "<C-Space>",
			},
		},
	},

	{
		"mikavilpas/yazi.nvim",
		keys = { { "<leader>xf", "<cmd>Yazi<cr>", desc = "Yazi file manager" } },
		opts = { open_for_directories = false },
	},

	-- ============================================================================
	-- TERMINAL
	-- ============================================================================
	{
		"akinsho/toggleterm.nvim",
		version = "*",
		keys = {
			{ "<leader>xx", "<cmd>ToggleTerm direction=float<cr>", desc = "Terminal float" },
			{ "<leader>x-", "<cmd>ToggleTerm direction=horizontal size=15<cr>", desc = "Terminal bottom" },
			{ "<leader>x\\", "<cmd>ToggleTerm direction=vertical size=80<cr>", desc = "Terminal right" },
			{ "<leader>xg", "<cmd>lua _LAZYGIT_TOGGLE()<cr>", desc = "LazyGit" },
		},
		opts = {
			size = function(term)
				if term.direction == "horizontal" then
					return 15
				elseif term.direction == "vertical" then
					return vim.o.columns * 0.4
				end
			end,
			open_mapping = [[<c-\>]],
			shade_terminals = false,
			direction = "float",
			float_opts = { border = "rounded" },
		},
		config = function(_, opts)
			require("toggleterm").setup(opts)
			local Terminal = require("toggleterm.terminal").Terminal
			_G._LAZYGIT_TOGGLE = function()
				local lazygit = Terminal:new({ cmd = "lazygit", hidden = true, direction = "float" })
				lazygit:toggle()
			end
		end,
	},

	-- ============================================================================
	-- DEBUGGING
	-- ============================================================================
	{
		"mfussenegger/nvim-dap",
		dependencies = {
			"rcarriga/nvim-dap-ui",
			"theHamsta/nvim-dap-virtual-text",
			"nvim-neotest/nvim-nio",
		},
		keys = {
			{ "<leader>db", "<cmd>lua require'dap'.toggle_breakpoint()<cr>", desc = "Breakpoint" },
			{ "<leader>dc", "<cmd>lua require'dap'.continue()<cr>", desc = "Continue" },
			{ "<leader>di", "<cmd>lua require'dap'.step_into()<cr>", desc = "Step into" },
			{ "<leader>do", "<cmd>lua require'dap'.step_over()<cr>", desc = "Step over" },
			{ "<leader>dO", "<cmd>lua require'dap'.step_out()<cr>", desc = "Step out" },
			{ "<leader>dr", "<cmd>lua require'dap'.repl.toggle()<cr>", desc = "REPL" },
			{ "<leader>dl", "<cmd>lua require'dap'.run_last()<cr>", desc = "Run last" },
			{ "<leader>du", "<cmd>lua require'dapui'.toggle()<cr>", desc = "UI" },
			{ "<leader>dx", "<cmd>lua require'dap'.terminate()<cr>", desc = "Terminate" },
		},
		config = function()
			local dap = require("dap")
			local dapui = require("dapui")

			dapui.setup()
			require("nvim-dap-virtual-text").setup()

			-- Auto open/close UI
			dap.listeners.after.event_initialized["dapui_config"] = function()
				dapui.open()
			end
			dap.listeners.before.event_terminated["dapui_config"] = function()
				dapui.close()
			end
			dap.listeners.before.event_exited["dapui_config"] = function()
				dapui.close()
			end
		end,
	},

	{
		"mfussenegger/nvim-dap-python",
		ft = "python",
		dependencies = "mfussenegger/nvim-dap",
		config = function()
			require("dap-python").setup("python")
		end,
	},

	-- ============================================================================
	-- TESTING
	-- ============================================================================
	{
		"nvim-neotest/neotest",
		dependencies = {
			"nvim-neotest/nvim-nio",
			"nvim-lua/plenary.nvim",
			"nvim-treesitter/nvim-treesitter",
			"nvim-neotest/neotest-python",
		},
		keys = {
			{ "<leader>tt", "<cmd>lua require('neotest').run.run()<cr>", desc = "Test nearest" },
			{ "<leader>tf", "<cmd>lua require('neotest').run.run(vim.fn.expand('%'))<cr>", desc = "Test file" },
			{ "<leader>ts", "<cmd>lua require('neotest').summary.toggle()<cr>", desc = "Test summary" },
			{ "<leader>to", "<cmd>lua require('neotest').output.open({ enter = true })<cr>", desc = "Test output" },
		},
		opts = function()
			return {
				adapters = {
					require("neotest-python")({
						dap = { justMyCode = false },
						runner = "pytest",
					}),
				},
			}
		end,
	},

	{
		"vim-test/vim-test",
		keys = {
			{ "<leader>tn", "<cmd>TestNearest<cr>", desc = "Test nearest" },
			{ "<leader>tF", "<cmd>TestFile<cr>", desc = "Test file" },
			{ "<leader>ts", "<cmd>TestSuite<cr>", desc = "Test suite" },
			{ "<leader>tl", "<cmd>TestLast<cr>", desc = "Test last" },
			{ "<leader>tv", "<cmd>TestVisit<cr>", desc = "Test visit" },
		},
	},

	-- ============================================================================
	-- LANGUAGE-SPECIFIC
	-- ============================================================================

	-- Python
	{
		"linux-cultist/venv-selector.nvim",
		ft = "python",
		dependencies = { "neovim/nvim-lspconfig" },
		branch = "regexp",
		opts = {},
		keys = { { "<leader>pv", "<cmd>VenvSelect<cr>", desc = "Select VirtualEnv" } },
	},

	-- LaTeX
	{
		"lervag/vimtex",
		ft = { "tex", "latex" },
		config = function()
			vim.g.vimtex_view_method = "skim"
			vim.g.vimtex_compiler_method = "latexmk"
		end,
	},

	-- Markdown
	{
		"MeanderingProgrammer/markdown.nvim",
		ft = "markdown",
		dependencies = { "nvim-treesitter/nvim-treesitter" },
		opts = {},
	},

	{
		"iamcco/markdown-preview.nvim",
		ft = "markdown",
		build = function()
			vim.fn["mkdp#util#install"]()
		end,
	},

	-- Obsidian
	{
		"epwalsh/obsidian.nvim",
		ft = "markdown",
		dependencies = { "nvim-lua/plenary.nvim" },
		opts = {
			workspaces = {
				{ name = "personal", path = "~/Documents/obsidian/personal" },
			},
		},
	},

	-- SQL
	{
		"nanotee/sqls.nvim",
		ft = "sql",
	},

	-- Table mode
	{
		"dhruvasagar/vim-table-mode",
		ft = { "markdown", "org", "text" },
		keys = {
			{ "<leader>tm", "<cmd>TableModeToggle<cr>", desc = "Table mode" },
		},
	},

	-- ============================================================================
	-- UI ENHANCEMENTS
	-- ============================================================================
	{
		"folke/snacks.nvim",
		priority = 1000,
		lazy = false,
		opts = {
			bigfile = { enabled = true },
			dashboard = { enabled = true },
			indent = { enabled = true },
			input = { enabled = true },
			notifier = { enabled = true },
			quickfile = { enabled = true },
			scroll = { enabled = false },
			statuscolumn = { enabled = true },
			words = { enabled = true },
		},
	},

	{
		"echasnovski/mini.icons",
		opts = {},
		init = function()
			package.preload["nvim-web-devicons"] = function()
				require("mini.icons").mock_nvim_web_devicons()
				return package.loaded["nvim-web-devicons"]
			end
		end,
	},

	{
		"folke/which-key.nvim",
		event = "VeryLazy",
		opts = {},
	},

	{
		"NvChad/nvim-colorizer.lua",
		event = "BufReadPre",
		opts = {
			user_default_options = {
				names = false,
				rgb_fn = true,
				hsl_fn = true,
			},
		},
	},

	{
		"folke/todo-comments.nvim",
		event = "BufReadPost",
		dependencies = { "nvim-lua/plenary.nvim" },
		opts = {},
	},

	-- Notifications
	{
		"rcarriga/nvim-notify",
		keys = {
			{
				"<leader>un",
				function()
					require("notify").dismiss({ silent = true, pending = true })
				end,
				desc = "Dismiss notifications",
			},
		},
		opts = {
			timeout = 3000,
			max_height = function()
				return math.floor(vim.o.lines * 0.75)
			end,
			max_width = function()
				return math.floor(vim.o.columns * 0.75)
			end,
		},
	},

	-- ============================================================================
	-- UTILITIES
	-- ============================================================================
	{ "nvim-lua/plenary.nvim", lazy = true },

	{
		"tpope/vim-eunuch",
		cmd = { "Delete", "Unlink", "Move", "Rename", "Chmod", "Mkdir", "SudoWrite", "SudoEdit" },
	},

	{
		"mbbill/undotree",
		cmd = "UndotreeToggle",
		keys = { { "<leader>u", "<cmd>UndotreeToggle<cr>", desc = "Undo tree" } },
	},

	{
		"stevearc/dressing.nvim",
		event = "VeryLazy",
		opts = {},
	},

	{
		"chrishrb/gx.nvim",
		keys = { { "gx", "<cmd>Browse<cr>", mode = { "n", "x" } } },
		cmd = { "Browse" },
		dependencies = { "nvim-lua/plenary.nvim" },
		opts = {},
	},

	{
		"mrjones2014/legendary.nvim",
		priority = 10000,
		lazy = false,
		dependencies = { "folke/which-key.nvim" },
		opts = {
			extensions = { which_key = { auto_register = true } },
		},
	},

	{
		"danymat/neogen",
		keys = {
			{ "<leader>nf", "<cmd>Neogen func<cr>", desc = "Function annotation" },
			{ "<leader>nc", "<cmd>Neogen class<cr>", desc = "Class annotation" },
		},
		opts = { snippet_engine = "nvim" },
	},

	{
		"ThePrimeagen/refactoring.nvim",
		dependencies = {
			"nvim-lua/plenary.nvim",
			"nvim-treesitter/nvim-treesitter",
		},
		keys = {
			{
				"<leader>re",
				function()
					require("refactoring").refactor("Extract Function")
				end,
				mode = "v",
				desc = "Extract function",
			},
			{
				"<leader>rf",
				function()
					require("refactoring").refactor("Extract Function To File")
				end,
				mode = "v",
				desc = "Extract function to file",
			},
			{
				"<leader>rv",
				function()
					require("refactoring").refactor("Extract Variable")
				end,
				mode = "v",
				desc = "Extract variable",
			},
			{
				"<leader>ri",
				function()
					require("refactoring").refactor("Inline Variable")
				end,
				mode = { "n", "v" },
				desc = "Inline variable",
			},
		},
		opts = {},
	},

	{
		"xvzc/chezmoi.nvim",
		dependencies = { "nvim-lua/plenary.nvim" },
		config = function()
			require("chezmoi").setup({})
		end,
	},

	{
		"moll/vim-bbye",
		cmd = { "Bdelete", "Bwipeout" },
	},

	{
		"dhruvasagar/vim-zoom",
		keys = { { "<C-w>m", "<Plug>(zoom-toggle)", desc = "Zoom window" } },
	},

	-- Transparent background
	{
		"xiyaowong/transparent.nvim",
		lazy = false,
		opts = {},
	},
}
