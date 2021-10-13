-- TODO figure out why this don't work
vim.fn.sign_define("LspDiagnosticsSignError", {
    texthl = "LspDiagnosticsSignError",
    text = "",
    numhl = "LspDiagnosticsSignError"
})
vim.fn.sign_define("LspDiagnosticsSignWarning", {
    texthl = "LspDiagnosticsSignWarning",
    text = "",
    numhl = "LspDiagnosticsSignWarning"
})
vim.fn.sign_define("LspDiagnosticsSignHint", {
    texthl = "LspDiagnosticsSignHint",
    text = "",
    numhl = "LspDiagnosticsSignHint"
})
vim.fn.sign_define("LspDiagnosticsSignInformation", {
    texthl = "LspDiagnosticsSignInformation",
    text = "",
    numhl = "LspDiagnosticsSignInformation"
})

vim.cmd("nnoremap <silent> gd <cmd>lua vim.lsp.buf.definition()<CR>")
vim.cmd("nnoremap <silent> gh <cmd>Lspsaga lsp_finder<CR>")
vim.cmd("nnoremap <silent> gD <cmd>lua vim.lsp.buf.declaration()<CR>")
vim.cmd("nnoremap <silent> gu <cmd>lua vim.lsp.buf.references()<CR>")
vim.cmd("nnoremap <silent> gR <cmd>lua vim.lsp.buf.references()<CR>")
vim.cmd("nnoremap <silent> gs <cmd>Lspsaga signature_help<CR>")
vim.cmd("nnoremap <silent> gi <cmd>lua vim.lsp.buf.implementation()<CR>")
vim.cmd("nnoremap <silent> <F2> <cmd>Lspsaga rename<CR>")
vim.cmd("nnoremap <silent> ca <cmd>Lspsaga code_action<CR>")
vim.cmd("nnoremap <silent> K <cmd>Lspsaga hover_doc<CR>")
vim.cmd('nnoremap <silent> <c-space> <cmd>Lspsaga signature_help<CR>')
vim.cmd("nnoremap <silent> <C-p> <cmd>Lspsaga diagnostic_jump_prev<CR>")
vim.cmd("nnoremap <silent> <C-n> <cmd>Lspsaga diagnostic_jump_next<CR>")
-- scroll down hover doc or scroll in definition preview
vim.cmd(
    "nnoremap <silent> <C-f> <cmd>lua require('lspsaga.action').smart_scroll_with_saga(1)<CR>")
-- scroll up hover doc
vim.cmd(
    "nnoremap <silent> <C-b> <cmd>lua require('lspsaga.action').smart_scroll_with_saga(-1)<CR>")
vim.cmd(
    'command! -nargs=0 LspVirtualTextToggle lua require("lsp/virtual_text").toggle()')

-- symbols for autocomplete
vim.lsp.protocol.CompletionItemKind = {
    "   (Text) ", "   (Method)", "   (Function)",
    "   (Constructor)", " ﴲ  (Field)", "[] (Variable)", "   (Class)",
    " ﰮ  (Interface)", "   (Module)", " 襁 (Property)", "   (Unit)",
    "   (Value)", " 練 (Enum)", "   (Keyword)", " ﬌  (Snippet)",
    "   (Color)", "   (File)", "   (Reference)", "   (Folder)",
    "   (EnumMember)", " ﲀ  (Constant)", " ﳤ  (Struct)", "   (Event)",
    "   (Operator)", "   (TypeParameter)"
}

--[[ " autoformat
autocmd BufWritePre *.js lua vim.lsp.buf.formatting_sync(nil, 100)
autocmd BufWritePre *.jsx lua vim.lsp.buf.formatting_sync(nil, 100)
autocmd BufWritePre *.lua lua vim.lsp.buf.formatting_sync(nil, 100) ]]
-- Java
-- autocmd FileType java nnoremap ca <Cmd>lua require('jdtls').code_action()<CR>

local function documentHighlight(client, bufnr)
    -- Set autocommands conditional on server_capabilities
    -- if client.resolved_capabilities.document_highlight then
    --     vim.api.nvim_exec([[
    --   hi LspReferenceRead cterm=bold ctermbg=red guibg=#464646
    --   hi LspReferenceText cterm=bold ctermbg=red guibg=#464646
    --   hi LspReferenceWrite cterm=bold ctermbg=red guibg=#464646
    --   augroup lsp_document_highlight
    --     autocmd! * <buffer>
    --     autocmd CursorHold <buffer> lua vim.lsp.buf.document_highlight()
    --     autocmd CursorMoved <buffer> lua vim.lsp.buf.clear_references()
    --   augroup END
    -- ]], false)
    -- end
end
local lsp_config = {}

function lsp_config.common_on_attach(client, bufnr)
    documentHighlight(client, bufnr)
    require'lsp_signature'.on_attach(client)
    local function buf_set_keymap(...)
        vim.api.nvim_buf_set_keymap(bufnr, ...)
    end
    local function buf_set_option(...)
        vim.api.nvim_buf_set_option(bufnr, ...)
    end
    buf_set_option('omnifunc', 'v:lua.vim.lsp.omnifunc')
end

-- Use a loop to conveniently both setup defined servers
-- and map buffer local keybindings when the language server attaches
-- local servers = {"pyright", "tsserver"}
-- for _, lsp in ipairs(servers) do nvim_lsp[lsp].setup {on_attach = on_attach} end
return lsp_config
