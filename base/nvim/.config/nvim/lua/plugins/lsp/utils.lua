local M = {}

function M.capabilities()
	-- Neovim 0.11+ has built-in completion capabilities
	-- Still use cmp_nvim_lsp for enhanced completion features
	local capabilities = vim.lsp.protocol.make_client_capabilities()
	
	local ok, cmp_lsp = pcall(require, "cmp_nvim_lsp")
	if ok then
		capabilities = cmp_lsp.default_capabilities(capabilities)
	end
	
	return capabilities
end

function M.on_attach(on_attach)
	vim.api.nvim_create_autocmd("LspAttach", {
		callback = function(args)
			local bufnr = args.buf
			local client = vim.lsp.get_client_by_id(args.data.client_id)
			on_attach(client, bufnr)
		end,
	})
end

return M
