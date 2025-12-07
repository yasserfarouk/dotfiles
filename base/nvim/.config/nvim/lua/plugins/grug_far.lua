return {
	-- Modern search and replace across multiple files with live preview
	"MagicDuck/grug-far.nvim",
	cmd = "GrugFar",
	keys = {
		{
			"<leader>rr",
			function()
				require("grug-far").open()
			end,
			desc = "Search and Replace",
		},
		{
			"<leader>rw",
			function()
				require("grug-far").open({ prefills = { search = vim.fn.expand("<cword>") } })
			end,
			desc = "Replace current word",
		},
		{
			"<leader>r",
			function()
				require("grug-far").with_visual_selection({ prefills = { paths = vim.fn.expand("%") } })
			end,
			mode = "v",
			desc = "Replace selection",
		},
	},
	config = function()
		require("grug-far").setup({
			-- Minimal config, uses sensible defaults
		})
	end,
}
