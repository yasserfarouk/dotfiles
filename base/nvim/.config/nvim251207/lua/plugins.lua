return {
	-- ══════════════════════════════════════════════════════════════════════════
	-- SECTION: UI & APPEARANCE {{{1
	-- ══════════════════════════════════════════════════════════════════════════

	-- Colorscheme - tokyonight theme
	{
		"folke/tokyonight.nvim",
		lazy = false,
		priority = 1000,
		config = function()
			vim.cmd.colorscheme("tokyonight")
		end,
	},

	-- Breadcrumbs - shows current code context (function, class, etc)
	{
		"utilyre/barbecue.nvim",
		name = "barbecue",
		version = "*",
		dependencies = {
			"SmiteshP/nvim-navic",
			"echasnovski/mini.icons",
		},
		event = "LspAttach",
		opts = {
			theme = "tokyonight",
			show_modified = true,
			exclude_filetypes = { "netrw", "toggleterm", "neo-tree" },
			attach_navic = function(client, bufnr)
				-- Only attach to basedpyright for Python, not pyright
				if client.name == "pyright" then
					return false
				end
				return true
			end,
		},
	},

	-- }}}1
	-- ══════════════════════════════════════════════════════════════════════════
	-- SECTION: LSP & COMPLETION {{{1
	-- ══════════════════════════════════════════════════════════════════════════
	{
		"neovim/nvim-lspconfig",
		event = { "BufReadPre", "BufNewFile" },
		dependencies = {
			{ "folke/lazydev.nvim", ft = "lua", opts = {} },
			{ "j-hui/fidget.nvim", opts = {} },
			"williamboman/mason.nvim",
			"williamboman/mason-lspconfig.nvim",
			"hrsh7th/cmp-nvim-lsp",
		},
		config = function()
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

			-- Get nvim-cmp capabilities
			local capabilities = require("cmp_nvim_lsp").default_capabilities()

			-- Get lspconfig to access default configurations
			local lspconfig = require("lspconfig")
			local lspconfig_configs = require("lspconfig.configs")

			-- Define servers to install and configure
			local servers = {
				"basedpyright",
				"lua_ls",
				"jdtls",
				"ts_ls",
				"html",
				"texlab",
				"marksman",
				"intelephense",
				"esbonio",
				"bashls",
				"jsonls", -- JSON
				"yamlls", -- YAML
				"taplo", -- TOML
				"clangd", -- C/C++
				"harper_ls", -- Grammar/spell checker for documents
			}

			-- Configure each server using modern vim.lsp.config API
			for _, server_name in ipairs(servers) do
				local config = lspconfig_configs[server_name]
				if config and config.default_config then
					local default = config.default_config
					local server_config = {
						cmd = default.cmd,
						filetypes = default.filetypes,
						root_markers = default.root_dir and vim.fs.root and { ".git" } or nil,
						capabilities = capabilities,
					}

					-- Basedpyright specific configuration
					if server_name == "basedpyright" then
						server_config.settings = {
							basedpyright = {
								analysis = {
									diagnosticMode = "openFilesOnly",
									useLibraryCodeForTypes = true,
									enableTypeIgnoreComments = true,
								},
							},
						}
					end

					-- Harper-ls specific configuration for document filetypes only
					if server_name == "harper_ls" then
						server_config.filetypes = { "markdown", "tex", "latex", "rst", "text", "gitcommit" }
						server_config.settings = {
							["harper-ls"] = {
								linters = {
									spell_check = true,
									spelled_numbers = false,
									an_a = true,
									sentence_capitalization = true,
									unclosed_quotes = true,
									wrong_quotes = false,
									long_sentences = true,
									repeated_words = true,
									spaces = true,
									matcher = true,
								},
							},
						}
					end

					vim.lsp.config(server_name, server_config)
				end
			end

			-- Mason auto-install and auto-enable
			require("mason-lspconfig").setup({
				ensure_installed = servers,
				automatic_enable = true,
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

	-- Diagnostics and symbols viewer
	{
		"folke/trouble.nvim",
		cmd = "Trouble",
		keys = {
			{ "<leader>id", "<cmd>Trouble diagnostics toggle filter.buf=0<cr>", desc = "Document Diagnostics" },
			{ "<leader>ii", "<cmd>LspInfo<cr>", desc = "LSP Info" },
			{ "<leader>il", "<cmd>Trouble loclist toggle<cr>", desc = "Location List" },
			{ "<leader>iq", "<cmd>Trouble qflist toggle<cr>", desc = "Quick Fix" },
			{ "<leader>vs", "<cmd>Trouble symbols toggle<cr>", desc = "Symbols sidebar" },
			{ "<leader>co", "<cmd>Trouble symbols toggle focus=true<cr>", desc = "Code outline" },
		},
		opts = { use_diagnostic_signs = true },
	},
	-- }}}1
	-- ══════════════════════════════════════════════════════════════════════════
	-- SECTION: COMPLETION {{{1}
	-- ══════════════════════════════════════════════════════════════════════════
	{
		"hrsh7th/nvim-cmp",
		event = "InsertEnter",
		dependencies = {
			"hrsh7th/cmp-nvim-lsp",
			"hrsh7th/cmp-buffer",
			"hrsh7th/cmp-path",
			"hrsh7th/cmp-cmdline",
			"saadparwaiz1/cmp_luasnip",
			{
				"L3MON4D3/LuaSnip",
				version = "v2.*",
				build = "make install_jsregexp",
				dependencies = { "rafamadriz/friendly-snippets" },
				config = function()
					require("luasnip.loaders.from_vscode").lazy_load()
				end,
			},
		},
		config = function()
			local cmp = require("cmp")
			local luasnip = require("luasnip")
			local kind_icons = {
				Text = "󰉿",
				Method = "󰡱",
				Function = "󰊕",
				Constructor = "C",
				Field = "f",
				Variable = "󰆧",
				Class = "󰌗",
				Interface = "",
				Module = "",
				Property = "",
				Unit = "",
				Value = "󰬺",
				Enum = "",
				Keyword = "󰌋",
				Snippet = "s",
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
				snippet = {
					expand = function(args)
						luasnip.lsp_expand(args.body)
					end,
				},
				window = {
					completion = cmp.config.window.bordered({ border = "rounded" }),
					documentation = cmp.config.window.bordered({ border = "rounded" }),
				},
				sources = cmp.config.sources({
					{ name = "lazydev", group_index = 0 },
					{ name = "nvim_lsp" },
					{ name = "luasnip" },
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
					["<CR>"] = cmp.mapping(function(fallback)
						if cmp.visible() and cmp.get_selected_entry() then
							cmp.confirm({ behavior = cmp.ConfirmBehavior.Replace, select = false })
						else
							fallback()
						end
					end, { "i", "s" }),
					["<C-;>"] = cmp.mapping(function(fallback)
						local copilot_ok, copilot_suggestion = pcall(require, "copilot.suggestion")
						if copilot_ok and copilot_suggestion.is_visible() then
							copilot_suggestion.accept()
						else
							fallback()
						end
					end, { "i", "s" }),
					["<Tab>"] = cmp.mapping(function(fallback)
						-- Prioritize cmp menu if visible, otherwise check copilot
						if cmp.visible() then
							cmp.select_next_item()
						else
							local copilot_ok, copilot_suggestion = pcall(require, "copilot.suggestion")
							if copilot_ok and copilot_suggestion.is_visible() then
								copilot_suggestion.accept()
							elseif luasnip.expand_or_jumpable() then
								luasnip.expand_or_jump()
							else
								fallback()
							end
						end
					end, { "i", "s" }),
					["<S-Tab>"] = cmp.mapping(function(fallback)
						if cmp.visible() then
							cmp.select_prev_item()
						elseif luasnip.jumpable(-1) then
							luasnip.jump(-1)
						else
							fallback()
						end
					end, { "i", "s" }),
				}),
				completion = { completeopt = "menu,menuone,noinsert" },
				experimental = { ghost_text = false },
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
					accept = "<M-CR>", -- Handled by cmp Tab mapping
					accept_word = "<M-w>",
					accept_line = "<M-l>",
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
		"CopilotC-Nvim/CopilotChat.nvim",
		branch = "main",
		dependencies = { "zbirenbaum/copilot.lua", "nvim-lua/plenary.nvim" },
		cmd = {
			"CopilotChat",
			"CopilotChatOpen",
			"CopilotChatClose",
			"CopilotChatToggle",
			"CopilotChatReset",
		},
		opts = {},
		keys = {
			{ "<leader>cc", "<cmd>CopilotChatToggle<cr>", desc = "Copilot Chat" },
		},
	},

	-- }}}1
	-- ══════════════════════════════════════════════════════════════════════════
	-- SECTION: SNIPPETS {{{1
	-- ══════════════════════════════════════════════════════════════════════════
	-- LuaSnip is loaded via nvim-cmp dependencies

	-- }}}1
	-- ══════════════════════════════════════════════════════════════════════════
	-- SECTION: SYNTAX & PARSING (TREESITTER) {{{1
	-- ══════════════════════════════════════════════════════════════════════════
	{
		"nvim-treesitter/nvim-treesitter",
		build = ":TSUpdate",
		event = "BufReadPost",
		dependencies = {
			"nvim-treesitter/nvim-treesitter-textobjects",
		},
		opts = {
			ensure_installed = {
				"python",
				"lua",
				"java",
				"javascript",
				"typescript",
				"html",
				"css",
				"php",
				"latex",
				"markdown",
				"markdown_inline",
				"rst",
				"bash",
				"json",
				"yaml",
				"toml",
				"vim",
				"vimdoc",
				"regex",
				"c",
				"cpp",
			},
			highlight = { enable = true },
			indent = { enable = true, disable = { "python" } },
			autotag = { enable = true },
			textobjects = {
				select = {
					enable = true,
					lookahead = true,
					keymaps = {
						-- Functions
						["af"] = "@function.outer",
						["if"] = "@function.inner",
						-- Classes
						["ac"] = "@class.outer",
						["ic"] = "@class.inner",
						-- Blocks
						["ab"] = "@block.outer",
						["ib"] = "@block.inner",
						-- Parameters/arguments
						["aa"] = "@parameter.outer",
						["ia"] = "@parameter.inner",
						-- Conditionals
						["ai"] = "@conditional.outer",
						["ii"] = "@conditional.inner",
						-- Loops
						["al"] = "@loop.outer",
						["il"] = "@loop.inner",
						-- Calls
						["aF"] = "@call.outer",
						["iF"] = "@call.inner",
						-- Comments
						["a/"] = "@comment.outer",
						["i/"] = "@comment.inner",
					},
				},
				move = {
					enable = true,
					set_jumps = true,
					goto_next_start = {
						["]m"] = "@function.outer",
						["]c"] = "@class.outer",
						["]a"] = "@parameter.inner",
						["]o"] = "@conditional.outer",
						["]l"] = "@loop.outer",
					},
					goto_next_end = {
						["]M"] = "@function.outer",
						["]C"] = "@class.outer",
						["]A"] = "@parameter.inner",
						["]O"] = "@conditional.outer",
						["]L"] = "@loop.outer",
					},
					goto_previous_start = {
						["[m"] = "@function.outer",
						["[c"] = "@class.outer",
						["[a"] = "@parameter.inner",
						["[o"] = "@conditional.outer",
						["[l"] = "@loop.outer",
					},
					goto_previous_end = {
						["[M"] = "@function.outer",
						["[C"] = "@class.outer",
						["[A"] = "@parameter.inner",
						["[O"] = "@conditional.outer",
						["[L"] = "@loop.outer",
					},
				},
				swap = {
					enable = true,
					swap_next = {
						[">a"] = "@parameter.inner",
						[">f"] = "@function.outer",
					},
					swap_previous = {
						["<a"] = "@parameter.inner",
						["<f"] = "@function.outer",
					},
				},
				lsp_interop = {
					enable = true,
					border = "rounded",
					floating_preview_opts = {},
					peek_definition_code = {
						["<leader>kf"] = "@function.outer",
						["<leader>kc"] = "@class.outer",
					},
				},
			},
		},
	},

	{
		"windwp/nvim-ts-autotag",
		ft = { "php", "html", "xml", "javascript", "typescript", "javascriptreact", "typescriptreact" },
	},
	{ "JoosepAlviste/nvim-ts-context-commentstring", event = "BufReadPost" },

	-- }}}1
	-- ══════════════════════════════════════════════════════════════════════════
	-- SECTION: FUZZY FINDER & SEARCH {{{1
	-- ══════════════════════════════════════════════════════════════════════════

	-- }}}1
	-- ══════════════════════════════════════════════════════════════════════════
	-- SECTION: SEARCH & REPLACE {{{1
	-- ══════════════════════════════════════════════════════════════════════════
	{
		"MagicDuck/grug-far.nvim",
		cmd = "GrugFar",
		keys = {
			{ "<leader>rr", "<cmd>GrugFar<cr>", desc = "Search & Replace" },
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
			{ "<leader>gro", "<cmd>GitConflictChooseOurs<cr>", desc = "Choose ours" },
			{ "<leader>grt", "<cmd>GitConflictChooseTheirs<cr>", desc = "Choose theirs" },
			{ "<leader>grb", "<cmd>GitConflictChooseBoth<cr>", desc = "Choose both" },
			{ "<leader>gr0", "<cmd>GitConflictChooseNone<cr>", desc = "Choose none" },
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
		"nvim-neo-tree/neo-tree.nvim",
		branch = "v3.x",
		dependencies = {
			"nvim-lua/plenary.nvim",
			"echasnovski/mini.icons",
			"MunifTanjim/nui.nvim",
		},
		cmd = "Neotree",
		keys = {
			{ "<leader>e", "<cmd>Neotree toggle<cr>", desc = "Toggle file explorer" },
			{ "<leader>E", "<cmd>Neotree reveal<cr>", desc = "Reveal file in explorer" },
		},
		opts = {
			use_snacks_image = true,
			close_if_last_window = true,
			popup_border_style = "rounded",
			enable_git_status = true,
			enable_diagnostics = true,
			commands = {
				run_command = function(state)
					local node = state.tree:get_node()
					local path = node:get_id()
					vim.api.nvim_input(": " .. path .. "<Home>")
				end,
				diff_files = function(state)
					local node = state.tree:get_node()
					local log = require("neo-tree.log")
					state.clipboard = state.clipboard or {}
					if diff_Node and diff_Node ~= tostring(node.id) then
						local current_Diff = node.id
						require("neo-tree.utils").open_file(state, diff_Node, open)
						vim.cmd("vert diffs " .. current_Diff)
						log.info("Diffing " .. diff_Name .. " against " .. node.name)
						diff_Node = nil
						current_Diff = nil
						state.clipboard = {}
						require("neo-tree.ui.renderer").redraw(state)
					else
						local existing = state.clipboard[node.id]
						if existing and existing.action == "diff" then
							state.clipboard[node.id] = nil
							diff_Node = nil
							require("neo-tree.ui.renderer").redraw(state)
						else
							state.clipboard[node.id] = { action = "diff", node = node }
							diff_Name = state.clipboard[node.id].node.name
							diff_Node = tostring(state.clipboard[node.id].node.id)
							log.info("Diff source file " .. diff_Name)
							require("neo-tree.ui.renderer").redraw(state)
						end
					end
				end,
				system_open = function(state)
					local node = state.tree:get_node()
					local path = node:get_id()
					vim.fn.jobstart({ "open", path }, { detach = true })
				end,
				quick_look = function(state)
					local node = state.tree:get_node()
					if node.type == "file" then
						vim.fn.system(string.format("qlmanage -p %s > /dev/null 2>&1 &", vim.fn.shellescape(node.path)))
						vim.defer_fn(function()
							vim.fn.system(
								[[osascript -e 'tell application "qlmanage" to activate' 2>/dev/null || osascript -e 'tell application "Quick Look" to activate' 2>/dev/null]]
							)
						end, 100)
					end
				end,
				open_in_finder = function(state)
					local node = state.tree:get_node()
					if node.type == "directory" then
						vim.fn.jobstart({ "open", node.path }, { detach = true })
					else
						vim.fn.jobstart({ "open", "-R", node.path }, { detach = true })
					end
				end,
			},
			default_component_configs = {
				indent = {
					with_expanders = true,
					expander_collapsed = "",
					expander_expanded = "",
				},
			},
			window = {
				position = "left",
				width = 35,
				mappings = {
					["e"] = function()
						vim.api.nvim_exec("Neotree focus filesystem left", true)
					end,
					["b"] = function()
						vim.api.nvim_exec("Neotree focus buffers left", true)
					end,
					["D"] = "diff_files",
					["<space>"] = "quick_look",
					["<cr>"] = "open",
					["o"] = "system_open",
					["O"] = "open_in_finder",
					["i"] = "run_command",
					["s"] = "open_split",
					["v"] = "open_vsplit",
					["t"] = "open_tabnew",
					["w"] = "open_with_window_picker",
					["C"] = "close_node",
					["z"] = "close_all_nodes",
					["Z"] = "expand_all_nodes",
					["a"] = {
						"add",
						config = {
							show_path = "relative",
						},
					},
					["d"] = "delete",
					["r"] = "rename",
					["y"] = "copy_to_clipboard",
					["x"] = "cut_to_clipboard",
					["p"] = "paste_from_clipboard",
					["c"] = "copy",
					["m"] = "move",
					["q"] = "close_window",
					["R"] = "refresh",
					["?"] = "show_help",
					["<"] = "prev_source",
					[">"] = "next_source",
					["P"] = {
						"toggle_preview",
						config = {
							use_float = false,
							-- use_image_nvim = true,
							-- use_snacks_image = true,
							-- title = 'Neo-tree Preview',
						},
					},
				},
			},
			filesystem = {
				filtered_items = {
					visible = false,
					hide_dotfiles = false,
					hide_gitignored = false,
				},
				follow_current_file = {
					enabled = true,
					leave_dirs_open = false,
				},
				use_libuv_file_watcher = true,
			},
		},
	},

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

	{ "tpope/vim-unimpaired", event = "BufReadPost" },
	{ "michaeljsmith/vim-indent-object", event = "BufReadPost" },

	{
		"alexghergh/nvim-tmux-navigation",
		event = "VeryLazy",
		cond = function()
			-- Only load if in tmux or not in kitty
			return vim.env.TMUX ~= nil or vim.env.TERM ~= "xterm-kitty"
		end,
		keys = {
			{ "<C-h>", "<cmd>NvimTmuxNavigateLeft<cr>", desc = "Navigate Left" },
			{ "<C-j>", "<cmd>NvimTmuxNavigateDown<cr>", desc = "Navigate Down" },
			{ "<C-k>", "<cmd>NvimTmuxNavigateUp<cr>", desc = "Navigate Up" },
			{ "<C-l>", "<cmd>NvimTmuxNavigateRight<cr>", desc = "Navigate Right" },
			{ "<C-\\>", "<cmd>NvimTmuxNavigateLastActive<cr>", desc = "Navigate Last" },
		},
		opts = {
			disable_when_zoomed = true,
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
			{ "<leader>xd", "<cmd>lua _LAZYDOCKER_TOGGLE()<cr>", desc = "LazyDocker" },
			{ "<leader>xh", "<cmd>lua _HTOP_TOGGLE()<cr>", desc = "Htop" },
			{ "<leader>xp", "<cmd>lua _PYTHON_TOGGLE()<cr>", desc = "Python REPL" },
			{ "<leader>xl", "<cmd>lua _LUA_TOGGLE()<cr>", desc = "Lua REPL" },
			{ "<leader>xc", "<cmd>lua _COPILOT_TOGGLE()<cr>", desc = "GitHub Copilot CLI" },
			{ "<leader>xe", "<cmd>lua _NVIM_TOGGLE()<cr>", desc = "GitHub Copilot CLI" },
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
			float_opts = { border = "rounded", width = 120, height = 30 },
			-- Better shell integration
			shell = vim.o.shell,
			-- Persist size across toggles
			persist_size = true,
			persist_mode = true,
			-- Start in insert mode
			start_in_insert = true,
			-- Better terminal colors
			highlights = {
				Normal = { link = "Normal" },
				NormalFloat = { link = "NormalFloat" },
				FloatBorder = { link = "FloatBorder" },
			},
		},
		config = function(_, opts)
			require("toggleterm").setup(opts)
			local Terminal = require("toggleterm.terminal").Terminal

			-- LazyGit (modern git TUI)
			_G._LAZYGIT_TOGGLE = function()
				local lazygit = Terminal:new({
					cmd = "lazygit",
					hidden = true,
					direction = "float",
					float_opts = { border = "rounded", width = 150, height = 40 },
					on_open = function(term)
						vim.cmd("startinsert!")
						vim.api.nvim_buf_set_keymap(
							term.bufnr,
							"n",
							"q",
							"<cmd>close<CR>",
							{ noremap = true, silent = true }
						)
					end,
				})
				lazygit:toggle()
			end

			-- LazyDocker (modern docker TUI)
			_G._LAZYDOCKER_TOGGLE = function()
				local lazydocker = Terminal:new({
					cmd = "lazydocker",
					hidden = true,
					direction = "float",
					float_opts = { border = "rounded", width = 150, height = 40 },
					on_open = function(term)
						vim.cmd("startinsert!")
						vim.api.nvim_buf_set_keymap(
							term.bufnr,
							"n",
							"q",
							"<cmd>close<CR>",
							{ noremap = true, silent = true }
						)
					end,
				})
				lazydocker:toggle()
			end

			-- Htop (modern system monitor, or use btop if available)
			_G._HTOP_TOGGLE = function()
				local cmd = vim.fn.executable("btop") == 1 and "btop" or "htop"
				local htop = Terminal:new({
					cmd = cmd,
					hidden = true,
					direction = "float",
					float_opts = { border = "rounded", width = 150, height = 40 },
					on_open = function(term)
						vim.cmd("startinsert!")
						vim.api.nvim_buf_set_keymap(
							term.bufnr,
							"n",
							"q",
							"<cmd>close<CR>",
							{ noremap = true, silent = true }
						)
					end,
				})
				htop:toggle()
			end

			-- Python REPL (with IPython if available)
			_G._PYTHON_TOGGLE = function()
				local cmd = vim.fn.executable("ipython") == 1 and "ipython" or "python3"
				local python = Terminal:new({
					cmd = cmd,
					hidden = true,
					direction = "float",
					float_opts = { border = "rounded", width = 120, height = 30 },
					on_open = function(term)
						vim.cmd("startinsert!")
					end,
				})
				python:toggle()
			end

			-- Lua REPL
			_G._LUA_TOGGLE = function()
				local lua_repl = Terminal:new({
					cmd = "lua",
					hidden = true,
					direction = "float",
					float_opts = { border = "rounded", width = 120, height = 30 },
					on_open = function(term)
						vim.cmd("startinsert!")
					end,
				})
				lua_repl:toggle()
			end

			-- GitHub Copilot CLI
			_G._COPILOT_TOGGLE = function()
				local copilot = Terminal:new({
					cmd = "gh copilot --allow-all-tools",
					hidden = true,
					direction = "float",
					float_opts = { border = "rounded", width = 150, height = 40 },
					on_open = function(term)
						vim.cmd("startinsert!")
						vim.api.nvim_buf_set_keymap(
							term.bufnr,
							"n",
							"q",
							"<cmd>close<CR>",
							{ noremap = true, silent = true }
						)
					end,
				})
				copilot:toggle()
			end

			_G._NVIM_TOGGLE = function()
				local copilot = Terminal:new({
					cmd = "nvim ~/tmp/tmp.txt",
					hidden = true,
					direction = "float",
					float_opts = { border = "rounded", width = 150, height = 40 },
					on_open = function(term)
						vim.cmd("startinsert!")
						vim.api.nvim_buf_set_keymap(
							term.bufnr,
							"n",
							"q",
							"<cmd>close<CR>",
							{ noremap = true, silent = true }
						)
					end,
				})
				copilot:toggle()
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
			{ "<leader>tS", "<cmd>lua require('neotest').run.run(vim.fn.getcwd())<cr>", desc = "Test suite" },
			{ "<leader>tl", "<cmd>lua require('neotest').run.run_last()<cr>", desc = "Test last" },
			{ "<leader>ts", "<cmd>lua require('neotest').summary.toggle()<cr>", desc = "Test summary" },
			{ "<leader>to", "<cmd>lua require('neotest').output.open({ enter = true })<cr>", desc = "Test output" },
			{
				"<leader>tO",
				"<cmd>lua require('neotest').output_panel.toggle()<cr>",
				desc = "Test output panel",
			},
			{ "<leader>tw", "<cmd>lua require('neotest').watch.toggle()<cr>", desc = "Test watch" },
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

	-- }}}1
	-- ══════════════════════════════════════════════════════════════════════════
	-- SECTION: LANGUAGE-SPECIFIC PLUGINS {{{1
	-- ══════════════════════════════════════════════════════════════════════════

	-- Python venv selector - only searches ~/myvenvs
	{
		"linux-cultist/venv-selector.nvim",
		ft = "python",
		dependencies = { "neovim/nvim-lspconfig" },
		opts = {
			auto_refresh = false,
			search = false,
			notify_user_on_venv_activation = false,
			sources = { "venv" },
			venvs_path = "~/myvenvs",
		},
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

	-- Markdown preview in browser
	{
		"iamcco/markdown-preview.nvim",
		ft = "markdown",
		build = function()
			vim.fn["mkdp#util#install"]()
		end,
	},

	-- Obsidian note taking
	{
		"epwalsh/obsidian.nvim",
		lazy = true,
		event = {
			"BufReadPre "
				.. vim.fn.expand("~")
				.. "/Library/Mobile Documents/iCloud~md~obsidian/Documents/yasser/**.md",
			"BufNewFile "
				.. vim.fn.expand("~")
				.. "/Library/Mobile Documents/iCloud~md~obsidian/Documents/yasser/**.md",
		},
		dependencies = { "nvim-lua/plenary.nvim" },
		keys = {
			{ "<leader><leader>", "<cmd>ObsidianQuickSwitch<cr>", desc = "Quick switch notes" },
			{ "<leader>on", "<cmd>ObsidianNew<cr>", desc = "New note" },
			{ "<leader>os", "<cmd>ObsidianSearch<cr>", desc = "Search notes" },
			{ "<leader>oo", "<cmd>ObsidianOpen<cr>", desc = "Open in Obsidian" },
			{ "<leader>ob", "<cmd>ObsidianBacklinks<cr>", desc = "Backlinks" },
			{ "<leader>ot", "<cmd>ObsidianTags<cr>", desc = "Tags" },
			{ "<leader>oc", "<cmd>ObsidianToggleCheckbox<cr>", desc = "Toggle checkbox" },
			{ "<leader>ol", "<cmd>ObsidianFollowLink<cr>", desc = "Follow link" },
		},
		opts = {
			workspaces = {
				{ name = "yasser", path = "~/Library/Mobile Documents/iCloud~md~obsidian/Documents/yasser" },
			},
			notes_subdir = "notes",
			daily_notes = {
				folder = "daily",
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

	-- Multi-purpose UI utilities including image preview
	{
		"folke/snacks.nvim",
		priority = 1000,
		lazy = false,
		opts = function()
			-- Set vim.ui.input and vim.notify before snacks setup
			vim.ui.input = function(...)
				return require("snacks").input(...)
			end

			return {
				bigfile = { enabled = true },
				dashboard = { enabled = true },
				indent = { enabled = true },
				input = { enabled = true },
				notifier = {
					enabled = true,
					timeout = 5000,
				},
				picker = { enabled = true },
				quickfile = { enabled = true },
				scroll = { enabled = false },
				statuscolumn = { enabled = true },
				words = { enabled = true },
				image = {
					enabled = true,
					doc = {
						enabled = true,
						inline = true,
					},
				},
			}
		end,
		config = function(_, opts)
			require("snacks").setup(opts)
			-- Set vim.notify to use snacks
			vim.notify = require("snacks").notifier.notify
		end,
		init = function()
			-- Setup snacks.picker keymaps
			require("yasser.snacks_picker_keys").setup()
		end,
	},

	-- Fuzzy finder alternative with <leader>S prefix
	{
		"ibhagwan/fzf-lua",
		dependencies = { "echasnovski/mini.icons" },
		cmd = "FzfLua",
		init = function()
			require("yasser.fzf_lua_keys").setup()
		end,
		config = function()
			require("fzf-lua").setup({
				winopts = {
					height = 0.85,
					width = 0.80,
					preview = {
						default = "bat",
						border = "border",
						wrap = "nowrap",
						scrollbar = "float",
					},
				},
			})
		end,
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
