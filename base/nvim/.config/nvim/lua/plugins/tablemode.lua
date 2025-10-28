return {
	{
		"dhruvasagar/vim-table-mode",
		config = function()
			vim.g.table_mode_map_prefix = "<Leader>T"
			vim.g.table_mode_disable_tableize_mappings = 0
			vim.g.table_mode_tableize_auto_border = 0
			vim.g.table_mode_tableize_d_map = "<Leader>TT"
			vim.g.table_mode_delimiter = "|"
		end,
		keys = {
			-- { "<leader>Tm", "<cmd>TableModeToggle<cr>", desc = "toggle" },
			-- { "<leader>Te", "<cmd>TableModeEnable<cr>", desc = "enable" },
			-- { "<leader>Td", "<cmd>TableModeDisable<cr>", desc = "disable" },
			-- { "<leader>Tr", "<cmd>TableModeRealign<cr>", desc = "align" },
			-- { "<leader>Ta", "<cmd>TableModeRealign<cr>", desc = "align" },
			{ "<leader>TT", "<cmd><Plug>(table-mode-tabelize)<cr>", desc = "make table" },
			{
				"<leader>T|",
				function()
					vim.g.table_mode_delimiter = "|"
				end,
				desc = "Delimiter |",
			},
			{
				"<leader>T7",
				function()
					vim.g.table_mode_delimiter = ","
				end,
				desc = "Delimiter &",
			},
			{
				"<leader>T&",
				function()
					vim.g.table_mode_delimiter = ","
				end,
				desc = "Delimiter &",
			},
			{
				"<leader>T,",
				function()
					vim.g.table_mode_delimiter = ","
				end,
				desc = "Delimiter ,",
			},
		},
	},
}
