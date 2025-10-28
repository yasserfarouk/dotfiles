local M = {}

local lsp_utils = require("plugins.lsp.utils")
local icons = require("yasser.icons")

function M.setup(_, opts)
	-- Setup keymaps on LSP attach
	lsp_utils.on_attach(function(client, buffer)
		require("plugins.lsp.keymaps").on_attach(client, buffer)
	end)

	-- Configure diagnostic signs
	local signs = {
		{ name = "DiagnosticSignError", text = icons.diagnostics.Error },
		{ name = "DiagnosticSignWarn", text = icons.diagnostics.Warning },
		{ name = "DiagnosticSignHint", text = icons.diagnostics.Hint },
		{ name = "DiagnosticSignInfo", text = icons.diagnostics.Info },
	}
	for _, sign in ipairs(signs) do
		vim.fn.sign_define(sign.name, { texthl = sign.name, text = sign.text, numhl = sign.name })
	end

	-- Configure diagnostics
	vim.diagnostic.config({
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

	-- Setup mason-lspconfig to install and configure servers
	local servers = opts.servers or {}
	require("mason-lspconfig").setup({
		ensure_installed = vim.tbl_keys(servers),
		automatic_enable = false,
	})

	-- Setup each server with its configuration
	for server_name, server_config in pairs(servers) do
		local server_opts = vim.tbl_deep_extend("force", {
			capabilities = capabilities,
		}, server_config)
		
		require("lspconfig")[server_name].setup(server_opts)
	end
end

return M
