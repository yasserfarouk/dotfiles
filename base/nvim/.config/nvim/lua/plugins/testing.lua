return {
	-- Testing
	"5long/pytest-vim-compiler",
	{
		"janko/vim-test",
		event = "VeryLazy",
		keys = {
			{ "<leader>tn", "<cmd>TestNearest<cr>", desc = "nearest" },
			{ "<leader>tf", "<cmd>TestFile<cr>", desc = "file" },
			{ "<leader>ts", "<cmd>TestSuite<cr>", desc = "suite" },
			{ "<leader>tt", "<cmd>TestSuite --lf -vv<cr>", desc = "failed" },
			{ "<leader>tl", "<cmd>TestLast<cr>", desc = "last" },
			{ "<leader>tg", "<cmd>TestVisit<cr>", desc = "visit" },
			{ "<leader>tv", "<cmd>TestNearest -vv<cr>", desc = "nearest vv" },
		},
	},
	-- {
	-- 	"rcarriga/vim-ultest",
	-- 	event = "VeryLazy",
	-- 	keys = {
	--
	-- 		{ "<leader>tN", "<Plug>(ultest-run-nearest)<cr>", desc = "nearest" },
	-- 		{ "<leader>tF", "<Plug>Ultest<cr>", desc = "file" },
	-- 		{ "<leader>t]", "<Plug>(ultest-next-fail)<cr>", desc = "next failure" },
	-- 		{ "<leader>t[", "<Plug>(ultest-prev-fail)<cr>", desc = "prev failure" },
	-- 		{ "<leader>tS", "<Plug>(ultest-summary-toggle)<cr>", desc = "toggle summary" },
	-- 		{ "<leader>tG", "<Plug>(ultest-summary-jump)<cr>", desc = "goto summary" },
	-- 		{ "<leader>tO", "<Plug>(ultest-output-show)<cr>", desc = "show output" },
	-- 		{ "<leader>tJ", "<Plug>(ultest-output-jump)<cr>", desc = "jump to output" },
	-- 		{ "<leader>tX", "<Plug>(ultest-stop-file)<cr>", desc = "stop file" },
	-- 		{ "<leader>tx", "<Plug>(ultest-stop-nearest)<cr>", desc = "stop nearest" },
	-- 		{ "<leader>ta", "<Plug>(ultest-attach)<cr>", desc = "stop nearest" },
	-- 	},
	-- },
}