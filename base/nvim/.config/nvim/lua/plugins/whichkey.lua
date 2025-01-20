return {

	-- Which Key
	{
		"folke/which-key.nvim",
		config = function()
			local wk = require("which-key")

			wk.setup({})
			wk.add({
				{ "<leader>F", group = "fold" },
				{ "<leader>T", group = "table" },
				{ "<leader>a", group = "actions" },
				{ "<leader>b", group = "buffer" },
				{ "<leader>c", group = "lsp" },
				{ "<leader>d", group = "debug" },
				{ "<leader>g", group = "git" },
				{ "<leader>i", group = "trouble" },
				{ "<leader>l", group = "LateX" },
				{ "<leader>m", group = "markdown" },
				{ "<leader>s", group = "search" },
				{ "<leader>t", group = "test" },
				{ "<leader>v", group = "view" },
				{ "<leader>x", group = "terminal" },
				{ "<leader>S", group = "FzfLua" },
			})
		end,
	},
}
