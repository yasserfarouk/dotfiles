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
			{ "<leader>sk", "<cmd>Legendary<cr>", desc = "keymaps/commands" },
		},
		opts = {
			extensions = {
				which_key = { auto_register = true },
				lazy_nvim = { auto_register = true },
			},
		},
	},
}
