return {
	-- Treesitter
	{
		"nvim-treesitter/nvim-treesitter",
		build = ":TSUpdate",
	opts = {
    ensure_installed = "all",
	ignore_install = { "phpdoc", "swift", "hack", "haskel" },
    highlight = { enable = true },
    playground = {enable = true, updatetime = 50, persist_queries = false},
	indent = {enable = true, disable = {"python", "html", "javascript"}},
    -- indent = {enable = {"javascriptreact"}},
    autotag = {enable = true},
    rainbow = {enable = true}
}
	},

	{
		"terrortylor/nvim-comment",

		config = function()
			require("nvim_comment").setup()
		end,
	},
	-- text objects
	-- 'kana/vim-textobj-user',
	-- 'rhysd/vim-textobj-anyblock',
	-- 'kana/vim-textobj-line',
	"michaeljsmith/vim-indent-object",
	{
		"nvim-treesitter/nvim-treesitter-textobjects",

		config = function()
			require("yasser.nav.treesitter_textobjects")
		end,
	},
	-- use { 'wellle/targets.vim' }
	-- { 'chaoren/vim-wordmotion' }


	-- closes autotags using treesitter
	"windwp/nvim-ts-autotag",

	"JoosepAlviste/nvim-ts-context-commentstring",
	-- use {"kevinhwang91/nvim-bqf",
}
