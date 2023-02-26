return {
	-- search/replace in multiple files
	{
		"windwp/nvim-spectre",
		keys = {
			{
				"<leader>rs",
				function()
					require("spectre").open()
				end,
				desc = "Replace in files (Spectre) - No Undo",
			},
			{
				"<leader>r",
				function()
					require("spectre").open()
				end,
				mode = { "v" },
				desc = "Replace current selection",
			},
			{
				"<leader>rw",
				function()
					require("spectre").open()
				end,
				mode = { "n" },
				desc = "Replace current word",
			},
		},
		config = true,
	},
}
