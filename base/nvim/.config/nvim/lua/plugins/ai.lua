return {
	-- Sidekick.nvim - AI sidekick with NES and multi-tool CLI integration
	{
		"folke/sidekick.nvim",
		dependencies = {
			{ "folke/snacks.nvim", opts = { input = {}, picker = {}, terminal = {} } },
		},
		opts = {
			-- Next Edit Suggestions configuration
			nes = {
				enabled = true,
				debounce = 100,
				diff = {
					inline = "words", -- "words"|"chars"|false
				},
			},
			-- AI CLI tools configuration
			cli = {
				watch = true, -- Auto-reload files modified by AI tools
				win = {
					layout = "right", -- Layout for CLI window
					split = {
						width = 80,
						height = 20,
					},
					-- Custom keymaps for CLI window
					keys = {
						buffers = { "<c-b>", "buffers", mode = "nt", desc = "open buffer picker" },
						files = { "<c-f>", "files", mode = "nt", desc = "open file picker" },
						hide_n = { "q", "hide", mode = "n", desc = "hide the terminal window" },
						hide_ctrl_q = { "<c-q>", "hide", mode = "n", desc = "hide the terminal window" },
						hide_ctrl_dot = { "<c-.>", "hide", mode = "nt", desc = "hide the terminal window" },
						prompt = { "<c-p>", "prompt", mode = "t", desc = "insert prompt or context" },
						stopinsert = { "<c-q>", "stopinsert", mode = "t", desc = "enter normal mode" },
						-- Navigate windows in terminal mode
						nav_left = { "<c-h>", "nav_left", expr = true, desc = "navigate to the left window" },
					},
				},
				-- Tmux integration for session persistence
				mux = {
					backend = "tmux",
					enabled = true,
					create = "terminal", -- "terminal"|"window"|"split"
					split = {
						vertical = true,
						size = 0.5,
					},
				},
				-- AI CLI tools - Copilot as primary (uses your GitHub subscription)
				tools = {
					copilot = { cmd = { "copilot", "--banner" } },
					opencode = {
						cmd = { "opencode" },
						env = { OPENCODE_THEME = "system" },
					},
					aider = { cmd = { "aider" } },
				},
				-- Custom prompts for common tasks
				prompts = {
					-- Pre-defined prompts
					explain = "Explain {this}",
					fix = "Can you fix {this}?",
					optimize = "How can {this} be optimized?",
					review = "Can you review {file} for any issues or improvements?",
					tests = "Can you write tests for {this}?",
					document = "Add documentation to {function|line}",
					diagnostics = "Can you help me fix the diagnostics in {file}?\n{diagnostics}",
					-- Context-only prompts
					file = "{file}",
					line = "{line}",
					position = "{position}",
					selection = "{selection}",
				},
				picker = "snacks", -- Use snacks.nvim for pickers
			},
			-- Copilot LSP status tracking
			copilot = {
				status = {
					enabled = true,
					level = vim.log.levels.WARN,
				},
			},
		},
		keys = {
			-- Tab navigation for NES
			{
				"<tab>",
				function()
					-- if there is a next edit, jump to it, otherwise apply it if any
					if not require("sidekick").nes_jump_or_apply() then
						return "<Tab>" -- fallback to normal tab
					end
				end,
				expr = true,
				desc = "Goto/Apply Next Edit Suggestion",
			},

			-- Primary CLI keymaps under <leader>p
			{
				"<leader>pp",
				function()
					require("sidekick.cli").toggle({ name = "copilot", focus = true })
				end,
				desc = "Toggle Copilot Chat",
				mode = { "n", "t" },
			},
			{
				"<leader>pa",
				function()
					require("sidekick.cli").toggle()
				end,
				desc = "Toggle AI CLI",
			},
			{
				"<leader>ps",
				function()
					require("sidekick.cli").select({ filter = { installed = true } })
				end,
				desc = "Select AI CLI Tool",
			},
			{
				"<leader>pd",
				function()
					require("sidekick.cli").close()
				end,
				desc = "Close CLI Session",
			},
			{
				"<leader>pt",
				function()
					require("sidekick.cli").send({ msg = "{this}" })
				end,
				mode = { "x", "n" },
				desc = "Send This to AI",
			},
			{
				"<leader>pf",
				function()
					require("sidekick.cli").send({ msg = "{file}" })
				end,
				desc = "Send File to AI",
			},
			{
				"<leader>pv",
				function()
					require("sidekick.cli").send({ msg = "{selection}" })
				end,
				mode = { "x" },
				desc = "Send Visual Selection to AI",
			},
			{
				"<leader>pm",
				function()
					require("sidekick.cli").prompt()
				end,
				mode = { "n", "x" },
				desc = "Select AI Prompt",
			},
			{
				"<leader>pj",
				function()
					-- Scratchpad: open input, send to Copilot with auto-Enter
					vim.ui.input({ prompt = "Message for Copilot: " }, function(input)
						if input and input ~= "" then
							require("sidekick.cli").send({
								name = "copilot",
								msg = input,
								focus = false,
							})
						end
					end)
				end,
				desc = "Copilot Scratchpad",
				mode = { "n" },
			},

			-- Quick access keymaps
			{
				"ga",
				function()
					require("sidekick.cli").send({ msg = "@this: {this}" })
				end,
				mode = { "n", "x" },
				desc = "Add to Copilot",
			},
			{
				"<C-s>",
				function()
					-- Quick scratchpad access (alias to <leader>pj)
					vim.ui.input({ prompt = "Message for Copilot: " }, function(input)
						if input and input ~= "" then
							require("sidekick.cli").send({
								name = "copilot",
								msg = input,
								focus = false,
							})
						end
					end)
				end,
				desc = "Copilot Scratchpad",
				mode = { "n" },
			},

			-- Specific tool toggles
			{
				"<leader>po",
				function()
					require("sidekick.cli").toggle({ name = "opencode", focus = true })
				end,
				desc = "Toggle OpenCode",
			},
			{
				"<leader>pr",
				function()
					require("sidekick.cli").toggle({ name = "aider", focus = true })
				end,
				desc = "Toggle Aider",
			},
		},
	},

	-- GitHub Copilot for inline ghost text completions
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
	{
		"zbirenbaum/copilot.lua",
		cmd = "Copilot",
		event = "InsertEnter",
		config = function()
			require("copilot").setup({
				panel = {
					enabled = false,
					auto_refresh = false,
				},
				suggestion = {
					enabled = true,
					auto_trigger = true,
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
				copilot_node_command = "node",
				workspace_folders = { "/Users/yasser/code" },
				copilot_model = "gpt-41-copilot", -- Valid completion model (gpt-4o-copilot was incorrect)
				root_dir = function()
					return vim.fs.dirname(vim.fs.find(".git", { upward = true })[1])
				end,
				should_attach = function(_, _)
					if not vim.bo.buflisted then
						return false
					end
					if vim.bo.buftype ~= "" then
						return false
					end
					return true
				end,
			})

			-- Custom keymaps for Copilot suggestion acceptance
			vim.keymap.set("i", "<M-\\>", function()
				require("copilot.suggestion").next()
			end, { silent = true, desc = "Trigger Copilot suggestion" })

			-- Accept Copilot suggestions with Ctrl-Enter or Alt-Enter
			vim.keymap.set("i", "<C-CR>", function()
				if require("copilot.suggestion").is_visible() then
					require("copilot.suggestion").accept()
				else
					return "<C-CR>"
				end
			end, { expr = true, silent = true, desc = "Accept Copilot suggestion" })

			vim.keymap.set("i", "<M-CR>", function()
				if require("copilot.suggestion").is_visible() then
					require("copilot.suggestion").accept()
				else
					return "<M-CR>"
				end
			end, { expr = true, silent = true, desc = "Accept Copilot suggestion (Alt)" })
		end,
	},
}
