return {

	-- Which Key
	{
		"folke/which-key.nvim",
		config = function()
			local wk = require("which-key")

			wk.setup({})
			wk.register({
				m = { name = "+markdown" },
				b = { name = "+buffer" },
				d = { name = "+debug" },
				F = { name = "+fold" },
				s = { name = "+search" },
				i = { name = "+trouble" },
				v = { name = "+view" },
				T = { name = "+table" },
				x = { name = "+terminal" },
				t = { name = "+test" },
				l = { name = "+LateX" },
				a = { name = "+actions" },
				g = { name = "+git" },
				c = { name = "+lsp" },
				z = { name = "+FzfLua" },
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