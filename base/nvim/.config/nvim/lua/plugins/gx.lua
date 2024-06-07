return {
	"chrishrb/gx.nvim",
	event = { "BufEnter" },
	dependencies = { "nvim-lua/plenary.nvim" },
	opts = {
		handler_options = {
			search_engine = "duckduckgo",
		},
	},
}
