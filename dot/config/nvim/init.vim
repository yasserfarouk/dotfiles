let g:make = 'gmake'
if exists('make')
    let g:make = 'make'
endif

let vimplug_exists=expand('~/.vim/autoload/plug.vim')

if !filereadable(vimplug_exists)
    if !executable("curl")
        echoerr "You have to install curl or first install vim-plug yourself!"
        execute "q!"
    endif
    echo "Installing Vim-Plug..."
    echo ""
    silent !\curl -fLo ~/.vim/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
    let g:not_finish_vimplug = "yes"

    autocmd VimEnter * PlugInstall
endif

" Required:
set rtp +=~/.config/nvim
call plug#begin(expand('~/.vim/plugged'))
if filereadable(expand("~/.vim/common_plugins"))
    source ~/.vim/common_plugins
endif
if filereadable(expand("~/.vim/nvim_plugins"))
    source ~/.vim/nvim_plugins
endif


"" I keep local bundles that are specific to vim at local_bundles_vim
if filereadable(expand("~/.vim/local_nvim_plugins"))
    source ~/.vim/local_nvim_plugins
endif
call plug#end()

set inccommand=split

let $NVIM_TUI_ENABLE_CURSOR_SHAPE=1

:autocmd InsertEnter * set cul
:autocmd InsertLeave * set nocul
if !exists('g:vscode')
	" Normal mapping

	" terminal emulation
	nnoremap <silent> <leader>sh :terminal<CR>
	" change cursor in normal mode
	if exists('$TMUX')
 	    let &t_SI = "\<Esc>Ptmux;\<Esc>\<Esc>]50;CursorShape=1\x7\<Esc>\\"
	    let &t_EI = "\<Esc>Ptmux;\<Esc>\<Esc>]50;CursorShape=0\x7\<Esc>\\"
	else
	    let &t_SI = "\<Esc>]50;CursorShape=1\x7"
	    let &t_EI = "\<Esc>]50;CursorShape=0\x7"
	endif

	" Tex ------------------------{{{
	let g:vimtex_compiler_progname='nvr'
	" }}}


	" NERDTree ------------------------------------------------------------------{{{
	let g:vimfiler_ignore_pattern = ""
	map <silent> - :VimFiler<CR>
	let g:vimfiler_tree_leaf_icon = ''
	let g:vimfiler_tree_opened_icon = ''
	let g:vimfiler_tree_closed_icon = ''
	let g:vimfiler_file_icon = ''
	let g:vimfiler_marked_file_icon = '*'
	let g:vimfiler_expand_jump_to_first_child = 0
	" let g:vimfiler_as_default_explorer = 1
	call unite#custom#profile('default', 'context', {
				\'direction': 'botright',
				\ })
	call vimfiler#custom#profile('default', 'context', {
				\ 'explorer' : 1,
				\ 'winwidth' : 45,
				\ 'winminwidth' : 45,
				\ 'toggle' : 1,
				\ 'auto_expand': 0,
				\ 'parent': 1,
				\ 'explorer_columns': 'devicons:git',
				\ 'status' : 0,
				\ 'safe' : 0,
				\ 'split' : 1,
				\ 'hidden': 1,
				\ 'no_quit' : 1,
				\ 'force_hide' : 0,
				\ })
	augroup vfinit
		autocmd FileType vimfiler call s:vimfilerinit()
		autocmd FileType unite call s:uniteinit()
	augroup END
	function! s:uniteinit()
		nmap <buffer> <Esc> <Plug>(unite_exit)
	endfunction
	function! s:vimfilerinit()
		set nonumber
		set norelativenumber
		nmap <silent><buffer><expr> <CR> vimfiler#smart_cursor_map(
					\ "\<Plug>(vimfiler_expand_tree)",
					\ "\<Plug>(vimfiler_edit_file)"
					\)
		nnoremap <silent><buffer><expr> s vimfiler#do_switch_action('vsplit')
		nmap <silent> m :call NerdUnite()<cr>
		" nmap <silent> p <Plug>(vimfiler_jump_first_child)
		nmap <silent> r <Plug>(vimfiler_redraw_screen)
	endf
	" let g:vimfiler_ignore_pattern = '^\%(\.git\|\.DS_Store\)$'
	let g:webdevicons_enable_vimfiler = 0
	let g:vimfiler_no_default_key_mappings=1
	function! NerdUnite() abort "{{{
		let marked_files =  vimfiler#get_file(b:vimfiler)
		call unite#start(['nerd'], {'file': marked_files})
	endfunction "}}}

	augroup ntinit
		autocmd FileType nerdtree call s:nerdtreeinit()
	augroup END
	function! s:nerdtreeinit() abort
		nunmap <buffer> K
		nunmap <buffer> J
	endf

	" Nvim terminal -------------------------------------------------------------{{{

	au BufEnter * if &buftype == 'terminal' | :startinsert | endif
	autocmd BufEnter term://* startinsert
	autocmd TermOpen * set bufhidden=hide

	" }}}

	let g:ale_sign_warning = '•'
	let g:airline#extensions#ale#error_symbol='• '
	let g:airline#extensions#ale#warning_symbol='•  '

	let g:neomake_warning_sign = {'text': '•'}
	let g:neomake_error_sign = {'text': '•'}
	let g:airline#extensions#neomake#error_symbol='• '
	let g:airline#extensions#neomake#warning_symbol='•  '

	" Write this in your vimrc file
	" let g:ale_lint_on_text_changed = 'never'
	" let g:ale_lint_on_enter = 0
	" let g:neomake_verbose = 3
	"}}}
endif 

" MarkDown ------------------------------------------------------------------{{{

noremap <leader>TM :TableModeToggle<CR>
let g:table_mode_corner="|"
let g:markdown_fold_override_foldtext = 0
let g:neomake_markdown_proselint_maker = {
			\ 'errorformat': '%W%f:%l:%c: %m',
			\ 'postprocess': function('neomake#postprocess#GenericLengthPostprocess'),
			\}
let g:neomake_markdown_enabled_makers = ['alex', 'proselint']
let g:markdown_syntax_conceal = 0

" let g:neoformat_markdown_prettier = g:standard_prettier_settings
" let g:neoformat_enabled_markdown = ['prettier']

" HTML ----------------------------------------------------------------------{{{

let g:neomake_html_enabled_makers = []
let g:neoformat_enabled_html = ['htmlbeautify']

" }}}


" For conceal markers.
if has('conceal')
	set conceallevel=2 concealcursor=niv
endif


let g:esearch = {
  \ 'adapter':    'ag',
  \ 'backend':    'nvim',
  \ 'out':        'win',
  \ 'batch_size': 1000,
  \ 'use':        ['visual', 'hlsearch', 'last'],
  \}

"*****************************************************************************
"*****************************************************************************

source ~/.local.vim

"" Include user's local vim config
if filereadable(expand("~/.config/nvim/local_init.vim"))
	source ~/.config/nvim/local_init.vim
endif

