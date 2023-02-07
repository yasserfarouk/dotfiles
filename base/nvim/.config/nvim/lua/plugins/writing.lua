return {
	-- grammer check
	{
		"rhysd/vim-grammarous",
		cmd = { "GrammarousCheck", "GrammarousReset" },
	},
	-- better spell checking (ignoring keywords)
	{
		"lewis6991/spellsitter.nvim",
		config = function()
			require("spellsitter").setup()
		end,
	},
	-- Tables
	"godlygeek/tabular",
	"dhruvasagar/vim-table-mode",

	{
		"ntpeters/vim-better-whitespace",

		config = function()
			vim.g.better_whitespace_filetypes_blacklist = {
				"dashboard",
				"ALPHA",
				"diff",
				"gitcommit",
				"unite",
				"nvimtree",
				"qf",
				"help",
			}
		end,
	},
}
