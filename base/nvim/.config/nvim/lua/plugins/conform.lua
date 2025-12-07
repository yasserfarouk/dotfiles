return {
	"stevearc/conform.nvim",
	keys = {
		{
			"<leader>cf",
			function()
				require("conform").format({ async = true, lsp_fallback = true })
			end,
			mode = { "n", "v" },
			desc = "Format buffer",
		},
		{
			"<leader>cF",
			"<cmd>FormatEnable<cr>",
			mode = "n",
			desc = "Enable autoformat",
		},
		{
			"<leader>cv",
			"<cmd>FormatDisable<cr>",
			mode = "n",
			desc = "Disable autoformat",
		},
	},
	config = function()
		vim.api.nvim_create_user_command("FormatDisable", function(args)
			if args.bang then
				-- FormatDisable! will disable formatting just for this buffer
				vim.b.disable_autoformat = true
			else
				vim.g.disable_autoformat = true
			end
		end, {
			desc = "Disable autoformat-on-save",
			bang = true,
		})
		vim.api.nvim_create_user_command("Format", function()
			require("conform").format({ async = true, lsp_fallback = true })
		end, {
			desc = "Format buffer",
		})
		vim.api.nvim_create_user_command("FormatEnable", function()
			vim.b.disable_autoformat = false
			vim.g.disable_autoformat = false
		end, {
			desc = "Re-enable autoformat-on-save",
		})

		require("conform").setup({
			format_on_save = function(bufnr)
				if vim.g.disable_autoformat or vim.b[bufnr].disable_autoformat then
					return
				end
				return { timeout_ms = 1500, lsp_fallback = true }
			end,
			formatters_by_ft = {
				lua = { "stylua" },
				python = { "ruff_fix", "ruff_format" },
				javascript = { "prettierd", "prettier", stop_after_first = true },
			},
		})
	end,
}
