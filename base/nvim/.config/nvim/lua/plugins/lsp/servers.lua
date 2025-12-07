local M = {}

local lsp_utils = require("plugins.lsp.utils")
local icons = require("yasser.icons")

function M.setup(_, opts)
	-- Setup keymaps on LSP attach
	lsp_utils.on_attach(function(client, buffer)
		require("plugins.lsp.keymaps").on_attach(client, buffer)
	end)

	-- Configure diagnostics with signs
	local icons = icons
	vim.diagnostic.config({
		signs = {
			text = {
				[vim.diagnostic.severity.ERROR] = icons.diagnostics.Error,
				[vim.diagnostic.severity.WARN] = icons.diagnostics.Warning,
				[vim.diagnostic.severity.HINT] = icons.diagnostics.Hint,
				[vim.diagnostic.severity.INFO] = icons.diagnostics.Info,
			},
		},
		virtual_text = {
			prefix = "●",
			severity = { min = vim.diagnostic.severity.WARNING },
		},
		underline = true,
		update_in_insert = false,
		severity_sort = true,
		float = {
			focusable = true,
			style = "minimal",
			border = "rounded",
			source = "always",
		},
	})

	-- Configure LSP hover and signature help
	local float_config = { focusable = true, style = "minimal", border = "rounded" }
	vim.lsp.handlers["textDocument/hover"] = vim.lsp.with(vim.lsp.handlers.hover, float_config)
	vim.lsp.handlers["textDocument/signatureHelp"] = vim.lsp.with(vim.lsp.handlers.signature_help, float_config)

	-- Get default capabilities
	local capabilities = lsp_utils.capabilities()

	-- Setup mason-lspconfig to install servers
	local servers = opts.servers or {}
	require("mason-lspconfig").setup({
		ensure_installed = vim.tbl_keys(servers),
		automatic_enable = false,
	})

	-- Configure each server using vim.lsp.config
	for server_name, server_config in pairs(servers) do
		local config = vim.tbl_deep_extend("force", {
			capabilities = capabilities,
		}, server_config)
		
		vim.lsp.config(server_name, config)
		vim.lsp.enable(server_name)
	end
end

return M
