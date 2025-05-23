return {
	{
		"zbirenbaum/copilot-cmp",
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
					enabled = false,
					auto_trigger = false,
					hide_during_completion = true,
					debounce = 75,
					trigger_on_accept = true,
					keymap = {
						accept = "<CR>",
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
				copilot_model = "", -- Current LSP default is gpt-35-turbo, supports gpt-4o-copilot
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
		end,
	},
	{
		"CopilotC-Nvim/CopilotChat.nvim",
		dependencies = {
			{
				"zbirenbaum/copilot.lua",
			},
			{ "nvim-lua/plenary.nvim", branch = "master" }, -- for curl, log and async functions
		},
		build = "make tiktoken", -- Only on MacOS or Linux
		opts = {
			-- See Configuration section for options
		},
		-- See Commands section for default commands if you want to lazy load on them
	},
}
