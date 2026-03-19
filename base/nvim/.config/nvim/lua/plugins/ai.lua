return {
	-- OpenCode.nvim - AI coding assistant integration
	-- Uses Neovim's built-in terminal, works on macOS, Windows, and Linux
	{
		"nickjvandyke/opencode.nvim",
		version = "*", -- Latest stable release
		config = function()
			---@type opencode.Opts
			vim.g.opencode_opts = {
				-- Use default configuration - see :checkhealth opencode for status
			}

			-- Required for auto-reload when opencode edits files
			vim.o.autoread = true

			-- Primary keymaps
			vim.keymap.set({ "n", "x" }, "<leader>pp", function()
				require("opencode").toggle()
			end, { desc = "Toggle OpenCode" })

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
}
