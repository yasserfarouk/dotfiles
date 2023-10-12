return {

	-- Git
	{
		"lewis6991/gitsigns.nvim",
		event = "VeryLazy",
		opts = {
			signs = {
				-- TODO add hl to colorscheme
				add = { hl = "GitSignsAdd", text = "▎", numhl = "GitSignsAddNr", linehl = "GitSignsAddLn" },
				change = {
					hl = "GitSignsChange",
					text = "▎",
					numhl = "GitSignsChangeNr",
					linehl = "GitSignsChangeLn",
				},
				delete = {
					hl = "GitSignsDelete",
					text = "契",
					numhl = "GitSignsDeleteNr",
					linehl = "GitSignsDeleteLn",
				},
				topdelete = {
					hl = "GitSignsDelete",
					text = "契",
					numhl = "GitSignsDeleteNr",
					linehl = "GitSignsDeleteLn",
				},
				changedelete = {
					hl = "GitSignsChange",
					text = "▎",
					numhl = "GitSignsChangeNr",
					linehl = "GitSignsChangeLn",
				},
			},
			numhl = false,
			linehl = false,
			-- keymaps = {
			-- 	-- Default keymap options
			-- 	noremap = true,
			-- 	buffer = true,
			-- },
			watch_gitdir = {
				interval = 1000,
			},
			sign_priority = 6,
			update_debounce = 200,
			status_formatter = nil, -- Use default
			-- use_decoration_api = false
		},
	},
	-- {
	--     'sindrets/diffview.nvim',
	--
	--     config = function() require 'git.diffview' end
	-- },

	{
		"tpope/vim-fugitive",
		event = "VeryLazy",
		keys = {
			{ "<leader>ga", "<cmd>Git add .<cr>",                      desc = "add all" },
			{ "<leader>gA", "<cmd>Git add %<cr>",                      desc = "add current" },
			{ "<leader>gb", "<cmd>Git blame<cr>",                      desc = "blame" },
			{ "<leader>gc", "<cmd>Git commit<cr>",                     desc = "commit" },
			{ "<leader>gd", "<cmd>Git diff<cr>",                       desc = "diff" },
			{ "<leader>gg", "<cmd>Git<cr>",                            desc = "status" },
			{ "<leader>gl", "<cmd>Git log<cr>",                        desc = "log" },
			{ "<leader>gp", "<cmd>Git push<cr>",                       desc = "push" },
			{ "<leader>gP", "<cmd>Git pull<cr>",                       desc = "pull" },
			{ "<leader>gD", "<cmd>Gdiffsplit<cr>",                     desc = "diff split" },
			{ "<leader>gG", "<cmd>GGrep<cr>",                          desc = "git grep" },
			{ "<leader>gr", "<cmd>GRemove<cr>",                        desc = "remove" },
			{ "<leader>gi", "<cmd>!git init<cr>",                      desc = "init" },
			{ "<leader>gS", "<cmd>!git status<cr>",                    desc = "status" },
			{ "<leader>gX", "<cmd>!git checkout --conflict=diff3<cr>", desc = "reverse mergetool" },
		},
	},
	{ "tpope/vim-rhubarb", event = "VeryLazy" },
}
