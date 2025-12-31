return {
	-- Git diff view and merge tool
	{
		"sindrets/diffview.nvim",
		keys = {
			{ "<leader>gV", "<cmd>DiffviewOpen<cr>", desc = "Diff view" },
		},
	},
	-- Git signs in gutter: added/modified/deleted lines with hunk preview
	{

		"lewis6991/gitsigns.nvim",
		event = "BufReadPre",
		config = function()
			require("gitsigns").setup({
				current_line_blame = true, -- Show blame info at end of line
				current_line_blame_opts = {
					virt_text = true,
					virt_text_pos = "eol", -- 'eol' | 'overlay' | 'right_align'
					delay = 2000, -- 2 seconds delay
					ignore_whitespace = false,
				},
				current_line_blame_formatter = '<author>, <author_time:%Y-%m-%d> - <summary>',
			})
		end,
		keys = {
			{ "<leader>gh", "<cmd>Gitsigns preview_hunk<cr>", desc = "Show Hunk" },
			{ "<leader>gB", "<cmd>Gitsigns toggle_current_line_blame<cr>", desc = "Toggle Line Blame" },
		},
	},
	-- Full-featured Git wrapper for Neovim (:Git commands)
	{
		"tpope/vim-fugitive",
		cmd = {
			"Git",
			"G",
			"Gdiffsplit",
			"Gread",
			"Gwrite",
			"Ggrep",
			"GMove",
			"GDelete",
			"GBrowse",
			"GRemove",
			"GRename",
		},
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
	-- GitHub integration for vim-fugitive (open files in GitHub, etc.)
	{ "tpope/vim-rhubarb", dependencies = { "tpope/vim-fugitive" } },
	-- Visualize and resolve git merge conflicts
	{
		"akinsho/git-conflict.nvim",
		event = "BufReadPre",
		config = function()
			require("git-conflict").setup({
				default_mappings = false,
				disable_diagnostics = true,
			})
		end,
		keys = {
			{ "<leader>gCo", ":GitConflictChooseOurs<cr>", desc = "Choose Ours" },
			{ "<leader>gCt", ":GitConflictChooseTheirs<cr>", desc = "Choose Theirs" },
			{ "<leader>gCb", ":GitConflictChooseBoth<cr>", desc = "Choose Both" },
			{ "<leader>gC0", ":GitConflictChooseNone<cr>", desc = "Choose None" },
			{ "]x", ":GitConflictNextConflict<cr>", desc = "Next Conflict" },
			{ "[x", ":GitConflictPrevConflict<cr>", desc = "Prev Conflict" },
		},
	},
}
