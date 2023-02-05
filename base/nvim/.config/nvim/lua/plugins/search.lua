return {

	-- Telescope
	"nvim-lua/popup.nvim",
	"nvim-lua/plenary.nvim",
	{
		"nvim-telescope/telescope.nvim",
		tag = "0.1.0",
		dependencies = { "nvim-lua/plenary.nvim" },
		config = function()
			require("yasser.search.telescope")
		end,
	},
	{
		"nvim-telescope/telescope-symbols.nvim",
		dependencies = { "nvim-telescope/telescope.nvim" },
	},
	{
		"nvim-telescope/telescope-fzy-native.nvim",
		dependencies = { "nvim-telescope/telescope.nvim" },
		config = function()
			require("telescope").load_extension("fzy_native")
		end,
	},
	{
		"nvim-telescope/telescope-project.nvim",
		dependencies = { "nvim-telescope/telescope.nvim" },
		lazy = true,
		event = VeryLazy,
		config = function()
			require("telescope").load_extension("project")
		end,
	},
	"tom-anders/telescope-vim-bookmarks.nvim",
	"nvim-telescope/telescope-media-files.nvim",
	"nvim-telescope/telescope-ui-select.nvim",
	"nvim-telescope/telescope-file-browser.nvim",
	{
		"ahmedkhalf/project.nvim",
		config = function()
			require("yasser.search.projects")
		end,
	},
	-- {
	--     "nvim-telescope/telescope-project.nvim",
	--     event = "BufRead",
	--     setup = function() vim.cmd [[packadd telescope.nvim]] end
	-- },
	-- FZF
	{
		"ibhagwan/fzf-lua",
		config = function()
			require("yasser.search.fzflua")
		end,
	},

	-- changes the highlghting of the current match
	"PeterRincker/vim-searchlight",

	-- Extra search and replace
	"dyng/ctrlsf.vim",
	-- search and replace in multipole files
	"brooth/far.vim",

}