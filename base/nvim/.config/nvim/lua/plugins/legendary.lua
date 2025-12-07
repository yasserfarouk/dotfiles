return {
	{
		"mrjones2014/legendary.nvim",
		dependencies = {
			"stevearc/dressing.nvim",
			"nvim-telescope/telescope.nvim",
			"kkharji/sqlite.lua",
			"folke/which-key.nvim",
		},
		keys = {
			{ "<C-S-p>", "<cmd>Legendary<cr>", desc = "Legendary" },
			{ "<leader>sL", "<cmd>Legendary<cr>", desc = "Legendary" },
		},
		opts = {
			which_key = { auto_register = true },
		},
	},
}
