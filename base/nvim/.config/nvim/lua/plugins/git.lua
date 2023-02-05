return {

	-- Git
	{
		"lewis6991/gitsigns.nvim",

		config = function()
			require("yasser.git.gitsigns")
		end,
	},
	-- {
	--     'sindrets/diffview.nvim',
	--
	--     config = function() require 'git.diffview' end
	-- },

	"tpope/vim-fugitive",
	"tpope/vim-rhubarb",
}