local utils = require('utils.nv_utils')

-- local auto_formatters = {}
-- local python_autoformat = {'BufWritePre', '*.py', 'lua vim.lsp.buf.formatting_sync(nil, 1000)'}
-- table.insert(auto_formatters, python_autoformat)

-- local javascript_autoformat = {'BufWritePre', '*.js', 'lua vim.lsp.buf.formatting_sync(nil, 1000)'}
-- local javascriptreact_autoformat = {'BufWritePre', '*.jsx', 'lua vim.lsp.buf.formatting_sync(nil, 1000)'}
-- table.insert(auto_formatters, javascript_autoformat)
-- table.insert(auto_formatters, javascriptreact_autoformat)

-- local lua_format = {'BufWritePre', '*.lua', 'lua vim.lsp.buf.formatting_sync(nil, 1000)'}
-- table.insert(auto_formatters, lua_format)
-- 
-- local json_format = {'BufWritePre', '*.json', 'lua vim.lsp.buf.formatting_sync(nil, 1000)'}
-- table.insert(auto_formatters, json_format)

utils.define_augroups({
    _general_settings = {
        -- {'TextYankPost', '*', 'lua require(\'vim.highlight\').on_yank({higroup = \'Search\', timeout = 200})'}
        -- {'BufWinEnter', '*', 'setlocal formatoptions-=c formatoptions-=r formatoptions-=o'},
        -- {'BufRead', '*', 'setlocal formatoptions-=c formatoptions-=r formatoptions-=o'},
        -- {'BufNewFile', '*', 'setlocal formatoptions-=c formatoptions-=r formatoptions-=o'},
        -- {'VimLeavePre', '*', 'set title set titleold='}
    },
    _java = {
        {'FileType', 'java', 'luafile ~/.config/nvim/lua/yasser/lsp/java-ls.lua'},
        {'FileType', 'java', 'nnoremap ca <Cmd>lua require(\'jdtls\').code_action()<CR>'}
    },
    -- _dashboard = {
    --     {
    --         'FileType', 'dashboard',
    --         'setlocal nocursorline noswapfile synmaxcol& signcolumn=no norelativenumber nocursorcolumn nospell  nolist  nonumber bufhidden=wipe colorcolumn= foldcolumn=0 matchpairs= '
    --     }, {'FileType', 'dashboard', 'set showtabline=0 | autocmd BufLeave <buffer> set showtabline=2'}
    -- },
    _markdown = {{'FileType', 'markdown', 'setlocal wrap'}, {'FileType', 'markdown', 'setlocal spell'}},
    -- _solidity = {
    --     {'BufWinEnter', '.sol', 'setlocal filetype=solidity'}, {'BufRead', '*.sol', 'setlocal filetype=solidity'},
    --     {'BufNewFile', '*.sol', 'setlocal filetype=solidity'}
    -- },
    -- _gemini = {
    --     {'BufWinEnter', '.gmi', 'setlocal filetype=markdown'}, {'BufRead', '*.gmi', 'setlocal filetype=markdown'},
    --     {'BufNewFile', '*.gmi', 'setlocal filetype=markdown'}
    -- },
    _buffer_bindings = {
        {'FileType', 'dashboard', 'nnoremap <silent> <buffer> q :q<CR>'},
        {'FileType', 'alpha', 'nnoremap <silent> <buffer> q :q<CR>'},
        {'FileType', 'lspinfo', 'nnoremap <silent> <buffer> q :q<CR>'},
        {'FileType', 'floaterm', 'nnoremap <silent> <buffer> q :q<CR>'}
    },
    -- _auto_fmg = {{'BufWritePre', '*.py', 'undojoin | Neoformat'}}
    -- _auto_formatters = auto_formatters
})