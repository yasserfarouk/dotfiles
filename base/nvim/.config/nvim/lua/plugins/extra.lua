return {
	-- use gF to go to file:line:col
	{ "wsdjeg/vim-fetch", event = "VeryLazy" },

	-- CDing into the project root always
	{ "airblade/vim-rooter", event = "VeryLazy" },

	-- keeping copy histor
	{
		"AckslD/nvim-neoclip.lua",
		dependencies = {
			"nvim-telescope/telescope.nvim",
			"ibhagwan/fzf-lua",
		},
		config = function()
			require("neoclip").setup()
		end,
	},
}