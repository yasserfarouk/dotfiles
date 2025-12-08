return {
	-- GitHub Copilot completion source for nvim-cmp
	{
	  "NickvanDyke/opencode.nvim",
	  dependencies = {
		-- Recommended for `ask()` and `select()`.
		-- Required for `snacks` provider.
		---@module 'snacks' <- Loads `snacks.nvim` types for configuration intellisense.
		{ "folke/snacks.nvim", opts = { input = {}, picker = {}, terminal = {} } },
	  },
	  config = function()
		---@type opencode.Opts
		vim.g.opencode_opts = {
		  provider = {
			enabled = "snacks",
			snacks = {
			  -- ...
			}
		  }
		}

		-- Required for `opts.events.reload`.
		vim.o.autoread = true

		-- Recommended/example keymaps.
vim.keymap.set({ "n", "x" }, "<leader>pa", function() require("opencode").ask("@this: ", { submit = true }) end, { desc = "Ask opencode" })
		vim.keymap.set({ "n", "x" }, "<leader>ps", function() require("opencode").select() end,                          { desc = "Execute opencode action…" })
		vim.keymap.set({ "n", "x" },    "ga", function() require("opencode").prompt("@this") end,                   { desc = "Add to opencode" })
		



		vim.keymap.set({ "n", "t" }, "<leader>pp", function() require("opencode").toggle() end,                          { desc = "Toggle opencode" })
	vim.keymap.set("n",        "<S-C-u>", function() require("opencode").command("session.half.page.up") end,   { desc = "opencode half page up" })
		vim.keymap.set("n",        "<S-C-d>", function() require("opencode").command("session.half.page.down") end, { desc = "opencode half page down" })
		-- -- You may want these if you stick with the opinionated "<C-a>" and "<C-x>" above — otherwise consider "<leader>o".
		-- vim.keymap.set('n', '+', '<C-a>', { desc = 'Increment', noremap = true })
		-- vim.keymap.set('n', '-', '<C-x>', { desc = 'Decrement', noremap = true })
	  end,
	},
	{
		"zbirenbaum/copilot-cmp",
		event = "InsertEnter",
		dependencies = {
			"zbirenbaum/copilot.lua",
		},
		config = function()
			require("copilot_cmp").setup()
		end,
	},
	-- GitHub Copilot AI code suggestions
	{
		"zbirenbaum/copilot.lua",
		cmd = "Copilot",
		requires = {
			"copilotlsp-nvim/copilot-lsp",
			init = function()
				vim.g.copilot_nes_debounce = 500
			end,
		},
		event = "InsertEnter",
		config = function()
			require("copilot").setup({
				panel = {
					enabled = false,
					auto_refresh = false,
					keymap = {
						jump_prev = "[[",
						jump_next = "]]",
						accept = "<M-l>",
						refresh = "gr",
						open = "<M-CR>",
					},
					layout = {
						position = "right", -- | top | left | right | horizontal | vertical
						ratio = 0.4,
					},
				},
				suggestion = {
					enabled = true,
					auto_trigger = false,
					hide_during_completion = true,
					debounce = 75,
					trigger_on_accept = true,
					keymap = {
						accept = false, -- Disable default, we'll set custom keymaps
						accept_word = "<M-w>",
						accept_line = "M-q",
						next = "<M-]>",
						prev = "<M-[>",
						dismiss = "<C-]>",
					},
				},
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
				auth_provider_url = nil, -- URL to authentication provider, if not "https://github.com/"
				logger = {
					file = vim.fn.stdpath("log") .. "/copilot-lua.log",
					file_log_level = vim.log.levels.OFF,
					print_log_level = vim.log.levels.OFF,
					trace_lsp = "off", -- "off" | "messages" | "verbose"
					trace_lsp_progress = false,
					log_lsp_messages = false,
				},
				copilot_node_command = "node", -- Node.js version must be > 20
				workspace_folders = { "/Users/yasser/code" },
				copilot_model = "claude-sonnet-4.5", -- Current LSP default is gpt-35-turbo, supports gpt-4o-copilot
				root_dir = function()
					return vim.fs.dirname(vim.fs.find(".git", { upward = true })[1])
				end,
				should_attach = function(_, _)
					if not vim.bo.buflisted then
						-- vim.logger.debug("not attaching, buffer is not 'buflisted'")
						return false
					end

					if vim.bo.buftype ~= "" then
						-- logger.debug("not attaching, buffer 'buftype' is " .. vim.bo.buftype)
						return false
					end

					return true
				end,
				server = {
					type = "nodejs", -- "nodejs" | "binary"
					custom_server_filepath = nil,
				},
				server_opts_overrides = {},
			})

			-- Custom keymaps for Copilot suggestion acceptance
			-- Map both Ctrl-Enter (CSI u sequence from Kitty) and Alt-Enter
			vim.keymap.set("i", "<C-CR>", function()
				if require("copilot.suggestion").is_visible() then
					require("copilot.suggestion").accept()
				else
					return "<C-CR>"
				end
			end, { expr = true, silent = true, desc = "Accept Copilot suggestion" })

			-- Also map the CSI u sequence directly in case Neovim receives it
			vim.keymap.set("i", "<M-CR>", function()
				if require("copilot.suggestion").is_visible() then
					require("copilot.suggestion").accept()
				else
					return "<M-CR>"
				end
			end, { expr = true, silent = true, desc = "Accept Copilot suggestion (Alt)" })
		end,
	},
	-- GitHub Copilot Chat for AI-assisted coding conversations
	{
		"CopilotC-Nvim/CopilotChat.nvim",
		branch = "main",
		dependencies = {
			{ "zbirenbaum/copilot.lua" },
			{ "nvim-lua/plenary.nvim", branch = "master" },
		},
		build = "make tiktoken",
		cmd = {
			"CopilotChat",
			"CopilotChatOpen",
			"CopilotChatToggle",
			"CopilotChatExplain",
			"CopilotChatReview",
			"CopilotChatFix",
			"CopilotChatOptimize",
			"CopilotChatDocs",
			"CopilotChatTests",
			"CopilotChatCommit",
		},
		keys = {
			{ "<leader>aa", "<cmd>CopilotChatToggle<cr>", desc = "Toggle Copilot Chat" },
			{ "<leader>ae", "<cmd>CopilotChatExplain<cr>", mode = { "n", "v" }, desc = "Explain Code" },
			{ "<leader>ar", "<cmd>CopilotChatReview<cr>", mode = { "n", "v" }, desc = "Review Code" },
			{ "<leader>af", "<cmd>CopilotChatFix<cr>", mode = { "n", "v" }, desc = "Fix Code" },
			{ "<leader>ao", "<cmd>CopilotChatOptimize<cr>", mode = { "n", "v" }, desc = "Optimize Code" },
			{ "<leader>ad", "<cmd>CopilotChatDocs<cr>", mode = { "n", "v" }, desc = "Generate Docs" },
			{ "<leader>at", "<cmd>CopilotChatTests<cr>", mode = { "n", "v" }, desc = "Generate Tests" },
			{ "<leader>ac", "<cmd>CopilotChatCommit<cr>", desc = "Write Commit Message" },
		},
		opts = {
			debug = false,
			model = "claude-sonnet-4.5",
			window = {
				layout = "vertical", -- 'vertical', 'horizontal', 'float', 'replace'
				width = 0.4, -- relative width
				height = 0.8, -- relative height
				border = "rounded",
			},
			mappings = {
				complete = {
					detail = "Use @<Tab> or /<Tab> for options.",
					insert = "<Tab>",
				},
				close = {
					normal = "q",
					insert = "<C-c>",
				},
				reset = {
					normal = "<C-r>",
					insert = "<C-r>",
				},
				submit_prompt = {
					normal = "<CR>",
					insert = "<C-s>",
				},
			},
		},
	},
}
