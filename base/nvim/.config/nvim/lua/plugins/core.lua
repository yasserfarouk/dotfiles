return {
	-- Treesitter
	{
		"nvim-treesitter/nvim-treesitter",
		build = ":TSUpdate",
		opts = {
			ensure_installed = "all",
			ignore_install = { "phpdoc", "swift", "hack", "haskel" },
			highlight = { enable = true },
			playground = { enable = true, updatetime = 50, persist_queries = false },
			indent = { enable = true, disable = { "python", "html", "javascript" } },
			-- indent = {enable = {"javascriptreact"}},
			autotag = { enable = true },
			rainbow = { enable = true },
		},
	},

	{
		"terrortylor/nvim-comment",
		event = "VeryLazy",
		config = function()
			require("nvim_comment").setup()
		end,
	},
	-- text objects
	{ "michaeljsmith/vim-indent-object", event = "VeryLazy" },
	{
		"nvim-treesitter/nvim-treesitter-textobjects",
		event = "VeryLazy",
		config = function()
			require("nvim-treesitter.configs").setup({
				textobjects = {
					select = {
						enable = true,

						-- Automatically jump forward to textobj, similar to targets.vim
						lookahead = true,

						keymaps = {
							-- You can use the capture groups defined in textobjects.scm
							["af"] = "@function.outer",
							["if"] = "@function.inner",
							["am"] = "@function.outer",
							["im"] = "@function.inner",
							["ib"] = "@block.inner",
							["ab"] = "@block.outer",
							["ig"] = "@call.inner",
							["ag"] = "@call.outer",
							["iC"] = "@class.inner",
							["aC"] = "@class.outer",
							["a/"] = "@comment.outer",
							["i/"] = "@comment.outer",
							["ic"] = "@conditional.inner",
							["ac"] = "@conditional.outer",
							["iF"] = "@frame.inner",
							["aF"] = "@frame.outer",
							["il"] = "@loop.inner",
							["al"] = "@loop.outer",
							["ia"] = "@parameter.inner",
							["aa"] = "@parameter.outer",
							["is"] = "@scopename.inner",
							["as"] = "@statement.outer",
						},
					},
					swap = {
						enable = true,
						swap_next = { ["g>"] = "@parameter.inner" },
						swap_previous = { ["g<"] = "@parameter.inner" },
					},
					move = {
						enable = true,
						set_jumps = true, -- whether to set jumps in the jumplist
						goto_next_start = {
							["]m"] = "@function.outer",
							["]]"] = "@class.outer",
						},
						goto_next_end = {
							["]M"] = "@function.outer",
							["]["] = "@class.outer",
						},
						goto_previous_start = {
							["[m"] = "@function.outer",
							["[["] = "@class.outer",
						},
						goto_previous_end = {
							["[M"] = "@function.outer",
							["[]"] = "@class.outer",
						},
					},
					lsp_interop = {
						enable = false,
						border = "none",
						peek_definition_code = {
							["<leader>df"] = "@function.outer",
							["<leader>dF"] = "@class.outer",
						},
					},
				},
			})
		end,
	},
	-- closes autotags using treesitter
	{ "windwp/nvim-ts-autotag", event = "VeryLazy" },
	{ "JoosepAlviste/nvim-ts-context-commentstring", event = "VeryLazy" },
}