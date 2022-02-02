-- key maps
vim.cmd("nnoremap <silent> gh <cmd>Lspsaga lsp_finder<CR>")
vim.cmd("nnoremap <silent> gs <cmd>Lspsaga signature_help<CR>")
vim.cmd("nnoremap <silent> <F2> <cmd>Lspsaga rename<CR>")
-- vim.cmd("nnoremap <silent> ca <cmd>Lspsaga code_action<CR>")
vim.cmd("nnoremap <silent> K <cmd>Lspsaga hover_doc<CR>")
vim.cmd('nnoremap <silent> <c-space> <cmd>Lspsaga signature_help<CR>')
vim.cmd("nnoremap <silent> <C-p> <cmd>Lspsaga diagnostic_jump_prev<CR>")
vim.cmd("nnoremap <silent> <C-n> <cmd>Lspsaga diagnostic_jump_next<CR>")
-- scroll down hover doc or scroll in definition preview
vim.cmd(
    "nnoremap <silent> <C-b> <cmd>lua require('lspsaga.action').smart_scroll_with_saga(-1)<CR>")
vim.cmd(
    "nnoremap <silent> <C-f> <cmd>lua require('lspsaga.action').smart_scroll_with_saga(1)<CR>")
