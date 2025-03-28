return {
	-- tex
	{
		"lervag/vimtex",
		ft = { "tex", "latex", "bib" },
		keys = {
			-- { "<F9>", "<cmd>VimtexCompile<cr>", mode = { "n" }, desc = "Auto Compile" },
			-- { "<F5>", "<cmd>VimtexView<cr>", mode = { "n" }, desc = "Auto Compile" },
			{ "<leader>lv", "<cmd>VimtexView<cr>", mode = { "n" }, desc = "View" },
			{ "<leader>lc", "<cmd>VimtexCompile<cr>", mode = { "n" }, desc = "Auto Compile" },
			{ "<leader>lS", "<cmd>VimtexStop<cr>", mode = { "n" }, desc = "Stop" },
			{ "<leader>lx", "<cmd>VimtexCompileSelected<cr>", mode = { "n" }, desc = "CompileSelected" },
			{ "<leader>lX", "<cmd>VimtexStopAll<cr>", mode = { "n" }, desc = "StopAll" },
			{ "<leader>lC", "<cmd>VimtexCompileSS<cr>", mode = { "n" }, desc = "Compile once" },
			{ "<leader>ln", "<cmd>VimtexClean<cr>", mode = { "n" }, desc = "Clean" },
			{ "<leader>lm", "<cmd>VimtexContextMenu<cr>", mode = { "n" }, desc = "ContextMenu" },
			{ "<leader>lo", "<cmd>VimtexCompileOutput<cr>", mode = { "n" }, desc = "CompileOutput" },
			{ "<leader>ls", "<cmd>VimtexStatus<cr>", mode = { "n" }, desc = "Status" },
			{ "<leader>lt", "<cmd>VimtexTocToggle<cr>", mode = { "n" }, desc = "TocToggle" },
			{ "<leader>lr", "<cmd>VimtexReload<cr>", mode = { "n" }, desc = "Reload" },
			{ "<leader>lR", "<cmd>VimtexReloadState<cr>", mode = { "n" }, desc = "ReloadState" },
			{ "<leader>lL", "<cmd>VimtexCountLetters<cr>", mode = { "n" }, desc = "CountLetters" },
			{ "<leader>lW", "<cmd>VimtexCountWords<cr>", mode = { "n" }, desc = "CountWords" },
			{ "<leader>ll", "<cmd>VimtexLog<cr>", mode = { "n" }, desc = "Log" },
			{ "<leader>li", "<cmd>VimtexInfo<cr>", mode = { "n" }, desc = "Info" },
			{ "<leader>lp", "<cmd>VimtexDocPackage<cr>", mode = { "n" }, desc = "DocPackage" },
			{ "<leader>lP", "<cmd>call PresentWithPympress()<cr>", mode = { "n" }, desc = "Present" },
		},
		config = function()
			vim.cmd("source ~/.config/nvim/vimscript/tex.vim")
		end,
	},
}
