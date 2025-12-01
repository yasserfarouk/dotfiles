-- ╔════════════════════════════════════════════════════════════════════════════╗
-- ║                     NEOVIM PLUGINS CONFIGURATION                            ║
-- ║                   Organized into collapsible sections                       ║
-- ║                                                                             ║
-- ║  Folding: za=toggle fold, zM=close all, zR=open all, zc=close, zo=open    ║
-- ║  vim:foldmethod=marker:foldlevel=0                                         ║
-- ╚════════════════════════════════════════════════════════════════════════════╝

return {
	-- ══════════════════════════════════════════════════════════════════════════
	-- SECTION: UI & APPEARANCE {{{1
	-- ══════════════════════════════════════════════════════════════════════════
	
	-- Colorscheme
	{ "folke/tokyonight.nvim", lazy = false, priority = 1000 },

	-- }}}1
	-- ══════════════════════════════════════════════════════════════════════════
	-- SECTION: LSP & COMPLETION {{{1
	-- ══════════════════════════════════════════════════════════════════════════
	{
		"neovim/nvim-lspconfig",
		event = { "BufReadPre", "BufNewFile" },
		dependencies = {
			{ "folke/lazydev.nvim", ft = "lua", opts = { integrations = { cmp = false } } },
			{ "j-hui/fidget.nvim", opts = {} }, -- LSP progress indicator
			"williamboman/mason.nvim",
			"williamboman/mason-lspconfig.nvim",
			"saghen/blink.cmp",
		},
		config = function()
			local lspconfig = require("lspconfig")
			local icons = require("yasser.icons")

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

			-- Get blink.cmp capabilities
			local capabilities = require("blink.cmp").get_lsp_capabilities()

			-- Default server config
			local default_config = { capabilities = capabilities }

			-- Setup modern, stable LSP servers
			local servers = {
				"basedpyright", -- Modern Python (fork of pyright, better maintained)
				"lua_ls", -- Lua (modern, actively maintained)
				"jdtls", -- Java (still best option)
				"ts_ls", -- TypeScript/JavaScript (stable)
				"texlab", -- LaTeX (modern, best option)
				"marksman", -- Markdown (modern, fast)
				"intelephense", -- PHP (best PHP LSP)
				"bashls", -- Bash LSP
			}
			for _, server in ipairs(servers) do
				lspconfig[server].setup(default_config)
			end

			-- Mason auto-setup
			require("mason-lspconfig").setup({
				ensure_installed = servers,
				handlers = {
					function(server_name)
						lspconfig[server_name].setup(default_config)
					end,
				},
			})
		end,
	},

	{
		"williamboman/mason.nvim",
		cmd = "Mason",
		keys = { { "<leader>cm", "<cmd>Mason<cr>", desc = "Mason" } },
		opts = {
			ui = { border = "rounded" },
			ensure_installed = { "debugpy", "codelldb", "stylua", "black", "isort", "prettier" },
		},
		config = function(_, opts)
			require("mason").setup(opts)
			local mr = require("mason-registry")
			
			-- Auto-install tools
			for _, tool in ipairs(opts.ensure_installed) do
				local p = mr.get_package(tool)
				if not p:is_installed() then
					p:install()
				end
			end
			
			-- Auto-setup LSP servers installed via Mason
			mr:on("package:install:success", function(pkg)
				local server_name = pkg.name
				-- Map some package names to their LSP names
				local name_map = {
					["typescript-language-server"] = "ts_ls",
					["python-lsp-server"] = "pylsp",
					["basedpyright"] = "basedpyright",
				}
				server_name = name_map[server_name] or server_name
				
				-- Auto-setup if it's an LSP server
				if vim.tbl_contains(vim.tbl_keys(require("lspconfig.configs")), server_name) then
					vim.schedule(function()
						require("lspconfig")[server_name].setup({})
					end)
				end
			end)
		end,
	},

	-- }}}1
	-- ══════════════════════════════════════════════════════════════════════════
	-- SECTION: COMPLETION {{{1
	-- ══════════════════════════════════════════════════════════════════════════
	{
		"saghen/blink.cmp",
		version = "*",
		event = "InsertEnter",
		dependencies = {
			"rafamadriz/friendly-snippets",
			{
				"L3MON4D3/LuaSnip",
				version = "v2.*",
				build = "make install_jsregexp",
			},
		},
		opts = {
			keymap = {
				preset = "default",
				["<C-space>"] = { "show", "show_documentation", "hide_documentation" },
				["<C-e>"] = { "hide", "fallback" },
				["<CR>"] = { "accept", "fallback" },
				["<Tab>"] = { "snippet_forward", "select_next", "fallback" },
				["<S-Tab>"] = { "snippet_backward", "select_prev", "fallback" },
				["<C-p>"] = { "select_prev", "fallback" },
				["<C-n>"] = { "select_next", "fallback" },
				["<C-b>"] = { "scroll_documentation_up", "fallback" },
				["<C-f>"] = { "scroll_documentation_down", "fallback" },
			},
			appearance = {
				use_nvim_cmp_as_default = true,
				nerd_font_variant = "mono",
			},
			sources = {
				default = { "lsp", "path", "luasnip", "buffer" },
				providers = {
					lsp = {
						name = "LSP",
						module = "blink.cmp.sources.lsp",
					},
					path = {
						name = "Path",
						module = "blink.cmp.sources.path",
					},
					luasnip = {
						name = "Luasnip",
						module = "blink.cmp.sources.luasnip",
						score_offset = -3,
					},
					buffer = {
						name = "Buffer",
						module = "blink.cmp.sources.buffer",
						fallback_for = { "lsp" },
					},
				},
			},
			completion = {
				menu = {
					border = "rounded",
					draw = {
						columns = { { "kind_icon" }, { "label", "label_description", gap = 1 }, { "kind" } },
					},
				},
				documentation = {
					auto_show = true,
					auto_show_delay_ms = 200,
					window = { border = "rounded" },
				},
			},
			signature = {
				enabled = true,
				window = { border = "rounded" },
			},
		},
		opts_extend = { "sources.default" },
	},

	-- }}}1
	-- ══════════════════════════════════════════════════════════════════════════
	-- SECTION: AI ASSISTANCE (COPILOT) {{{1
	-- ══════════════════════════════════════════════════════════════════════════
	{
		"zbirenbaum/copilot.lua",
		cmd = "Copilot",
		event = "InsertEnter",
		opts = {
			suggestion = {
				enabled = true,
				auto_trigger = true,
				debounce = 75,
				keymap = {
					accept = "<M-CR>",
					accept_word = "<M-w>",
					accept_line = "<M-j>",
					next = "<M-]>",
					prev = "<M-[>",
					dismiss = "<C-]>",
				},
			},
			panel = { enabled = false },
			filetypes = {
				yaml = false,
				markdown = false,
				help = false,
				gitcommit = false,
				gitrebase = false,
				hgcommit = false,
				svn = false,
				cvs = false,
				["."] = false,
			},
		},
	},

	{
		"folke/trouble.nvim",
		cmd = "Trouble",
		keys = {
			{ "<leader>id", "<cmd>Trouble diagnostics toggle filter.buf=0<cr>", desc = "Document Diagnostics" },
			{ "<leader>ii", "<cmd>LspInfo<cr>", desc = "LSP Info" },
			{ "<leader>il", "<cmd>Trouble loclist toggle<cr>", desc = "Location List" },
			{ "<leader>iq", "<cmd>Trouble qflist toggle<cr>", desc = "Quick Fix" },
			{ "<leader>vv", "<cmd>Trouble symbols toggle<cr>", desc = "Symbol Sidebar" },
			{ "<leader>vl", "<cmd>Trouble symbols toggle<cr>", desc = "Outline" },
			{ "<leader>co", "<cmd>Trouble symbols toggle<cr>", desc = "Symbols sidebar" },
		},
		opts = { use_diagnostic_signs = true },
	},

	-- }}}1
	-- ══════════════════════════════════════════════════════════════════════════
	-- SECTION: SNIPPETS {{{1
	-- ══════════════════════════════════════════════════════════════════════════
	{
		"L3MON4D3/LuaSnip",
		version = "v2.*",
		build = "make install_jsregexp",
		dependencies = { "rafamadriz/friendly-snippets" },
		event = "InsertEnter",
		config = function()
			require("luasnip.loaders.from_vscode").lazy_load()
		end,
	},

	-- }}}1
	-- ══════════════════════════════════════════════════════════════════════════
	-- SECTION: SYNTAX & PARSING (TREESITTER) {{{1
	-- ══════════════════════════════════════════════════════════════════════════
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

	-- }}}1
	-- ══════════════════════════════════════════════════════════════════════════
	-- SECTION: FUZZY FINDER & SEARCH {{{1
	-- ══════════════════════════════════════════════════════════════════════════
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
			-- Quickfix keymaps
			actions = {
				files = {
					["default"] = function(...) return require("fzf-lua").actions.file_edit(...) end,
					["ctrl-q"] = function(...) return require("fzf-lua").actions.file_sel_to_qf(...) end,
					["alt-q"] = function(...) return require("fzf-lua").actions.file_sel_to_qf(...) end,
				},
			},
			keymap = {
				fzf = {
					["ctrl-q"] = "select-all+accept",
					["alt-q"] = "select-all+accept",
				},
			},
		},
	},

	-- }}}1
	-- ══════════════════════════════════════════════════════════════════════════
	-- SECTION: SEARCH & REPLACE {{{1
	-- ══════════════════════════════════════════════════════════════════════════
	{
		"MagicDuck/grug-far.nvim",
		cmd = "GrugFar",
		keys = {
			{ "<leader>sr", "<cmd>GrugFar<cr>", desc = "Search & Replace" },
		},
		opts = {},
	},

	-- }}}1
	-- ══════════════════════════════════════════════════════════════════════════
	-- SECTION: GIT INTEGRATION {{{1
	-- ══════════════════════════════════════════════════════════════════════════
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

	-- }}}1
	-- ══════════════════════════════════════════════════════════════════════════
	-- SECTION: CODE EDITING & TEXT MANIPULATION {{{1
	-- ══════════════════════════════════════════════════════════════════════════
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

	-- }}}1
	-- ══════════════════════════════════════════════════════════════════════════
	-- SECTION: NAVIGATION & FILE MANAGEMENT {{{1
	-- ══════════════════════════════════════════════════════════════════════════
	{
		"stevearc/oil.nvim",
		lazy = false,
		opts = {
			default_file_explorer = true,
			columns = { "icon" },
			view_options = {
				show_hidden = true,
			},
			float = {
				padding = 2,
				max_width = 90,
				max_height = 0,
				border = "rounded",
			},
			keymaps = {
				["g?"] = "actions.show_help",
				["<CR>"] = "actions.select",
				["<C-s>"] = "actions.select_vsplit",
				["<C-h>"] = "actions.select_split",
				["<C-t>"] = "actions.select_tab",
				["<C-p>"] = "actions.preview",
				["<C-c>"] = "actions.close",
				["<C-r>"] = "actions.refresh",
				["-"] = "actions.parent",
				["_"] = "actions.open_cwd",
				["`"] = "actions.cd",
				["~"] = "actions.tcd",
				["gs"] = "actions.change_sort",
				["gx"] = "actions.open_external",
				["g."] = "actions.toggle_hidden",
			},
		},
		keys = {
			{ "-", "<cmd>Oil<cr>", desc = "Open parent directory" },
		},
	},

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

	-- }}}1
	-- ══════════════════════════════════════════════════════════════════════════
	-- SECTION: TERMINAL {{{1
	-- ══════════════════════════════════════════════════════════════════════════
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

	-- }}}1
	-- ══════════════════════════════════════════════════════════════════════════
	-- SECTION: DEBUGGING (DAP) {{{1
	-- ══════════════════════════════════════════════════════════════════════════
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

	-- }}}1
	-- ══════════════════════════════════════════════════════════════════════════
	-- SECTION: TESTING {{{1
	-- ══════════════════════════════════════════════════════════════════════════
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
		cmd = { "TestNearest", "TestFile", "TestSuite", "TestLast", "TestVisit" },
		keys = {
			{ "<leader>tn", "<cmd>TestNearest<cr>", desc = "Test nearest" },
			{ "<leader>tF", "<cmd>TestFile<cr>", desc = "Test file (vim-test)" },
			{ "<leader>tS", "<cmd>TestSuite<cr>", desc = "Test suite" },
			{ "<leader>tl", "<cmd>TestLast<cr>", desc = "Test last" },
			{ "<leader>tv", "<cmd>TestVisit<cr>", desc = "Test visit" },
		},
	},

	-- }}}1
	-- ══════════════════════════════════════════════════════════════════════════
	-- SECTION: LANGUAGE-SPECIFIC PLUGINS {{{1
	-- ══════════════════════════════════════════════════════════════════════════
	
	-- Python

	-- Python
	{
		"linux-cultist/venv-selector.nvim",
		ft = "python",
		dependencies = { "neovim/nvim-lspconfig" },
		branch = "regexp",
		opts = {},
		keys = { { "<leader>pv", "<cmd>VenvSelect<cr>", desc = "Select VirtualEnv" } },
	},

	-- LaTeX (Optimized for Speed)
	{
		"lervag/vimtex",
		ft = { "tex", "latex" },
		config = function()
			-- Viewer settings
			vim.g.vimtex_view_method = "skim"
			vim.g.vimtex_view_skim_sync = 1 -- Forward search after successful compilation
			vim.g.vimtex_view_skim_activate = 0 -- Don't activate Skim on compilation
			
			-- Compiler settings (optimized for speed)
			vim.g.vimtex_compiler_method = "latexmk"
			vim.g.vimtex_compiler_latexmk = {
				build_dir = "build", -- Keep artifacts in separate dir (cleaner)
				callback = 1,
				continuous = 1, -- Continuous compilation (faster iterations)
				executable = "latexmk",
				options = {
					"-pdf",
					"-shell-escape",
					"-verbose",
					"-file-line-error",
					"-synctex=1",
					"-interaction=nonstopmode",
				},
			}
			
			-- Performance optimizations
			vim.g.vimtex_compiler_latexmk_engines = {
				_ = "-lualatex", -- LuaLaTeX is faster than pdflatex for most cases
			}
			vim.g.vimtex_quickfix_mode = 0 -- Don't open quickfix automatically (faster)
			vim.g.vimtex_log_ignore = { -- Ignore common warnings (less noise)
				"Underfull",
				"Overfull",
				"specifier changed to",
				"Token not allowed in a PDF string",
			}
			
			-- Disable unused features (speed up)
			vim.g.vimtex_indent_enabled = 0 -- Use treesitter/LSP for indenting
			vim.g.vimtex_imaps_enabled = 0 -- Disable insert mode mappings (use snippets instead)
			vim.g.vimtex_complete_enabled = 0 -- Use LSP (texlab) for completion
			vim.g.vimtex_syntax_enabled = 1 -- Keep syntax (needed for concealment)
			
			-- Concealment (optional, disable if too slow)
			vim.g.vimtex_syntax_conceal = {
				accents = 1,
				ligatures = 1,
				cites = 1,
				fancy = 1,
				spacing = 0, -- Disable spacing concealment (can be slow)
				greek = 1,
				math_bounds = 0,
				math_delimiters = 1,
				math_fracs = 1,
				math_super_sub = 1,
				math_symbols = 1,
				sections = 0,
				styles = 0, -- Disable style concealment (can be slow)
			}
			
			-- Table of contents settings
			vim.g.vimtex_toc_config = {
				name = "TOC",
				layers = { "content", "todo", "include" },
				split_width = 30,
				todo_sorted = 0,
				show_help = 0,
				show_numbers = 1,
				mode = 2,
			}
			
			-- neovim-remote for callbacks (use full path)
			vim.g.vimtex_compiler_progname = "/Users/yasser/.local/bin/nvr"
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

	-- }}}1
	-- ══════════════════════════════════════════════════════════════════════════
	-- SECTION: UI ENHANCEMENTS {{{1
	-- ══════════════════════════════════════════════════════════════════════════
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

	-- }}}1
	-- ══════════════════════════════════════════════════════════════════════════
	-- SECTION: UTILITIES {{{1
	-- ══════════════════════════════════════════════════════════════════════════
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
		"danymat/neogen",
		cmd = "Neogen",
		keys = {
			{ "<leader>nf", "<cmd>Neogen func<cr>", desc = "Function annotation" },
			{ "<leader>nc", "<cmd>Neogen class<cr>", desc = "Class annotation" },
		},
		opts = { snippet_engine = "luasnip" },
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
		"moll/vim-bbye",
		cmd = { "Bdelete", "Bwipeout" },
	},

	-- }}}1
}
-- vim:foldmethod=marker:foldlevel=0
