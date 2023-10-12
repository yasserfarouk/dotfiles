local M = {}

function M.on_attach(client, buffer)
	local self = M.new(client, buffer)
	local tok, _ = pcall(require, "telescope")
	local lok, _ = pcall(require, "fzf-lua")
	local sok, _ = pcall(require, "lspsaga")
	if pcall(require, "inc_rename") then
		self:map("<F2>", "IncRename " .. vim.fn.expand("<cword>"), { desc = "rename" })
	elseif sok then
		self:map("<F2>", "Lspsaga rename", { desc = "rename" })
	else
		self:map("<F2>", function()
			vim.lsp.buf.rename()
		end, { desc = "Prev Warning" })
	end
	if sok then
		self:map("gp", "Lspsaga peek_definition", { desc = "Goto Definition" })
		self:map("gr", "Lspsaga lsp_finder", { desc = "Goto Definition" })
		self:map("[d", "Lspsaga diagnostic_jump_prev", { desc = "Next Diagnostic" })
		self:map("]d", "Lspsaga diagnostic_jump_next", { desc = "Prev Diagnostic" })
		self:map("]e", function()
			require("lspsaga.diagnostic"):goto_next({ severity = vim.diagnostic.severity.ERROR })
		end, { desc = "Next Error" })
		self:map("[e", function()
			require("lspsaga.diagnostic"):goto_prev({ severity = vim.diagnostic.severity.ERROR })
		end, { desc = "Prev Error" })
		self:map("]w", function()
			require("lspsaga.diagnostic"):goto_next({ severity = vim.diagnostic.severity.WARN })
		end, { desc = "Next Warning" })
		self:map("[w", function()
			require("lspsaga.diagnostic"):goto_prev({ severity = vim.diagnostic.severity.WARN })
		end, { desc = "Prev Warning" })

		self:map("<leader>ca", "Lspsaga code_action", { desc = "code action" })
		self:map("<leader>cA", "Lspsaga range_code_action", { desc = "selected action" })
		self:map("<leader>cl", "Lspsaga show_line_diagnostics", { desc = "line_diagnostics" })
		self:map("<leader>c>", "Lspsaga diagnostics_jump_next", { desc = "next diagnostic" })
		self:map("<leader>c<", "Lspsaga diagnostics_jump_prev", { desc = "previous diagnostic" })
		self:map("<leader>cp", "Lspsaga peek_definition", { desc = "preview definition" })
		self:map("<leader>ch", "Lspsaga signature_help", { desc = "signature help" })
		self:map("K", "Lspsaga hover_doc", { desc = "Hover" })
		self:map("<leader>ci", "Lspsaga lsp_finder", { desc = "lsp finder" })
	else
		self:map("[d", M.diagnostic_goto(true), { desc = "Next Diagnostic" })
		self:map("]d", M.diagnostic_goto(false), { desc = "Prev Diagnostic" })
		self:map("]e", M.diagnostic_goto(true, "ERROR"), { desc = "Next Error" })
		self:map("[e", M.diagnostic_goto(false, "ERROR"), { desc = "Prev Error" })
		self:map("]w", M.diagnostic_goto(true, "WARNING"), { desc = "Next Warning" })
		self:map("[w", M.diagnostic_goto(false, "WARNING"), { desc = "Prev Warning" })
		self:map("<leader>ca", "lua vim.lsp.buf.code_action()", { desc = "code action" })
		self:map("<leader>cA", "lua vim.lsp.buf.range_code_action()", { desc = "selected action" })
		self:map("<leader>cl", "lua vim.lsp.buf.show_line_diagnostics()", { desc = "line_diagnostics" })
		self:map("<leader>c>", "lua vim.lsp.buf.diagnostics_jump_next()", { desc = "next diagnostic" })
		self:map("<leader>c<", "lua vim.lsp.buf.diagnostics_jump_prev()", { desc = "previous diagnostic" })
		self:map("<leader>cp", "lua vim.lsp.buf.preview_definition()", { desc = "preview definition" })
		self:map("<leader>ch", "lua vim.lsp.buf.signature_help()", { desc = "signature help" })
		self:map("K", "lua vim.lsp.buf.hover()", { desc = "Hover" })
	end
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
	elseif sok then
		self:map("gd", "Lspsaga goto_definition", { desc = "Goto Definition" })
		self:map("gu", "Lspsaga lsp_finder", { desc = "References" })
		self:map("gD", "lua vim.lsp.buf.declaration()", { desc = "Goto Declaration" })
		self:map("gI", "lua vim.lsp.buf.implementation()", { desc = "Goto Implementation" })
		self:map("gb", "lua vim.lsp.buf.type_definition()", { desc = "Goto Type Definition" })
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
	self:map("<leader>cB", "lua vim.lsp.buf.blame_line()", { desc = "signature help" })
	self:map("gK", vim.lsp.buf.signature_help, { desc = "Signature Help", has = "signatureHelp" })

	local format = require("plugins.lsp.format").format
	self:map("<leader>cf", function()
		format({ timeout = 3000 })
	end, { desc = "Format Document", has = "documentFormatting" })
	self:map("<leader>cF", function()
		format({ timeout = 3000 })
	end, { desc = "Format Range", mode = "v", has = "documentRangeFormatting" })
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

function M.rename()
	if pcall(require, "inc_rename") then
		return ":IncRename " .. vim.fn.expand("<cword>")
	else
		vim.lsp.buf.rename()
	end
end

function M.diagnostic_goto(next, severity)
	local go = next and vim.diagnostic.goto_next or vim.diagnostic.goto_prev
	severity = severity and vim.diagnostic.severity[severity] or nil
	return function()
		go({ severity = severity })
	end
end

return M
