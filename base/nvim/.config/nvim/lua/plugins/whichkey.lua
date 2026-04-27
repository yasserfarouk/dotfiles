return {

	-- Show available keybindings in a popup as you type
	{
		"folke/which-key.nvim",
		config = function()
			local wk = require("which-key")

			wk.setup({ win = { height = { min = 4, max = 30 } } })
			wk.add({
				{ "<leader>F", group = "fold" },
				{ "<leader>L", group = "Lazy" },
				{ "<leader>T", group = "table" },
				{ "<leader>a", group = "AI" },
				{ "<leader>b", group = "buffer" },
				{ "<leader>c", group = "lsp" },
				{ "<leader>d", group = "debug" },
				{ "<leader>g", group = "git" },
				{ "<leader>i", group = "trouble" },
				{ "<leader>l", group = "LateX" },
				{ "<leader>m", group = "markdown" },
				{ "<leader>p", group = "OpenCode" },
				{ "<leader>s", group = "search" },
				{ "<leader>t", group = "test" },
				{ "<leader>v", group = "view" },
				{ "<leader>x", group = "terminal" },
				{ "<leader>S", group = "FzfLua" },
				{ "<localleader>o", group = "ollama" },
			})
		end,
	},
}
