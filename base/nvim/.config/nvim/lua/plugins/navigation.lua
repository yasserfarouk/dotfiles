return {
	{ "wsdjeg/vim-fetch" },
	-- "justinmk/vim-sneak",
	{ "tpope/vim-surround" },
	-- useful pair like ]b
	{ "tpope/vim-unimpaired" },
	{ "tpope/vim-repeat" },
	{ "tpope/vim-dispatch", cmd = { "Dispatch", "Make", "Focus", "Start" } },
	-- Enables S for substituting singular and plural (etc), and adds cr[st .-ucm] for turning to snake, title, space, dot, dash, upper, camel, and mixed cases
	{ "tpope/vim-abolish" },
	-- use {'tpope/vim-capslock',
	-- file operations like Move
	{ "tpope/vim-eunuch", cmd = { "Delete", "Unlink", "Move", "Rename", "Chmod", "Mkdir", "Cfind", "Clocate", "Lfind", "Wall", "SudoWrite", "SudoEdit" } },

	-- -- kitty interaction
	-- 'knubie/vim-kitty-navigator',
	-- tumx integration
	{
		"alexghergh/nvim-tmux-navigation",
		config = function()
			require("nvim-tmux-navigation").setup({
				disable_when_zoomed = true, -- defaults to false
				keybindings = {
					left = "<C-h>",
					down = "<C-j>",
					up = "<C-k>",
					right = "<C-l>",
					last_active = "<C-\\>",
					next = "<C-Space>",
				},
			})
		end,
	},
	-- maps <leader>[, <leader>] to move to top and bottom of indent
	{ "tmhedberg/indent-motion" },
	{ "moll/vim-bbye", cmd = { "Bdelete", "Bwipeout" } },

	-- zooms windows out and in using <c-w>m
	{ "dhruvasagar/vim-zoom" },
}
