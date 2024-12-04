return {

	-- Which Key
	{
		"folke/which-key.nvim",
		config = function()
			local wk = require("which-key")

			wk.setup({})
			wk.register({

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
				-- y = {
				-- 	name = "+RIPPLE",
				-- 	o = { "<Plug>(ripple-openRepl)<cr>", "open REPL" },
				-- 	y = { "<Plug>(ripple-send-motion)<cr>", "send motion" },
				-- 	l = { "<Plug>(ripple-send-line)<cr>", "send motion" },
				-- 	b = { "<Plug>(ripple-send-buffer)<cr>", "send motion" },
				-- 	p = { "<Plug>(ripple-send-previous)<cr>", "send last" },
				-- },

				-- j = {
				-- 	name = "+jupyter",
				--
				-- 	s = { "<cmd>call StartPyShell()<cr>", "start" },
				-- 	S = { "<cmd>call StopPyShell()<cr>", "stop" },
				-- 	l = { "<cmd>call PyShellSendLine()<cr>", "line" },
				-- 	c = { "<cmd>call RunTmuxPythonCell()<cr>", "cell" },
				-- 	a = { "<cmd>call RunTmuxPythonAllCellsAbove()<cr>", "cell" },
				-- 	b = { "<cmd>call RunTmuxPythonAllCellsBelow()<cr>", "cell" },
				-- },
				-- S = {
				-- 	name = "+Session",
				-- 	s = { ":SessionSave", "save session" },
				-- 	l = { "<cmd>SessionLoad<cr>", "load Session" },
				-- },
			}, { prefix = "<leader>" })
		end,
	},
}
