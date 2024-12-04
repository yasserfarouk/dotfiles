return {
	{ "wsdjeg/vim-fetch" },
	-- "justinmk/vim-sneak",
	{ "tpope/vim-surround", event = "VeryLazy" },
	-- useful pair like ]b
	{ "tpope/vim-unimpaired", event = "VeryLazy" },
	{ "tpope/vim-repeat", event = "VeryLazy" },
	{ "tpope/vim-dispatch", event = "VeryLazy" },
	-- Enables S for substituting singular and plural (etc), and adds cr[st .-ucm] for turning to snake, title, space, dot, dash, upper, camel, and mixed cases
	{ "tpope/vim-abolish", event = "VeryLazy" },
	-- use {'tpope/vim-capslock',
	-- file operations like Move
	{ "tpope/vim-eunuch", event = "VeryLazy" },

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
	{ "tmhedberg/indent-motion", event = "VeryLazy" },
	{ "moll/vim-bbye", event = "VeryLazy" },

	-- zooms windows out and in using <c-w>m
	{ "dhruvasagar/vim-zoom", event = "VeryLazy" },
}
