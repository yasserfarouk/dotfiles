return {
	"mfussenegger/nvim-lint",
	event = { "BufReadPre", "BufNewFile" },
	config = function()
		local lint = require("lint")
		lint.linters_by_ft = {
			yaml = { "yamllint" },
			["yaml.ansible"] = { "yamllint" },
			json = { "jsonlint" },
			jsonc = { "jsonlint" },
			markdown = { "markdownlint-cli2" },
			["markdown.mdx"] = { "markdownlint-cli2" },
			tex = { "chktex" },
			plaintex = { "chktex" },
		}

		local group = vim.api.nvim_create_augroup("yasser_lint", { clear = true })
		vim.api.nvim_create_autocmd({ "BufWritePost", "BufReadPost", "InsertLeave" }, {
			group = group,
			callback = function()
				-- only try linters that are actually executable
				local ft_linters = lint.linters_by_ft[vim.bo.filetype] or {}
				local available = {}
				for _, name in ipairs(ft_linters) do
					local linter = lint.linters[name]
					local cmd = type(linter) == "table" and linter.cmd or nil
					if cmd and vim.fn.executable(type(cmd) == "function" and cmd() or cmd) == 1 then
						table.insert(available, name)
					end
				end
				if #available > 0 then
					lint.try_lint(available)
				end
			end,
		})

		vim.keymap.set("n", "<leader>cl", function()
			lint.try_lint()
		end, { desc = "Lint buffer" })
	end,
}
