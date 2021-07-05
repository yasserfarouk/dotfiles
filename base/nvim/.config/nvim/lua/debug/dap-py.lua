require('dap-python').setup('$HOME/.virtualenvs/debugpy/bin/python')
require('dap-python').test_runner = "pytest"
vim.cmd([[
nnoremap <silent> <leader>dn <cmd>lua require('dap-python').test_method()<CR>
nnoremap <silent> <leader>dc <cmd>lua require('dap-python').test_class()<CR>
vnoremap <silent> <leader>ds <ESC><cmd>lua require('dap-python').debug_selection()<CR>
]])
