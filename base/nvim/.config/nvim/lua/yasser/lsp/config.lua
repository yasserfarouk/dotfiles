local status_ok, lspconfig = pcall(require, "lspconfig")
if not status_ok then return end
-- Use an on_attach function to only map the following keys
-- after the language server attaches to the current buffer
local on_attach = function(client, bufnr)
    local function buf_set_keymap(...)
        vim.api.nvim_buf_set_keymap(bufnr, ...)
    end
    local function buf_set_option(...)
        vim.api.nvim_buf_set_option(bufnr, ...)
    end

    -- Enable completion triggered by <c-x><c-o>
    buf_set_option('omnifunc', 'v:lua.vim.lsp.omnifunc')

    -- Mappings.
    local opt = {noremap = true, silent = true} -- define keymaps
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

-- Use a loop to conveniently call 'setup' on multiple servers and
-- map buffer local keybindings when the language server attaches
-- local servers = { 'pyright', 'sumneko_lua', 'tsserver', 'bashls' }
-- for _, lsp in ipairs(servers) do
--   lspconfig[lsp].setup {
--     on_attach = on_attach,
--     flags = {
--       debounce_text_changes = 150,
--     }
--   }
-- end

