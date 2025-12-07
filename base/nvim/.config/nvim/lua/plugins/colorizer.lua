return {
	{
		"norcalli/nvim-colorizer.lua",
		ft = { "css", "scss", "html", "javascript", "typescript", "javascriptreact", "typescriptreact", "vue", "svelte" },
		config = function()
			require("colorizer").setup({
				"css",
				"scss",
				"html",
				"javascript",
				"typescript",
				"javascriptreact",
				"typescriptreact",
				"vue",
				"svelte",
			})
		end,
	},
}
