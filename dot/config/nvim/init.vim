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
j
if !exists('g:vscode')
	" Normal mapping
	" nnoremap <silent> <leader>c :Denite colorscheme<CR>
	" nnoremap <silent> <leader>b :Denite buffer<CR>
	" nnoremap <silent> <leader>a :Denite grep:::!<CR>
	" nnoremap <silent> <leader>u :call dein#update()<CR>
	" map <silent> <leader>gd :TSDoc <cr>
	" map <silent> <leader>gt :TSType <cr>
	" map <silent> <leader>@ :Denite -buffer-name=TSDocumentSymbol TSDocumentSymbol <cr>
	" map <silent> <leader># :Denite -buffer-name=TSWorkspaceSymbol TSWorkspaceSymbol <cr>


	" Terminal mapping
	tmap <esc> <c-\><c-n><esc><cr>

	" buffer management inside the terminal
	tmap <leader>, <C-\><C-n>:bnext<cr>
	tmap <leader>. <C-\><C-n>:bprevious<CR>

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
	:autocmd InsertEnter * set cul
	:autocmd InsertLeave * set nocul

	" Tex ------------------------{{{
	let g:vimtex_compiler_progname='nvr'
	" }}}

	" Tmux navigation` -----------------------------------------------------------{{{
	tmap <C-j> <C-\><C-n>:TmuxNavigateDown<cr>
	tmap <C-k> <C-\><C-n>:TmuxNavigateUp<cr>
	tmap <C-l> <C-\><C-n>:TmuxNavigateRight<cr>
	tmap <C-h> <C-\><C-n>:TmuxNavigateLeft<CR>
	tmap <C-;> <C-\><C-n>:TmuxNavigatePrevious<cr>
	tmap <leader>x <c-\><c-n>:bp! <BAR> bd! #<CR>
	tmap <leader>1  <C-\><C-n><Plug>AirlineSelectTab1
	tmap <leader>2  <C-\><C-n><Plug>AirlineSelectTab2
	tmap <leader>3  <C-\><C-n><Plug>AirlineSelectTab3
	tmap <leader>4  <C-\><C-n><Plug>AirlineSelectTab4
	tmap <leader>5  <C-\><C-n><Plug>AirlineSelectTab5
	tmap <leader>6  <C-\><C-n><Plug>AirlineSelectTab6
	tmap <leader>7  <C-\><C-n><Plug>AirlineSelectTab7
	tmap <leader>8  <C-\><C-n><Plug>AirlineSelectTab8
	tmap <leader>9  <C-\><C-n><Plug>AirlineSelectTab9
	"----------------------------------------------------------------------------}}}

	" Plugin key-mappings.

	" Note: It must be "imap" and "smap".  It uses <Plug> mappings.
	imap <F1>     <Plug>(neosnippet_expand_or_jump)
	smap <F1>     <Plug>(neosnippet_expand_or_jump)
	xmap <F1>     <Plug>(neosnippet_expand_target)

	" SuperTab like snippets behavior.
	" Note: It must be "imap" and "smap".  It uses <Plug> mappings.
	imap <expr><TAB>
				\ pumvisible() ? "\<C-n>" :
				\ neosnippet#expandable_or_jumpable() ?
				\    "\<Plug>(neosnippet_expand_or_jump)" : "\<TAB>"
	smap <expr><TAB> neosnippet#expandable_or_jumpable() ?
				\ "\<Plug>(neosnippet_expand_or_jump)" : "\<TAB>"



	" Code formatting -----------------------------------------------------------{{{

	" ,f to format code, requires formatters: read the docs
	noremap <silent> <leader><leader>f :Neoformat<CR>
	let g:standard_prettier_settings = {
				\ 'exe': 'prettier',
				\ 'args': ['--stdin', '--stdin-filepath', '%:p', '--single-quote'],
				\ 'stdin': 1,
				\ }
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

	"hi link ALEError SpellBad
	"hi link ALEWarning SpellBad
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

let g:neoformat_markdown_prettier = g:standard_prettier_settings
let g:neoformat_enabled_markdown = ['prettier']

"}}}

" Javascript ----------------------------------------------------------------{{{

" let g:tigris#enabled = 1
" let $NVIM_NODE_LOG_FILE='nvim-node.log'
" let $NVIM_NODE_HOST_DEBUG=1
let g:neoformat_javascript_prettier = g:standard_prettier_settings
let g:neoformat_enabled_javascript = ['prettier']
let g:neomake_javascript_enabled_makers = ['eslint']
let g:jsx_ext_required = 1
let g:jsdoc_allow_input_prompt = 1
let g:jsdoc_input_description = 1
let g:jsdoc_return=0
let g:jsdoc_return_type=0
let g:vim_json_syntax_conceal = 0
" let g:tern#command = ['tern']
" let g:tern#arguments = ['--persistent']
" let g:tern_map_keys=1
" autocmd FileType typescript setl omnifunc=TSComplete
" let g:nvim_typescript#signature_complete=1
" let g:nvim_typescript#max_completion_detail=100
" let g:nvim_typescript#completion_mark=''
" let g:nvim_typescript#default_mappings=1
" let g:nvim_typescript#type_info_on_hold=1
" let g:nvim_typescript#javascript_support=1
" let g:nvim_typescript#vue_support=1
" let g:ale_linters = {
" \   'typescript': ['tsserver', 'tslint'],
" \}


" let g:neomake_typescript_enabled_makers = ['tsc', 'tslint']
" let g:neoformat_typescript_prettier = g:standard_prettier_settings
" let g:neoformat_enabled_typescript = ['prettier']

" let g:neomake_typescript_enabled_makers = ['nvim_ts']

" 			\ 'class': '',
" 			\ 'interface': '',
" 			\ 'script': 'script',
" 			\ 'module': '',
" 			\ 'local class': 'local class',
" 			\ 'type': '',
" 			\ 'enum': '',
" 			\ 'enum member': '',
" 			\ 'alias': '',
" 			\ 'type parameter': 'type param',
" 			\ 'primitive type': 'primitive type',
" 			\ 'var': '',
" 			\ 'local var': '',
" 			\ 'property': '',
" 			\ 'let': '',
" 			\ 'const': '',
" 			\ 'label': 'label',
" 			\ 'parameter': 'param',
" 			\ 'index': 'index',
" 			\ 'function': '',
" 			\ 'local function': 'local function',
" 			\ 'method': '',
" 			\ 'getter': '',
" 			\ 'setter': '',
" 			\ 'call': 'call',
" 			\ 'constructor': '',
" 			\}
" }}}

" HTML ----------------------------------------------------------------------{{{

let g:neomake_html_enabled_makers = []
let g:neoformat_enabled_html = ['htmlbeautify']

" }}}


" CSS -----------------------------------------------------------------------{{{

" let g:neoformat_scss_prettier = g:standard_prettier_settings
" let g:neoformat_enabled_scss = ['prettier']
" let g:neomake_scss_enabled_makers = ['scsslint']

"}}}




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

