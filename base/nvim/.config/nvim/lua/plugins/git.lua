return {

	-- Git
	{
		"lewis6991/gitsigns.nvim",
		event = "VeryLazy",
		config = function()
			require("gitsigns").setup()
		end,
		keys = {
			{ "<leader>gh", "<cmd>Gitsigns preview_hunk<cr>", desc = "Show Hunk" },
			{ "<leader>gB", "<cmd>Gitsigns toggle_current_lint_blame<cr>", desc = "Line Blame" },
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
			{ "<leader>ga", "<cmd>Git add .<cr>", desc = "add all" },
			{ "<leader>gA", "<cmd>Git add %<cr>", desc = "add current" },
			{ "<leader>gb", "<cmd>Git blame<cr>", desc = "blame" },
			{ "<leader>gc", "<cmd>Git commit<cr>", desc = "commit" },
			{ "<leader>gd", "<cmd>Git diff<cr>", desc = "diff" },
			{ "<leader>gg", "<cmd>Git<cr>", desc = "status" },
			{ "<leader>gl", "<cmd>Git log<cr>", desc = "log" },
			{ "<leader>gp", "<cmd>Git push<cr>", desc = "push" },
			{ "<leader>gP", "<cmd>Git pull<cr>", desc = "pull" },
			{ "<leader>gD", "<cmd>Gdiffsplit<cr>", desc = "diff split" },
			{ "<leader>gG", "<cmd>GGrep<cr>", desc = "git grep" },
			{ "<leader>gr", "<cmd>GRemove<cr>", desc = "remove" },
			{ "<leader>gi", "<cmd>!git init<cr>", desc = "init" },
			{ "<leader>gS", "<cmd>!git status<cr>", desc = "status" },
			{ "<leader>gX", "<cmd>!git checkout --conflict=diff3<cr>", desc = "reverse mergetool" },
		},
	},
	{ "tpope/vim-rhubarb", event = "VeryLazy" },
	{
		"akinsho/git-conflict.nvim",
		init = function()
			require("git-conflict").setup({
				default_mappings = false,
				disable_diagnostics = true,
			})
		end,
		keys = {
			{ "<leader>gCo", ":GitConflictChooseOurs<cr>" },
			{ "<leader>gCt", ":GitConflictChooseTheirs<cr>" },
			{ "<leader>gCb", ":GitConflictChooseBoth<cr>" },
			{ "<leader>gC0", ":GitConflictChooseNone<cr>" },
			{ "]x", ":GitConflictNextConflict<cr>" },
			{ "[x", ":GitConflictPrevConflict<cr>" },
		},
	},
	{
		"f-person/git-blame.nvim",
		init = function()
			require("gitblame").setup({
				enabled = false,
			})
			vim.g.gitblame_display_virtual_text = 1
			-- vim.g.gitblame_enabled = 0
		end,
	},
}
