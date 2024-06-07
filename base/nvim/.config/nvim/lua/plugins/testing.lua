return {
	-- Testing
	-- "5long/pytest-vim-compiler",
	{
		"janko/vim-test",
		event = "VeryLazy",
		keys = {
			{ "<leader>tL", "<cmd>TestLast<cr>", desc = "last" },
			{ "<leader>tN", "<cmd>TestNearest<cr>", desc = "nearest" },
			{ "<leader>tF", "<cmd>TestFile<cr>", desc = "file" },
			{ "<leader>ts", "<cmd>TestSuite<cr>", desc = "suite" },
			{ "<leader>tz", "<cmd>TestSuite --lf -vv<cr>", desc = "failed" },
			{ "<leader>tg", "<cmd>TestVisit<cr>", desc = "visit" },
			{ "<leader>tv", "<cmd>TestNearest -vv<cr>", desc = "nearest vv" },
		},
		config = function()
			vim.api.nvim_exec([[ let test#python#runner = 'pytest' ]], true)
		end,
	},
	{
		"nvim-neotest/neotest",
		dependencies = { "nvim-neotest/neotest-python" },
		config = function()
			require("neotest").setup({
				adapters = {
					require("neotest-python"),
				},

				summary = {
					animated = true,
					enabled = true,
					expand_errors = true,
					follow = true,
					mappings = {
						attach = "a",
						clear_marked = "M",
						clear_target = "T",
						debug = "d",
						debug_marked = "D",
						expand = { "<CR>", "<2-LeftMouse>" },
						expand_all = "e",
						jumpto = "i",
						mark = "m",
						next_failed = "J",
						output = "o",
						prev_failed = "K",
						run = "r",
						run_marked = "R",
						short = "O",
						stop = "u",
						target = "t",
						watch = "w",
					},
					open = "botright vsplit | vertical resize 20",
				},
			})
		end,
		keys = {
			{ "<leader>tn", ":lua require'neotest'.run.run()<cr>", desc = "test" },
			{ "<leader>tD", ":lua require'neotest'.run.run({strategy = 'dap'})<cr>", desc = "test" },
			{ "<leader>th", ":lua require'neotest'.run.stop()<cr>", desc = "stop test" },
			{ "<leader>ta", ":lua require'neotest'.run.attach()<cr>", desc = "attach test" },
			{ "<leader>tf", ":lua require'neotest'.run.run(vim.fn.expand('%'))<cr>", desc = "test file" },
			{ "<leader>tt", ":lua require'neotest'.summary.toggle()<cr>", desc = "test summary" },
			{ "<leader>to", ":Neotest output<cr>", desc = "test output" },
			{ "<leader>tO", ":Neotest output-panel<cr>", desc = "test output panel" },
			{ "<leader>t]", ":Neotest jump next<cr>", desc = "next test" },
			{ "<leader>t[", ":Neotest jump prev<cr>", desc = "prev test" },
			{ "<leader>tl", ":lua require'neotest'.run.run_last()<cr>", desc = "rerun last" },
			{ "<leader>tr", ":lua require'neotest'.run.run_last({extra_args='--lf'})<cr>", desc = "rerun last" },
			-- {
			-- 	"<leader>tl",
			-- 	function()
			-- 		local nt = require("neotest")
			-- 		nt.run.run(nt.run.get_last_run())
			-- 		nt.summary.toggle()
			-- 	end,
			-- 	desc = "prev test",
			-- },
		},
	},
}
