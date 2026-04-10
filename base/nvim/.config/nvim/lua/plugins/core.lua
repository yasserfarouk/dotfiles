return {
	-- Syntax highlighting and code understanding using tree-sitter
	-- NOTE: Updated for Neovim 0.12 compatibility (new nvim-treesitter main branch)
	{
		"nvim-treesitter/nvim-treesitter",
		branch = "main", -- Required for Neovim 0.12+
		event = { "BufReadPost", "BufNewFile" },
		build = ":TSUpdate",
		main = "nvim-treesitter", -- New module path for 0.12+
		opts = {
			-- NOTE: ensure_installed is no longer a config option in the new API
			-- Parsers are installed via init callback below
		},
		init = function()
			-- Parsers to ensure are installed
			local ensure_installed = {
				"cpp", "python", "lua", "java", "javascript", "php", "latex",
				"typescript", "html", "css", "json", "yaml", "toml", "bash",
				"markdown", "markdown_inline", "vim", "vimdoc", "query",
			}

			-- Install missing parsers
			local installed = require("nvim-treesitter.config").get_installed()
			local to_install = vim.iter(ensure_installed)
				:filter(function(parser)
					return not vim.tbl_contains(installed, parser)
				end)
				:totable()
			if #to_install > 0 then
				require("nvim-treesitter").install(to_install)
			end

			-- Enable treesitter highlighting and indentation via FileType autocmd
			vim.api.nvim_create_autocmd("FileType", {
				callback = function()
					-- Enable treesitter highlighting (disable regex syntax)
					pcall(vim.treesitter.start)
					-- Enable treesitter-based indentation (except for some filetypes)
					local disabled_indent = { python = true, html = true, javascript = true }
					if not disabled_indent[vim.bo.filetype] then
						vim.bo.indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
					end
				end,
			})
		end,
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
	-- NOTE: Updated for Neovim 0.12 compatibility (new main branch)
	{
		"nvim-treesitter/nvim-treesitter-textobjects",
		branch = "main", -- Required for Neovim 0.12+
		event = "BufReadPost",
		dependencies = "nvim-treesitter/nvim-treesitter",
		config = function()
			-- Textobjects keymaps - these work with the new treesitter API
			local ts_repeat_move = require("nvim-treesitter-textobjects.repeatable_move")

			-- Selection keymaps
			vim.keymap.set({ "x", "o" }, "af", function()
				require("nvim-treesitter-textobjects.select").select_textobject("@function.outer", "textobjects")
			end, { desc = "Select outer function" })
			vim.keymap.set({ "x", "o" }, "if", function()
				require("nvim-treesitter-textobjects.select").select_textobject("@function.inner", "textobjects")
			end, { desc = "Select inner function" })
			vim.keymap.set({ "x", "o" }, "am", function()
				require("nvim-treesitter-textobjects.select").select_textobject("@function.outer", "textobjects")
			end, { desc = "Select outer method" })
			vim.keymap.set({ "x", "o" }, "im", function()
				require("nvim-treesitter-textobjects.select").select_textobject("@function.inner", "textobjects")
			end, { desc = "Select inner method" })
			vim.keymap.set({ "x", "o" }, "aC", function()
				require("nvim-treesitter-textobjects.select").select_textobject("@class.outer", "textobjects")
			end, { desc = "Select outer class" })
			vim.keymap.set({ "x", "o" }, "iC", function()
				require("nvim-treesitter-textobjects.select").select_textobject("@class.inner", "textobjects")
			end, { desc = "Select inner class" })
			vim.keymap.set({ "x", "o" }, "ab", function()
				require("nvim-treesitter-textobjects.select").select_textobject("@block.outer", "textobjects")
			end, { desc = "Select outer block" })
			vim.keymap.set({ "x", "o" }, "ib", function()
				require("nvim-treesitter-textobjects.select").select_textobject("@block.inner", "textobjects")
			end, { desc = "Select inner block" })
			vim.keymap.set({ "x", "o" }, "aa", function()
				require("nvim-treesitter-textobjects.select").select_textobject("@parameter.outer", "textobjects")
			end, { desc = "Select outer parameter" })
			vim.keymap.set({ "x", "o" }, "ia", function()
				require("nvim-treesitter-textobjects.select").select_textobject("@parameter.inner", "textobjects")
			end, { desc = "Select inner parameter" })
			vim.keymap.set({ "x", "o" }, "ac", function()
				require("nvim-treesitter-textobjects.select").select_textobject("@conditional.outer", "textobjects")
			end, { desc = "Select outer conditional" })
			vim.keymap.set({ "x", "o" }, "ic", function()
				require("nvim-treesitter-textobjects.select").select_textobject("@conditional.inner", "textobjects")
			end, { desc = "Select inner conditional" })
			vim.keymap.set({ "x", "o" }, "al", function()
				require("nvim-treesitter-textobjects.select").select_textobject("@loop.outer", "textobjects")
			end, { desc = "Select outer loop" })
			vim.keymap.set({ "x", "o" }, "il", function()
				require("nvim-treesitter-textobjects.select").select_textobject("@loop.inner", "textobjects")
			end, { desc = "Select inner loop" })
			vim.keymap.set({ "x", "o" }, "a/", function()
				require("nvim-treesitter-textobjects.select").select_textobject("@comment.outer", "textobjects")
			end, { desc = "Select comment" })

			-- Move keymaps
			vim.keymap.set({ "n", "x", "o" }, "]m", function()
				require("nvim-treesitter-textobjects.move").goto_next_start("@function.outer", "textobjects")
			end, { desc = "Next function start" })
			vim.keymap.set({ "n", "x", "o" }, "]M", function()
				require("nvim-treesitter-textobjects.move").goto_next_end("@function.outer", "textobjects")
			end, { desc = "Next function end" })
			vim.keymap.set({ "n", "x", "o" }, "]]", function()
				require("nvim-treesitter-textobjects.move").goto_next_start("@class.outer", "textobjects")
			end, { desc = "Next class start" })
			vim.keymap.set({ "n", "x", "o" }, "][", function()
				require("nvim-treesitter-textobjects.move").goto_next_end("@class.outer", "textobjects")
			end, { desc = "Next class end" })
			vim.keymap.set({ "n", "x", "o" }, "[m", function()
				require("nvim-treesitter-textobjects.move").goto_previous_start("@function.outer", "textobjects")
			end, { desc = "Previous function start" })
			vim.keymap.set({ "n", "x", "o" }, "[M", function()
				require("nvim-treesitter-textobjects.move").goto_previous_end("@function.outer", "textobjects")
			end, { desc = "Previous function end" })
			vim.keymap.set({ "n", "x", "o" }, "[[", function()
				require("nvim-treesitter-textobjects.move").goto_previous_start("@class.outer", "textobjects")
			end, { desc = "Previous class start" })
			vim.keymap.set({ "n", "x", "o" }, "[]", function()
				require("nvim-treesitter-textobjects.move").goto_previous_end("@class.outer", "textobjects")
			end, { desc = "Previous class end" })

			-- Swap keymaps
			vim.keymap.set("n", "g>", function()
				require("nvim-treesitter-textobjects.swap").swap_next("@parameter.inner")
			end, { desc = "Swap next parameter" })
			vim.keymap.set("n", "g<", function()
				require("nvim-treesitter-textobjects.swap").swap_previous("@parameter.inner")
			end, { desc = "Swap previous parameter" })

			-- Make moves repeatable with ; and ,
			vim.keymap.set({ "n", "x", "o" }, ";", ts_repeat_move.repeat_last_move_next)
			vim.keymap.set({ "n", "x", "o" }, ",", ts_repeat_move.repeat_last_move_previous)
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
