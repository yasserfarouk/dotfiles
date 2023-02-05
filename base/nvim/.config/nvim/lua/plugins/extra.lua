return {
	-- use gF to go to file:line:col
	"wsdjeg/vim-fetch",

	-- CDing into the project root always
	"airblade/vim-rooter",

	-- keeping copy histor
	{
		"AckslD/nvim-neoclip.lua",
		dependencies = {
			-- you'll need at least one of these
			{'nvim-telescope/telescope.nvim'},
			{'ibhagwan/fzf-lua'},
		},
		config = function()
			require("neoclip").setup()
		end,
	},

}