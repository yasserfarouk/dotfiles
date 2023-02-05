return {
	-- Markdown
	"tpope/vim-markdown",
	{
		"iamcco/markdown-preview.nvim",

		ft = "markdown",
		build = "cd app & yarn install",
	},
}