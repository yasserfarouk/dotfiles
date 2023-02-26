local status_ok, mason = pcall(require, "mason")
if not status_ok then
	return
end

local on_attach = function(client, bufnr)
	local function buf_set_keymap(...)
		vim.api.nvim_buf_set_keymap(bufnr, ...)
	end

	local function buf_set_option(...)
		vim.api.nvim_buf_set_option(bufnr, ...)
	end

	if client.server_capabilities.definitionProvider then
		vim.api.nvim_buf_set_option(bufnr, "tagfunc", "v:lua.vim.lsp.tagfunc")
	end

	-- Enable completion triggered by <c-x><c-o>
	buf_set_option('omnifunc', 'v:lua.vim.lsp.omnifunc')

	-- Mappings.
	local opt = { noremap = true, silent = true } -- define keymaps
	buf_set_keymap('n', "K", '<cmd>lua vim.lsp.buf.hover()<CR>', opt)
	buf_set_keymap('n', "gd", "<cmd>lua vim.lsp.buf.definition()<CR>", opt)
	buf_set_keymap('n', 'gD', "<cmd>lua vim.lsp.buf.declaration()<CR>", opt)
	buf_set_keymap('n', 'gu', "<cmd>lua vim.lsp.buf.references()<CR>", opt)
	buf_set_keymap('n', 'ge', "<cmd>lua vim.diagnostic.open_float()<CR>", opt)
	buf_set_keymap('n', 'gi', "<cmd>lua vim.lsp.buf.implementation()<CR>", opt)
	buf_set_keymap('n', '[d', "<cmd>lua vim.diagnostic.goto_prev()<CR>", opt)
	buf_set_keymap('n', ']d', "<cmd>lua vim.diagnostic.goto_next()<CR>", opt)
	buf_set_keymap('n', ']d', "<cmd>lua vim.diagnostic.goto_next()<CR>", opt)
	buf_set_option('omnifunc', 'v:lua.vim.lsp.omnifunc')
	vim.cmd([[command! -nargs=0 LspVirtualTextToggle lua require("lsp/virtual_text").toggle()]])
	local sigok, lspsig = pcall(require, "lsp_signature")
	if sigok then lspsig.on_attach(client) end
end
local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities.textDocument.completion.completionItem.snippetSupport = true
local server_opts = {
	on_attach = on_attach,
	capabilities = capabilities,
	flags = {
		debounce_text_changes = 150,
	},
}

local lspconfig = require("lspconfig")

local servers = {
	sumneko_lua = {
		settings = {
			Lua = {
				runtime = {
					version = "LuaJIT",
					path = vim.split(package.path, ";"),
				},
				diagnostics = {
					globals = { "vim" },
				},
				workspace = {
					library = vim.api.nvim_get_runtime_file("", true),
				},
				telemetry = { enable = false },
			},
		},
	},
	pyright = {
		settings = {
			python = {
				analysis = {
					extraPaths = { "/Users/code/projects/negmas" }
				}
			}
		}
	}
}
require("mason-lspconfig").setup_handlers({
	function(server_name)
		local extended_opts = vim.tbl_deep_extend("force", server_opts, servers[server_name] or {})
		lspconfig[server_name].setup(extended_opts)
	end,
	-- You can set up other server specific config
})

mason.setup({})

require("mason-lspconfig").setup({
	ensure_installed = vim.tbl_keys(servers),
	automatic_installation = false,
})
