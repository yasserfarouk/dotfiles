local status_ok, lspconfig = pcall(require, "lspconfig")
if not status_ok then return end
-- Use an on_attach function to only map the following keys
-- after the language server attaches to the current buffer

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

