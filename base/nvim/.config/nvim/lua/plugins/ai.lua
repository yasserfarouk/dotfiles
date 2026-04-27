return {
	-- OpenCode.nvim - AI coding assistant integration
	-- Uses Neovim's built-in terminal, works on macOS, Windows, and Linux
	{
		"nickjvandyke/opencode.nvim",
		version = "*", -- Latest stable release
		config = function()
			-- Required for auto-reload when opencode edits files
			vim.o.autoread = true

			-- opencode processes are started manually in a tmux split with `opencode --port`.
			-- opencode.nvim auto-discovers them via pgrep + lsof — no lifecycle management needed.
			---@type opencode.Opts
			vim.g.opencode_opts = {
				server = {
					start = false,
					stop = false,
					toggle = false,
				},
			}

			-- Primary keymaps
			-- <leader>pp connects to a manually-started `opencode --port` tmux split
			vim.keymap.set({ "n", "x" }, "<leader>pp", function()
				require("opencode").ask(nil, { submit = true })
			end, { desc = "Ask OpenCode" })

			vim.keymap.set({ "n", "x" }, "<leader>pa", function()
				require("opencode").ask("@this: ", { submit = true })
			end, { desc = "Ask OpenCode about selection" })

			vim.keymap.set({ "n", "x" }, "<leader>ps", function()
				require("opencode").select()
			end, { desc = "OpenCode actions menu" })

			-- Operator for adding ranges to context
			vim.keymap.set({ "n", "x" }, "go", function()
				return require("opencode").operator("@this ")
			end, { desc = "Add range to OpenCode", expr = true })

			vim.keymap.set("n", "goo", function()
				return require("opencode").operator("@this ") .. "_"
			end, { desc = "Add line to OpenCode", expr = true })

			-- Scroll commands for opencode terminal
			vim.keymap.set("n", "<leader>pu", function()
				require("opencode").command("session.half.page.up")
			end, { desc = "Scroll OpenCode up" })

			vim.keymap.set("n", "<leader>pd", function()
				require("opencode").command("session.half.page.down")
			end, { desc = "Scroll OpenCode down" })

			-- Quick prompts
			vim.keymap.set({ "n", "x" }, "<leader>pe", function()
				require("opencode").prompt("explain")
			end, { desc = "Explain code" })

			vim.keymap.set({ "n", "x" }, "<leader>pr", function()
				require("opencode").prompt("review")
			end, { desc = "Review code" })

			vim.keymap.set({ "n", "x" }, "<leader>pf", function()
				require("opencode").prompt("fix")
			end, { desc = "Fix diagnostics" })

			vim.keymap.set({ "n", "x" }, "<leader>pt", function()
				require("opencode").prompt("test")
			end, { desc = "Generate tests" })

			vim.keymap.set({ "n", "x" }, "<leader>po", function()
				require("opencode").prompt("optimize")
			end, { desc = "Optimize code" })

			vim.keymap.set({ "n", "x" }, "<leader>pi", function()
				require("opencode").prompt("implement")
			end, { desc = "Implement code" })

			vim.keymap.set({ "n", "x" }, "<leader>pc", function()
				require("opencode").prompt("document")
			end, { desc = "Add comments/docs" })

			-- Session management
			vim.keymap.set("n", "<leader>pn", function()
				require("opencode").command("session.new")
			end, { desc = "New OpenCode session" })

			vim.keymap.set("n", "<leader>pl", function()
				require("opencode").command("session.list")
			end, { desc = "List OpenCode sessions" })

			-- Scratchpad: open a buffer for multi-line prompt input
			vim.keymap.set("n", "<leader>pj", function()
				local buf = vim.api.nvim_create_buf(false, true)
				vim.api.nvim_set_option_value("buftype", "nofile", { buf = buf })
				vim.api.nvim_set_option_value("bufhidden", "wipe", { buf = buf })
				vim.api.nvim_set_option_value("filetype", "markdown", { buf = buf })

				-- Create bottom split
				vim.cmd("botright split")
				local win = vim.api.nvim_get_current_win()
				vim.api.nvim_win_set_buf(win, buf)
				vim.api.nvim_win_set_height(win, 15)

				-- Add instructions
				vim.api.nvim_buf_set_lines(buf, 0, -1, false, {
					"# OpenCode Scratchpad - <leader><CR> or :w to send | :q to cancel",
					"",
				})

				-- Move cursor to line 2 and start insert
				vim.api.nvim_win_set_cursor(win, { 2, 0 })
				vim.cmd("startinsert")

				-- Send function
				local function send_and_close()
					local lines = vim.api.nvim_buf_get_lines(buf, 0, -1, false)
					local content_lines = {}
					for _, line in ipairs(lines) do
						if not line:match("^#") then
							table.insert(content_lines, line)
						end
					end
					local content = table.concat(content_lines, "\n"):gsub("^%s+", ""):gsub("%s+$", "")

					if content ~= "" then
						require("opencode").ask(content, { submit = true })
					end
					vim.api.nvim_win_close(win, true)
				end

				-- Keymaps for sending
				vim.keymap.set("n", "<leader><CR>", send_and_close, { buffer = buf, nowait = true })
				vim.keymap.set("n", "<CR><CR>", send_and_close, { buffer = buf, nowait = true })

				-- Override :w to send
				vim.api.nvim_buf_create_user_command(buf, "W", send_and_close, {})
				vim.api.nvim_create_autocmd("BufWriteCmd", {
					buffer = buf,
					callback = send_and_close,
				})
			end, { desc = "OpenCode Scratchpad" })

			-- Quick access alias
			vim.keymap.set("n", "<leader>j", function()
				vim.cmd("normal! \\<leader>pj")
			end, { desc = "OpenCode Scratchpad", remap = true })
		end,
	},

	-- Sidekick: unified AI CLI terminal (claude, opencode, copilot cli, etc.)
	-- Also provides Copilot NES (Next Edit Suggestions) — disabled until LSP setup is confirmed
	{
		"folke/sidekick.nvim",
		dependencies = { "folke/snacks.nvim" },
		opts = function()
			local platform = require("yasser.utils.platform")
			local use_tmux = not platform.is_windows and os.getenv("TMUX") ~= nil

			return {
				-- NES requires vim.lsp.enable("copilot") which may conflict with copilot.lua.
				-- Enable once confirmed compatible: https://github.com/folke/sidekick.nvim#-next-edit-suggestions-nes
				nes = { enabled = false },
				cli = {
					win = {
						layout = "right",
						split = { width = 88 },
					},
					mux = {
						backend = "tmux",
						-- Use tmux splits on macOS/Linux when inside a tmux session;
						-- fall back to Neovim terminal on Windows or outside tmux.
						enabled = use_tmux,
						create = "split",
						split = {
							vertical = true,
							size = 0.4,
						},
					},
				},
			}
		end,
		keys = {
			-- Tool management
			{ "<leader>ac", function() require("sidekick.cli").toggle({ name = "claude",   focus = true }) end,                     desc = "Toggle Claude Code" },
			{ "<leader>ao", function() require("sidekick.cli").toggle({ name = "opencode", focus = true }) end,                     desc = "Toggle OpenCode (sidekick)" },
			{ "<leader>aa", function() require("sidekick.cli").toggle() end,                                                         desc = "Toggle last AI CLI" },
			{ "<leader>aA", function() require("sidekick.cli").select() end,                                                         desc = "Select AI CLI tool" },
			{ "<leader>ad", function() require("sidekick.cli").close() end,                                                          desc = "Detach AI CLI session" },
			{ "<c-.>",      function() require("sidekick.cli").focus() end,                              mode = { "n", "t", "i", "x" }, desc = "Focus AI CLI" },

			-- Context senders — append to CLI input without submitting (build up context first)
			{ "<leader>at", function() require("sidekick.cli").send({ msg = "{this}" })      end, mode = { "n", "x" }, desc = "AI: send this (context)" },
			{ "<leader>af", function() require("sidekick.cli").send({ msg = "{file}" })      end,                      desc = "AI: send file (context)" },
			{ "<leader>av", function() require("sidekick.cli").send({ msg = "{selection}" }) end, mode = "x",          desc = "AI: send selection (context)" },

			-- Prompt library — pick a prompt and auto-submit
			-- submit=true sends tmux Enter / nvim terminal \r after the message
			{ "<leader>aP", function()
				require("sidekick.cli").prompt({
					cb = function(_, text)
						if text then
							require("sidekick.cli").send({ text = text, submit = true })
						end
					end,
				})
			end, mode = { "n", "x" }, desc = "AI: prompt library (auto-submit)" },

			-- Free-text ask — vim.ui.input (snacks) → active CLI → auto-submit
			{ "<leader>aq", function()
				vim.ui.input({ prompt = "Ask AI: " }, function(input)
					if input and input ~= "" then
						require("sidekick.cli").send({ msg = input, submit = true })
					end
				end)
			end, desc = "AI: ask (free input)" },

			-- Quick action prompts — send + auto-submit immediately
			{ "<leader>ae", function() require("sidekick.cli").send({ msg = "Explain {this}",                                        submit = true }) end, mode = { "n", "x" }, desc = "AI: explain" },
			{ "<leader>aR", function() require("sidekick.cli").send({ msg = "Review {file} for any issues or improvements",          submit = true }) end,                      desc = "AI: review file" },
			{ "<leader>aX", function() require("sidekick.cli").send({ msg = "Fix the diagnostics in {file}\n{diagnostics}",          submit = true }) end,                      desc = "AI: fix diagnostics" },
			{ "<leader>aT", function() require("sidekick.cli").send({ msg = "Write tests for {this}",                                submit = true }) end, mode = { "n", "x" }, desc = "AI: write tests" },
			{ "<leader>ai", function() require("sidekick.cli").send({ msg = "Implement {this}",                                      submit = true }) end, mode = { "n", "x" }, desc = "AI: implement" },
			{ "<leader>aO", function() require("sidekick.cli").send({ msg = "Optimize {this} for performance and readability",       submit = true }) end, mode = { "n", "x" }, desc = "AI: optimize" },
			{ "<leader>aG", function() require("sidekick.cli").send({ msg = "Add documentation comments to {this}",                 submit = true }) end, mode = { "n", "x" }, desc = "AI: document" },
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
				workspace_folders = { require("yasser.utils.platform").code_dir() },
				copilot_model = "gpt-41-copilot",
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

	-- Ollama local-model integration
	{
		"nomnivore/ollama.nvim",
		dependencies = { "nvim-lua/plenary.nvim" },
		cmd = { "Ollama", "OllamaModel", "OllamaServe", "OllamaServeStop" },
		keys = {
			{ "<localleader>oo", ":<c-u>lua require('ollama').prompt()<cr>",                desc = "Ollama prompt",        mode = { "n", "v" } },
			{ "<localleader>og", ":<c-u>lua require('ollama').prompt('Generate_Code')<cr>", desc = "Ollama generate code", mode = { "n", "v" } },
			{ "<localleader>om", "<cmd>OllamaModel<cr>",                                    desc = "Ollama pick model",    mode = "n" },
			{ "<localleader>os", "<cmd>OllamaServe<cr>",                                    desc = "Ollama serve",         mode = "n" },
			{ "<localleader>oS", "<cmd>OllamaServeStop<cr>",                                desc = "Ollama serve stop",    mode = "n" },
		},
		opts = {
			model = "deepseek-coder-v2:16b",
			url = "http://127.0.0.1:11434",
		},
	},
}
