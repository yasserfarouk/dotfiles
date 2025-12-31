local M = {}

function M.on_attach(client, buffer)
	local self = M.new(client, buffer)
	local tok, _ = pcall(require, "telescope")
	local lok, _ = pcall(require, "fzf-lua")
	
	-- Use native LSP rename
	self:map("<F2>", vim.lsp.buf.rename, { desc = "rename" })
	
	if tok then
		self:map("gd", "Telescope lsp_definitions", { desc = "Goto Definition" })
		self:map("gu", "Telescope lsp_references", { desc = "References" })
		self:map("gD", "Telescope lsp_declarations", { desc = "Goto Declaration" })
		self:map("gI", "Telescope lsp_implementations", { desc = "Goto Implementation" })
		self:map("gb", "Telescope lsp_type_definitions", { desc = "Goto Type Definition" })
		self:map("<leader>cd", "Telescope diagnostics bufnr=0", { desc = "document diagnostics" })
		self:map("<leader>cD", "Telescope diagnostics", { desc = "workspace diagnostics" })
		self:map("<leader>cc", "Telescope lsp_dynamic_workspace_symbols", { desc = "Workspace symbols" })
		self:map("<leader>cs", "Telescope lsp_document_symbols", { desc = "Document Symbols" })
		self:map("<leader>cw", "Telescope lsp_workspace_symbols", { desc = "Workspace symbols" })
	elseif lok then
		self:map("gd", "FzfLua lsp_definitions", { desc = "Goto Definition" })
		self:map("gu", "FzfLua lsp_references", { desc = "References" })
		self:map("gD", "FzfLua lsp_declarations", { desc = "Goto Declaration" })
		self:map("gI", "FzfLua lsp_implementations", { desc = "Goto Implementation" })
		self:map("gb", "FzfLua lsp_type_definitions", { desc = "Goto Type Definition" })
		self:map("<leader>cd", "FzfLua lsp_document_diagnostics", { desc = "document diagnostics" })
		self:map("<leader>cD", "FzfLua lsp_workspace_diagnostics", { desc = "workspace diagnostics" })
		self:map("<leader>cc", "FzfLua lsp_live_workspace_symbols", { desc = "Workspace symbols" })
		self:map("<leader>cs", "FzfLua lsp_document_symbols", { desc = "Document Symbols" })
		self:map("<leader>cw", "FzfLua lsp_workspace_symbols", { desc = "Workspace symbols" })
	else
		self:map("gd", "lua vim.lsp.buf.definition()", { desc = "Goto Definition" })
		self:map("gu", "lua vim.lsp.buf.references", { desc = "References" })
		self:map("gD", "lua vim.lsp.buf.declaration()", { desc = "Goto Declaration" })
		self:map("gI", "lua vim.lsp.buf.implementation()", { desc = "Goto Implementation" })
		self:map("gb", "lua vim.lsp.buf.type_definition()", { desc = "Goto Type Definition" })
	end

	self:map("<leader>cv", "LspVirtualTextEnable", { desc = "Enable Virtual Text" })
	self:map("<leader>cV", "LspVirtualTextDisable", { desc = "Disable Virtual Text" })
	self:map("<leader>cn", "LspInfo", { desc = "lsp info" })
	self:map("<leader>ci", function()
		vim.diagnostic.config({ virtual_text = not vim.diagnostic.config().virtual_text })
	end, { desc = "Toggle Inline Diagnostics" })
	self:map("<leader>cl", function()
		vim.diagnostic.open_float()
	end, { desc = "Show Line Diagnostics" })
	self:map("gK", vim.lsp.buf.signature_help, { desc = "Signature Help", has = "signatureHelp" })
end

function M.new(client, buffer)
	return setmetatable({ client = client, buffer = buffer }, { __index = M })
end

function M:has(cap)
	return self.client.server_capabilities[cap .. "Provider"]
end

function M:map(lhs, rhs, opts)
	opts = opts or {}
	if opts.has and not self:has(opts.has) then
		return
	end
	vim.keymap.set(
		opts.mode or "n",
		lhs,
		type(rhs) == "string" and ("<cmd>%s<cr>"):format(rhs) or rhs,
		---@diagnostic disable-next-line: no-unknown
		{ silent = true, buffer = self.buffer, expr = opts.expr, desc = opts.desc }
	)
end

function M.diagnostic_goto(next, severity)
	local go = next and vim.diagnostic.goto_next or vim.diagnostic.goto_prev
	severity = severity and vim.diagnostic.severity[severity] or nil
	return function()
		go({ severity = severity })
	end
end

return M
