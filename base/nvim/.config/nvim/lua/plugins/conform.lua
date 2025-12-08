return {
	-- Lightweight formatter with support for multiple formatters per filetype
	"stevearc/conform.nvim",
	keys = {
		{
			"<leader>cf",
			function()
				local conform = require("conform")
				local ok, err = pcall(function()
					conform.format({ async = true, lsp_fallback = true, timeout_ms = 3000 })
				end)
				if not ok then
					vim.notify("Formatting failed", vim.log.levels.WARN)
				end
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
			require("conform").format({ async = true, lsp_fallback = true, timeout_ms = 3000 })
		end, {
			desc = "Format buffer",
		})
		vim.api.nvim_create_user_command("FormatEnable", function()
			vim.b.disable_autoformat = false
			vim.g.disable_autoformat = false
		end, {
			desc = "Re-enable autoformat-on-save",
		})
		vim.api.nvim_create_user_command("FormatHealth", function()
			local conform = require("conform")
			local buf = vim.api.nvim_get_current_buf()
			local ft = vim.bo[buf].filetype
			
			local formatters = conform.list_formatters(buf)
			if #formatters == 0 then
				vim.notify("No formatters configured for " .. ft, vim.log.levels.WARN)
				return
			end
			
			local formatter_names = {}
			for _, f in ipairs(formatters) do
				table.insert(formatter_names, f.name)
			end
			vim.notify("Formatters for " .. ft .. ": " .. table.concat(formatter_names, ", "), vim.log.levels.INFO)
		end, {
			desc = "Check available formatters for current buffer",
		})

		require("conform").setup({
			-- Enable format on save by default for all configured filetypes
			-- Use :FormatDisable to disable globally or :FormatDisable! for current buffer
			format_on_save = function(bufnr)
				-- Only skip if explicitly disabled
				if vim.g.disable_autoformat or vim.b[bufnr].disable_autoformat then
					return
				end
				return { timeout_ms = 3000, lsp_fallback = true }
			end,
			formatters_by_ft = {
				lua = { "stylua" },
				python = { "ruff_fix", "ruff_format" },
				javascript = { "prettierd", "prettier", stop_after_first = true },
			},
		})
	end,
}
