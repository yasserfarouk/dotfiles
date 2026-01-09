return {
	-- Syntax highlighting and code understanding using tree-sitter
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
	-- Fast and easy commenting with gcc, gc motions
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
	-- Text objects for indentation levels (vii, vai, etc.)
	{ "michaeljsmith/vim-indent-object", event = "BufReadPost" },
	-- Advanced text objects using treesitter (functions, classes, etc.)
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
	-- Automatically close HTML/JSX tags
	{
		"windwp/nvim-ts-autotag",
		ft = { "html", "xml", "javascript", "typescript", "javascriptreact", "typescriptreact", "svelte", "vue" },
	},
	-- Context-aware commenting for embedded languages
	{ "JoosepAlviste/nvim-ts-context-commentstring", event = "BufReadPost" },
	-- Sticky context showing current function/class/if at top of buffer
	{
		"nvim-treesitter/nvim-treesitter-context",
		event = "BufReadPost",
		config = function()
			require("treesitter-context").setup({
				enable = false, -- Disabled by default, toggle with keymap
				max_lines = 5, -- Max number of context lines
				min_window_height = 20, -- Only show if window is tall enough
				multiline_threshold = 1, -- Max lines for a single context node
				trim_scope = "outer", -- Which scope to trim if max_lines exceeded
				mode = "cursor", -- Show context based on cursor position
			})
		end,
		keys = {
			{
				"<leader>cx",
				function()
					require("treesitter-context").toggle()
				end,
				desc = "Toggle code context",
			},
			{
				"gC",
				function()
					require("treesitter-context").go_to_context(vim.v.count1)
				end,
				desc = "Jump to context",
			},
		},
	},

	-- Visual undo history tree browser
	{
		"mbbill/undotree",
		cmd = "UndotreeToggle",
		keys = {
			{ "<leader>u", "<cmd>UndotreeToggle<cr>", desc = "undo tree" },
		},
	},
	-- Paste/embed images from clipboard or drag-and-drop
	{
		"HakonHarnes/img-clip.nvim",
		event = "VeryLazy",
		opts = {
			default = {
				dir_path = "assets/images",
				prompt_for_file_name = true,
				drag_and_drop = {
					enabled = true,
					insert_mode = true,
				},
			},
		},
		keys = {
			{ "<leader>P", "<cmd>PasteImage<cr>", desc = "Paste image from clipboard" },
		},
	},
}
