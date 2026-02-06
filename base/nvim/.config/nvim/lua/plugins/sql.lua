return {
	-- SQL
	"nanotee/sqls.nvim",
	-- Database client for Neovim (supports MySQL, PostgreSQL, SQLite, etc.)
	{
		"tpope/vim-dadbod",
		cmd = { "DB", "DBUI" },
	},
	{
		"kristijanhusak/vim-dadbod-ui",
		cmd = { "DBUI", "DBUIToggle", "DBUIAddConnection", "DBUIFindBuffer" },
		dependencies = { "tpope/vim-dadbod" },
		keys = {
			{ "<leader>Du", "<cmd>DBUIToggle<cr>", desc = "Toggle DB UI" },
			{ "<leader>Da", "<cmd>DBUIAddConnection<cr>", desc = "Add DB connection" },
			{ "<leader>Df", "<cmd>DBUIFindBuffer<cr>", desc = "Find DB buffer" },
		},
		init = function()
			vim.g.db_ui_use_nerd_fonts = 1
		end,
	},
	{
		"kristijanhusak/vim-dadbod-completion",
		ft = { "sql", "mysql", "plsql" },
		dependencies = { "tpope/vim-dadbod" },
	},
}