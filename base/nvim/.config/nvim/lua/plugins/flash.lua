return {
	-- Fast navigation with enhanced search labels (like easymotion/hop)
	"folke/flash.nvim",
	opts = {
		modes = {
			search = {
				enabled = false,
			},
		},
	},
	keys = {
		{
			"s",
			mode = { "n", "x", "o" },
			function()
				require("flash").jump()
			end,
		},
		{
			"S",
			mode = { "o", "x" },
			function()
				require("flash").treesitter()
			end,
		},
	},
}
