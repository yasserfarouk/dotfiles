return {
	-- Treesitter
	{
		"nvim-treesitter/nvim-treesitter",
		event = { "BufReadPost", "BufNewFile" },
		build = ":TSUpdate",
		opts = {
			ensure_installed = { "cpp", "python", "lua", "java", "javascript", "php", "latex" },
			sync_install = false,
			ignore_install = { "phpdoc", "swift", "hack", "haskel" },
			highlight = { enable = true },
			playground = {
				enable = true,
				updatetime = 50,
				persist_queries = false,
				additional_vim_regex_highlighting = true,
			},
			indent = { enable = true, disable = { "python", "html", "javascript" } },
			-- indent = {enable = {"javascriptreact"}},
			autotag = { enable = true },
			-- rainbow = {
			-- 	enable = true,
			-- 	-- list of languages you want to disable the plugin for
			-- 	-- disable = { "jsx", "cpp" },
			-- 	-- Which query to use for finding delimiters
			-- 	query = "rainbow-parens",
			-- 	-- Highlight the entire buffer all at once
			-- 	-- strategy = require("ts-rainbow.strategy.global"),
			-- 	-- Do not enable for files with more than n lines
			-- 	max_file_lines = 3000,
			-- },
		},
	},
	{
		"terrortylor/nvim-comment",
		keys = {
			{ "gcc", mode = "n", desc = "Comment toggle current line" },
			{ "gc", mode = { "n", "o" }, desc = "Comment toggle linewise" },
			{ "gc", mode = "x", desc = "Comment toggle linewise (visual)" },
			{ "gbc", mode = "n", desc = "Comment toggle current block" },
			{ "gb", mode = { "n", "o" }, desc = "Comment toggle blockwise" },
			{ "gb", mode = "x", desc = "Comment toggle blockwise (visual)" },
		},
		config = function()
			require("nvim_comment").setup()
		end,
	},
	-- text objects
	{ "michaeljsmith/vim-indent-object", event = "BufReadPost" },
	{
		"nvim-treesitter/nvim-treesitter-textobjects",
		event = "BufReadPost",
		dependencies = "nvim-treesitter/nvim-treesitter",
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
	{ "windwp/nvim-ts-autotag", ft = { "html", "xml", "javascript", "typescript", "javascriptreact", "typescriptreact", "svelte", "vue" } },
	{ "JoosepAlviste/nvim-ts-context-commentstring", event = "BufReadPost" },

	-- undo tree
	{
		"mbbill/undotree",
		cmd = "UndotreeToggle",
		keys = {
			{ "<leader>u", "<cmd>UndotreeToggle<cr>", desc = "undo tree" },
		},
	},
}
