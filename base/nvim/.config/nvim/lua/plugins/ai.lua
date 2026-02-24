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
			create = "terminal", -- Use terminal mode to detect existing sessions
			split = {
				vertical = true,
				size = 0.5,
			},
		},
		-- AI CLI tools - OpenCode as primary
		tools = {
			opencode = {
				cmd = { "opencode" },
				env = { OPENCODE_THEME = "system" },
			},
			copilot = { cmd = { "copilot", "--banner" } },
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
					require("sidekick.cli").toggle({ name = "opencode", focus = true })
				end,
				desc = "Toggle OpenCode",
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
				require("sidekick.cli").send({ name = "opencode", msg = "{this}", submit = true })
			end,
			mode = { "x", "n" },
			desc = "Send This to AI",
		},
		{
			"<leader>pf",
			function()
				require("sidekick.cli").send({ name = "opencode", msg = "{file}", submit = true })
			end,
			desc = "Send File to AI",
		},
		{
			"<leader>pv",
			function()
				require("sidekick.cli").send({ name = "opencode", msg = "{selection}", submit = true })
			end,
			mode = { "x" },
			desc = "Send Visual Selection to AI",
		},
			{
				"<leader>pm",
				function()
					require("sidekick.cli").prompt({ name = "opencode", submit = true })
				end,
				mode = { "n", "x" },
				desc = "Select AI Prompt",
			},
		{
			"<leader>pj",
			function()
				-- Scratchpad: open buffer for multi-line input
				local buf = vim.api.nvim_create_buf(false, true)
				vim.api.nvim_buf_set_option(buf, "buftype", "nofile")
				vim.api.nvim_buf_set_option(buf, "bufhidden", "wipe")
				vim.api.nvim_buf_set_option(buf, "filetype", "markdown")

				-- Create bottom split
				vim.cmd("botright split")
				local win = vim.api.nvim_get_current_win()
				vim.api.nvim_win_set_buf(win, buf)
				vim.api.nvim_win_set_height(win, 15)

				-- Add instructions at the top
				vim.api.nvim_buf_set_lines(buf, 0, -1, false, {
					"# OpenCode Scratchpad - <leader><CR> or :w to send | :q to cancel",
					"",
				})

				-- Move cursor to line 2 (after instructions)
				vim.api.nvim_win_set_cursor(win, { 2, 0 })
				vim.cmd("startinsert")

					-- Keymaps for the scratchpad buffer
					local function send_and_close()
						local lines = vim.api.nvim_buf_get_lines(buf, 0, -1, false)
						-- Filter out instruction lines (lines starting with #)
						local content_lines = {}
						for _, line in ipairs(lines) do
							if not line:match("^#") then
								table.insert(content_lines, line)
							end
						end
						local content = table.concat(content_lines, "\n"):gsub("^%s+", ""):gsub("%s+$", "")

						if content ~= "" then
							require("sidekick.cli").send({
								name = "opencode",
								msg = content,
								submit = true,
								focus = false,
							})
						end
						vim.api.nvim_win_close(win, true)
					end

					-- Set up keymaps for sending
					vim.keymap.set("n", "<leader><CR>", send_and_close, { buffer = buf, nowait = true })
					vim.keymap.set("n", "<CR><CR>", send_and_close, { buffer = buf, nowait = true })
					
					-- Override :w to send instead of save
					vim.api.nvim_buf_create_user_command(buf, "W", send_and_close, {})
					vim.api.nvim_create_autocmd("BufWriteCmd", {
						buffer = buf,
						callback = send_and_close,
					})
				end,
				desc = "OpenCode Scratchpad",
				mode = { "n" },
			},

		-- Quick access keymaps
		{
			"<leader>j",
			function()
				-- Scratchpad: open buffer for multi-line input
				local buf = vim.api.nvim_create_buf(false, true)
				vim.api.nvim_buf_set_option(buf, "buftype", "nofile")
				vim.api.nvim_buf_set_option(buf, "bufhidden", "wipe")
				vim.api.nvim_buf_set_option(buf, "filetype", "markdown")

				-- Create bottom split
				vim.cmd("botright split")
				local win = vim.api.nvim_get_current_win()
				vim.api.nvim_win_set_buf(win, buf)
				vim.api.nvim_win_set_height(win, 15)

				-- Add single line instruction at the top
				vim.api.nvim_buf_set_lines(buf, 0, -1, false, {
					"# OpenCode Scratchpad - <leader><CR> or :w to send | :q to cancel",
					"",
				})

				-- Move cursor to line 2 (after instruction)
				vim.api.nvim_win_set_cursor(win, { 2, 0 })
				vim.cmd("startinsert")

				-- Keymaps for the scratchpad buffer
				local function send_and_close()
					local lines = vim.api.nvim_buf_get_lines(buf, 0, -1, false)
					-- Filter out instruction lines (lines starting with #)
					local content_lines = {}
					for _, line in ipairs(lines) do
						if not line:match("^#") then
							table.insert(content_lines, line)
						end
					end
					local content = table.concat(content_lines, "\n"):gsub("^%s+", ""):gsub("%s+$", "")

					if content ~= "" then
						require("sidekick.cli").send({
							name = "opencode",
							msg = content,
							submit = true,
							focus = false,
						})
					end
					vim.api.nvim_win_close(win, true)
				end

				-- Set up keymaps for sending
				vim.keymap.set("n", "<leader><CR>", send_and_close, { buffer = buf, nowait = true })
				vim.keymap.set("n", "<CR><CR>", send_and_close, { buffer = buf, nowait = true })
				
				-- Override :w to send instead of save
				vim.api.nvim_buf_create_user_command(buf, "W", send_and_close, {})
				vim.api.nvim_create_autocmd("BufWriteCmd", {
					buffer = buf,
					callback = send_and_close,
				})
			end,
			desc = "OpenCode Scratchpad",
			mode = { "n" },
		},
		{
			"ga",
			function()
				require("sidekick.cli").send({ name = "opencode", msg = "@this: {this}" })
			end,
			mode = { "n", "x" },
			desc = "Add to OpenCode (context only)",
		},
		{
			"<C-s>",
			function()
				-- Quick scratchpad access (alias to <leader>j)
				local buf = vim.api.nvim_create_buf(false, true)
				vim.api.nvim_buf_set_option(buf, "buftype", "nofile")
				vim.api.nvim_buf_set_option(buf, "bufhidden", "wipe")
				vim.api.nvim_buf_set_option(buf, "filetype", "markdown")

				-- Create bottom split
				vim.cmd("botright split")
				local win = vim.api.nvim_get_current_win()
				vim.api.nvim_win_set_buf(win, buf)
				vim.api.nvim_win_set_height(win, 15)

				-- Add instructions at the top
				vim.api.nvim_buf_set_lines(buf, 0, -1, false, {
					"# OpenCode Scratchpad - <leader><CR> or :w to send | :q to cancel",
					"",
				})

				-- Move cursor to line 2 (after instructions)
				vim.api.nvim_win_set_cursor(win, { 2, 0 })
				vim.cmd("startinsert")

					-- Keymaps for the scratchpad buffer
					local function send_and_close()
						local lines = vim.api.nvim_buf_get_lines(buf, 0, -1, false)
						-- Filter out instruction lines (lines starting with #)
						local content_lines = {}
						for _, line in ipairs(lines) do
							if not line:match("^#") then
								table.insert(content_lines, line)
							end
						end
						local content = table.concat(content_lines, "\n"):gsub("^%s+", ""):gsub("%s+$", "")

						if content ~= "" then
							require("sidekick.cli").send({
								name = "opencode",
								msg = content,
								submit = true,
								focus = false,
							})
						end
						vim.api.nvim_win_close(win, true)
					end

					-- Set up keymaps for sending
					vim.keymap.set("n", "<leader><CR>", send_and_close, { buffer = buf, nowait = true })
					vim.keymap.set("n", "<CR><CR>", send_and_close, { buffer = buf, nowait = true })
					
					-- Override :w to send instead of save
					vim.api.nvim_buf_create_user_command(buf, "W", send_and_close, {})
					vim.api.nvim_create_autocmd("BufWriteCmd", {
						buffer = buf,
						callback = send_and_close,
					})
				end,
				desc = "OpenCode Scratchpad",
				mode = { "n" },
			},

			-- Specific tool toggles
			{
				"<leader>pc",
				function()
					require("sidekick.cli").toggle({ name = "copilot", focus = true })
				end,
				desc = "Toggle Copilot",
			},
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
