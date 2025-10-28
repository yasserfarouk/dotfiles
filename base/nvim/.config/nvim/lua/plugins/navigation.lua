return {
	{ "wsdjeg/vim-fetch" },
	-- "justinmk/vim-sneak",
	{ "tpope/vim-surround", event = "BufReadPost" },
	-- useful pair like ]b
	{ "tpope/vim-unimpaired", event = "BufReadPost" },
	{ "tpope/vim-repeat", event = "BufReadPost" },
	{ "tpope/vim-dispatch", cmd = { "Dispatch", "Make", "Focus", "Start" } },
	-- Enables S for substituting singular and plural (etc), and adds cr[st .-ucm] for turning to snake, title, space, dot, dash, upper, camel, and mixed cases
	{ "tpope/vim-abolish", event = "BufReadPost" },
	-- use {'tpope/vim-capslock',
	-- file operations like Move
	{ "tpope/vim-eunuch", cmd = { "Delete", "Unlink", "Move", "Rename", "Chmod", "Mkdir", "Cfind", "Clocate", "Lfind", "Wall", "SudoWrite", "SudoEdit" } },

	-- -- kitty interaction
	-- 'knubie/vim-kitty-navigator',
	-- tumx integration
	{
		"alexghergh/nvim-tmux-navigation",
		event = "VeryLazy",
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
	{ "tmhedberg/indent-motion", event = "BufReadPost" },
	{ "moll/vim-bbye", cmd = { "Bdelete", "Bwipeout" } },

	-- zooms windows out and in using <c-w>m
	{ "dhruvasagar/vim-zoom", event = "BufReadPost" },
}
