
" show or hide REPL terminal-console
nnoremap <Leader>py :ToggleConsole<CR>

" vim-slime -------------- {{{
if has("nvim")
	let g:slime_target = "neovim"
else
	let g:slime_target = "vimterminal"
endif
let g:slime_python_ipython = 1
" }}}
" vim-slime-ipython ---------- {{{
let g:slime_ipython_no_mapping = 1


" cell manager
call submode#MapEnterKeys('cell-mode', ['<A-CR>', '<Leader><Esc>'])
call submode#MapLeaveKeys('cell-mode', ['<CR>', 'q'])
call submode#SetMaps('cell-mode', {
	\ '<A-CR>': ':SendCurrentCellNext<CR>',
	\ 'j': ':NextCell<CR>',
	\ 'k': ':PrevCell<CR>',
	\ 'J': ':MoveCellDown<CR>',
	\ 'K': ':MoveCellUp<CR>',
	\ 'dd': ':CutCurrentCell<CR>',
	\ 'yy': ':CopyCurrentCell<CR>',
	\ })
let g:slime_ipython_console_layout = {'position': 'right', 'width': 0.5}
let g:slime_ipython_repls = {
	\ 'python': ["ipython3\n", "%cpaste -q\n", "--\n"],
	\ 'python3': ["ipython3\n", "%cpaste -q\n", "--\n"],
	\ 'sh': ["zsh\n", "", ""],
	\ }
" }}}

