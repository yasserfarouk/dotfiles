return {
	"justinmk/vim-sneak",
	"tpope/vim-surround",
	"tpope/vim-unimpaired",
	"tpope/vim-repeat",
	"tpope/vim-dispatch",
	"tpope/vim-abolish",
	-- use {'tpope/vim-capslock',
	"tpope/vim-eunuch",

	-- -- kitty interaction
	-- 'knubie/vim-kitty-navigator',
	-- tumx integration
	{
		"robaire/nvim-tmux-navigator",
		cond = { tmux },
		config = function()
			require("yasser.nav.tmuxconf")
		end,
	},

	-- maps <leader>[, <leader>] to move to top and bottom of indent
	"tmhedberg/indent-motion",
	"moll/vim-bbye",
	-- undo tree
	"mbbill/undotree",

	-- zooms windows out and in using <c-w>m
	"dhruvasagar/vim-zoom",

	-- Explorer
	{
		"kyazdani42/nvim-tree.lua",

		config = function()
			require("yasser.nav.nvimtree")
		end,
	},
}