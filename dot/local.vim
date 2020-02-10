"" --------------------------------
"" Common settings for vim and nvim
"" --------------------------------

""*************************************************************
"" General settings
""*************************************************************
let mapleader = ' '

filetype on
syntax on

if has('termguicolors')
	set termguicolors
endif

"" mouse settings
set mouse=a
set mousemodel=popup

set encoding=utf-8
set fileencoding=utf-8
set fileencodings=utf-8

set hidden
set clipboard+=unnamedplus
set nopaste
set noshowmode
set tabstop=4 shiftwidth=4 expandtab
set conceallevel=0
set virtualedit=
set wildmenu
set laststatus=2
set wrap linebreak nolist
set wildmode=full
set autoread
set updatetime=500
set fillchars+=vert:│
set bomb
set binary
set relativenumber number
set numberwidth=1
set backspace=indent,eol,start
set hlsearch
set incsearch
set ignorecase
set smartcase
set complete=.,w,b,u,t,k
set formatoptions+=t
set shortmess=atIc
set isfname-==
set nospell
set splitbelow
set completeopt+=noselect,menuone
set completeopt-=preview
"" Directories for swp files
set nobackup
set noswapfile
set fileformats=unix,mac,dos
set autoread
set lazyredraw

" folding
set foldable
set foldlevelstart=99
set foldnextmax=12
nnoremap <space> za
set foldmethod=indent

augroup vimrc
  au BufReadPre * setlocal foldmethod=indent
  au BufWinEnter * if &fdm == 'indent' | setlocal foldmethod=manual | endif
augroup END

if exists('$SHELL')
	set shell=$SHELL
else
	set shell=/bin/sh
endif
set undofile
set undodir="$HOME/.VIM_UNDO_FILES"
syntax on
set ruler
" set nowrap

"" Disable the blinking cursor.
set gcr=a:blinkon0
set scrolloff=3

"" Status bar
set laststatus=2

"" Use modeline overrides
set modeline
set modelines=10
set title
set titleold="Terminal"
set titlestring=%F

""*************************************************************
"" Mappings
""*************************************************************

"" --------------------
"" General mappings
"" --------------------

noremap  <silent> <Home> g<Home>
noremap  <silent> <End>  g<End>

"" --------------------
"" Insert mode mappings
"" --------------------

"" duplicate a line
inoremap <C-d> <Esc>yyPji

"" Navigate between display lines
"" why <C-o> instead of <Esc>
inoremap <silent> <Home> <C-o>g<Home>
inoremap <silent> <End>  <C-o>g<End>

"" insert mode
inoremap <C-a> <C-o>:call <SID>home()<CR>
inoremap <C-e> <End>
inoremap <M-Left> <Esc>ba
inoremap <M-Right> <Esc>wa

" Split management
inoremap <C-h> <ESC><C-w>h
inoremap <C-j> <ESC><C-w>j
inoremap <C-k> <ESC><C-w>k
inoremap <C-l> <ESC><C-w>l
inoremap <C-Left> <ESC><C-w>h
inoremap <C-Down> <ESC><C-w>j
inoremap <C-Up> <ESC><C-w>k
inoremap <C-Right> <ESC><C-w>l
inoremap <C--> <esc>:only<cr>a
inoremap <C-\> <esc><C-w>_
inoremap <C-=> <esc><C-w>=
inoremap <C-q> <esc><C-w>c	

if has('macunix')
	inoremap <D-c> <Esc>yy
	inoremap <D-v> <Esc>Pa
endif

" ALlow shift-arrows to be used for selection
inoremap <S-Down> <Esc>lvj
inoremap <S-Up> <Esc>lvk
inoremap <S-Left> <Esc>lvh
inoremap <S-Right> <Esc>lvl

"" --------------------
"" Normal mode mappings
"" --------------------
" copy to end using Y because we cut to end with D

nnoremap <M-O> <S-O><Esc>j
nnoremap Y y$

if has('nvim')
	nnoremap <leader><leader>v :e ~/.local.vim<CR>:vsplit ~/.config/nvim/init.vim<CR>
else
	nnoremap <leader><leader>v :e ~/.local.vim<CR>:vsplit ~/.vimrc<CR>
endif
if has('nvim')
	nnoremap <leader><leader>p :e ~/.vim/common_plugins<CR>:vsplit ~/.vim/nvim_plugins<CR>
else
	nnoremap <leader><leader>p :e ~/.vim/common_plugins<CR>:vsplit ~/.vim/vim_plugins<CR>
endif

if !exists('g:vscode')
	"" function keys
	nnoremap <silent> <leader>nf :NERDTreeFind<CR>
	nnoremap <silent> <leader>nt :NERDTreeToggle<CR>
	nnoremap <silent> <leader>g :TagbarToggle<CR>

	nnoremap <silent> <S-F3> :NERDTreeFind<CR>
	nnoremap <silent> <F3> :NERDTreeToggle<CR>
	nnoremap <silent> <F4> :TagbarToggle<CR>

	let g:UltiSnipsExpandTrigger="<C-p>"
	let g:UltiSnipsJumpForwardTrigger="<C-p>"
	let g:UltiSnipsJumpBackwardTrigger="<C-n>"

	set pastetoggle=<F6>
endif 

"" Navigate between display lines
nnoremap <silent><expr>k      v:count == 0 ? 'gk' : 'k'
nnoremap <silent><expr>j      v:count == 0 ? 'gj' : 'j'
nnoremap <silent><expr><Up>   v:count == 0 ? 'gk' : 'k'
nnoremap <silent><expr><Down> v:count == 0 ? 'gj' : 'j'

"" copy current file path to clipboard
nnoremap cp :let @+= expand("%") <cr>

"" Search mappings: These will make it so that going to the next one in a
"" search will center on the line it is found in.
nnoremap n nzzzv
nnoremap N Nzzzv

"" removing search highlighting using <esc>
nnoremap <silent> <esc> :noh<cr>

"" a map to delete to the blackhole _ register (no cutting)
nnoremap <leader>d "_d

"" Align blocks of text and keep them selected
"nnoremap <leader>a :call <SID>SynStack()<CR>

"" Space to toggle folds.
nnoremap <Space> za

"" Git
"" noremap <Leader>ga :Gwrite<CR>
"" noremap <Leader>gc :Gcommit<CR>
"" noremap <Leader>gsh :Gpush<CR>
"" noremap <Leader>gpu :Gpull<CR>
"" noremap <Leader>gs :Gstatus<CR>
"" noremap <Leader>gb :Gblame<CR>
"" noremap <Leader>gd :Gvdiff<CR>
"" noremap <Leader>gr :Gremove<CR>
"" nnoremap <leader>gm :Magit<CR>
"" nnoremap <Leader>go :.Gbrowse<CR>

if !exists('g:vscode')
	"" Opens an edit command with the path of the currently edited file filled in
	noremap <Leader>E :e <C-R>=expand("%:p:h") . "/" <CR>

	"" Opens a tab edit command with the path of the currently edited file filled
	noremap <Leader>te :tabe <C-R>=expand("%:p:h") . "/" <CR>
endif

"" FZF shortcuts
nnoremap <silent> <leader>b :Buffers<CR>uun
nnoremap <silent> <leader>e :FZF -m<CR>
nnoremap <silent> <leader>F :FZF -m<CR>

"" terminal emulation
nnoremap <silent> <leader>sh :terminal<CR>

"" Clean search (highlight)
nnoremap <silent> <leader><leader> :noh<cr>

" Buffer management
noremap <leader>c :bd<CR>
nmap <leader>, :bnext<CR>
nmap <leader>. :bprevious<CR>

" WINDOW MANAGEMENT SETTINGS
if !exists('g:vscode')
	" noremap <Leader>- :<C-u>split<CR>
	" noremap <Leader>| :<C-u>vsplit<CR>
	nnoremap <leader>o :only<cr>
	nnoremap <leader>w= <C-w>=
	nnoremap <leader>q :wincmd q<cr>
	nnoremap <leader>h     :call WinMove('h')<cr>
	nnoremap <leader>k     :call WinMove('k')<cr>
	nnoremap <leader>l     :call WinMove('l')<cr>
	nnoremap <leader>j     :call WinMove('j')<cr>
	nnoremap <leader><Left> :call WinMove('h')<cr>
	nnoremap <leader><Down> :call WinMove('j')<cr>
	nnoremap <leader><Up> :call WinMove('k')<cr>
	nnoremap <leader><Right> :call WinMove('l')<cr>
	nnoremap <leader>H              :wincmd H<cr>
	nnoremap <leader>K              :wincmd K<cr>
	nnoremap <leader>L              :wincmd L<cr>
	nnoremap <leader>J              :wincmd J<cr>

	"" "open new blank file
	nnoremap o<C-h> :lefta vsp new<cr>
	nnoremap o<C-j> :bel sp new<cr>
	nnoremap o<C-k> :abo sp new<cr>
	nnoremap o<C-l> :rightb vsp new<cr>
endif 

" comment
if has('macunix')
	nnoremap <D-/> :TComment<cr>
else
	nnoremap <C-/> :TComment<cr>
endif

" allow shift arrows to copy
nnoremap <S-Down> vj
nnoremap <S-Up> vk
nnoremap <S-Left> vh
nnoremap <S-Right> vl

" insert from mac keyboard in normal mode
if has('macunix')
	" pbcopy for OSX copy/paste
	nmap <D-v> :r !pbpaste<cr>
endif
"" --------------------
"" Visual mode mappings
"" --------------------
vnoremap <S-Down> j
vnoremap <S-Up> k
vnoremap <S-Left> h
vnoremap <S-Right> l

vmap < <gv
vmap > >gv
vnoremap <leader>d "_d
if has('macunix')
	vnoremap <D-/> :TComment<cr>
else
	vnoremap <C-/> :TComment<cr>
endif 
vnoremap <leader>ga <Plug>(EasyAlign)
vnoremap <C-c> "*y<CR>
vnoremap y "*y<CR>
vnoremap y myy`y
vnoremap Y myY`y
vnoremap // y/<C-R>"<CR>

"" Space to toggle folds.
vnoremap <Space> za

if has('macunix')
	" pbcopy for OSX copy/paste
	vmap <D-v> :r !pbpaste<CR>
	vmap <D-c> :w !pbcopy<CR><CR>
endif

"" Vmap for maintain Visual Mode after shifting > and <
vmap < <gv
vmap > >gv

"" Move visual block
vnoremap J :m '>+1<CR>gv=gv
vnoremap K :m '<-2<CR>gv=gv

"" "" C mappings
"" "" ----------
"" "" Basic cursor movement and deletion keybindings from emacs, for vim.
"" "" command line mode
cnoremap <C-a> <Home>
cnoremap <C-e> <End>
cnoremap <C-d> <Del>
cnoremap <C-h> <BS>
cnoremap <M-j> :call split_line_text_at_cursor()<CR>

"" no one is really happy until you have this shortcuts
cnoreabbrev W! w!
cnoreabbrev Q! q!
cnoreabbrev Qall! qall!
cnoreabbrev Wq wq
cnoreabbrev Wa wa
cnoreabbrev wQ wq
cnoreabbrev WQ wq
cnoreabbrev W w
cnoreabbrev Q q
cnoreabbrev Qall qall
"" cnoremap <C-P> <C-R>=expand("%:p:h") . "/" <CR>


"" allow saving to protected file using sudo without leaving vim
cmap w!! w !sudo tee % >/dev/null

""*************************************************************
"" Auto-mappings and related settings
""*************************************************************

"" auto-mappings
"" automatic sourcing of this file after writing
autocmd! bufwritepost ~/.local.vim source %
autocmd! bufwritepost ~/.vimrc source %
if has('nvim')
	autocmd! bufwritepost ~/.config/nvim/init.vim source %
	autocmd! bufwritepost ~/.local.vim source ~/.config/nvim/init.vim
else
	autocmd! bufwritepost ~/.local.vim source ~/.vimrc
endif


"" remove trailing whitespaces before writing a file
autocmd BufWritePre * %s/\s\+$//e

"" Remember cursor position between vim sessions
autocmd BufReadPost *
	\ if line("'\"") > 0 && line ("'\"") <= line("$") |
	\   exe "normal! g'\"" |
	\ endif

"" center buffer around cursor when opening files
autocmd BufRead * normal zz

"" set updatetime=500
" autocmd InsertEnter * let save_cwd = getcwd() | set autochdir
" autocmd InsertLeave * set noautochdir | execute 'cd' fnameescape(save_cwd)

let no_buffers_menu=1

"" underline current line
set cursorline
highlight CursorLine gui=underline cterm=underline

"" customize search results colors
highlight Search ctermbg=DarkBlue ctermfg=Yellow guibg=DarkBlue guifg=Yellow

"" GUI only options
if has('gui_running')
	set guioptions=egmrti
	set gfn=SourceCodePro\ Nerd\ Font
	set guicursor=n-v-c-sm:block,i-ci-ve:ver25,r-cr-o:hor20
" else
" 	set t_Co=256
endif

" if !exists('g:not_finish_vimplug')
	"colorscheme molokai
	" colorscheme OceanicNext
colorscheme solarized
set background=dark

if has("gui_running")
	let g:indentLine_color_gui = '#343d46'
	set guifont=SourceCodePro\ Nerd\ Font:h14
	if has("gui_mac") || has("gui_macvim")
		set transparency=0
	endif
	let g:indentLine_char="|"
	" let g:indentLine_char="⎸"
else
	let g:CSApprox_loaded = 1

	" IndentLine
	let g:indentLine_enabled = 1
	let g:indentLine_concealcursor = 0
	let g:indentLine_char = '┆'
	let g:indentLine_faster = 1
endif

if !exists('g:vscode')
	"" The PC is fast enough, do syntax highlight syncing from start unless 200 lines
	augroup vimrc-sync-fromstart
		autocmd!
		autocmd BufEnter * :syntax sync maxlines=200
	augroup END

	"" Remember cursor position
	augroup vimrc-remember-cursor-position
		autocmd!
		autocmd BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g`\"" | endif
	augroup END

	"" txt
	augroup vimrc-wrapping
		autocmd!
		autocmd BufRead,BufNewFile *.txt call s:setupWrapping()
	augroup END

	"" "" make/cmake
	"" augroup vimrc-make-cmake
	"" 	autocmd!
	"" 	autocmd FileType make setlocal noexpandtab
	"" 	autocmd BufNewFile,BufRead CMakeLists.txt setlocal filetype=cmake
	"" augroup END

	" Disable visualbell
	set noerrorbells visualbell t_vb=
	if has('autocmd')
		autocmd GUIEnter * set visualbell t_vb=
	endif

	"" Copy/Paste/Cut
	if has('unnamedplus')
		set clipboard=unnamed,unnamedplus
	endif

	""*************************************************************
	"" Other settings (for plugins etc)
	""*************************************************************

	"" Operation management
	""*************************************************************

	"" session management ----------------------------------------------------{{{
	if has('nvim')
		let g:session_directory = "~/.config/nvim/session"
	else
		let g:session_directory = "~/.vim/session"
	endif

	let g:session_autoload = "no"
	let g:session_autosave = "no"
	let g:session_command_aliases = 0
	"----------------------------------------------------------------------------}}}


	"" session management ----------------------------------------------------{{{
	let g:auto_save = 0  " enable AutoSave on Vim startup
	let g:auto_save_no_updatetime = 1  " do not change the 'updatetime' option
	let g:auto_save_silent = 0  " do not display the auto-save notification
	let g:auto_save_postsave_hook = 'TagsGenerate'  " this will run :TagsGenerate after each save
	"----------------------------------------------------------------------------}}}

	"" "" MultiCursor ---------------------------------------------------------------{{{
	"" let g:multi_cursor_exit_from_visual_mode=0
	"" let g:multi_cursor_exit_from_insert_mode=0
	"" let g:multi_cursor_next_key='<C-n>'
	"" let g:multi_cursor_prev_key='<C-p>'
	"" let g:multi_cursor_skip_key='<C-x>'
	"" let g:multi_cursor_quit_key='<Esc>'
	"" "-----------------------------------------------------------------------------}}}
	"" 
	" Git ------------------------------------------------------------------------{{{
	set signcolumn=yes
	let g:conflict_marker_enable_mappings = 0
	let g:gitgutter_sign_added = '│'
	let g:gitgutter_sign_modified = '│'
	let g:gitgutter_sign_removed = '│'
	let g:gitgutter_sign_removed_first_line = '│'
	let g:gitgutter_sign_modified_removed = '│'
	"-----------------------------------------------------------------------------}}}

	" Easy Git -------------------------------------------------------------------{{{
	"" let g:easygit_enable_command = 0
	"-----------------------------------------------------------------------------}}}

	"" NERDTree configuration ----------------------------------------------------{{{
	let g:NERDTreeChDirMode=2
	let g:NERDTreeIgnore=['\.rbc$', '\~$', '\.pyc$', '\.db$', '\.sqlite$', '__pycache__']
	let g:NERDTreeSortOrder=['^__\.py$', '\/$', '*', '\.swp$', '\.bak$', '\~$']
	let g:NERDTreeShowBookmarks=1
	let g:nerdtree_tabs_focus_on_files=1
	let g:NERDTreeMapOpenInTabSilent = '<RightMouse>'
	let g:NERDTreeWinSize = 50
	set wildignore+=*/tmp/*,*.so,*.swp,*.zip,*.pyc,*.db,*.sqlite

	let NERDTreeShowHidden=1
	let g:NERDTreeWinSize=45
	let NERDTreeMinimalUI=1
	let NERDTreeHijackNetrw=1
	let NERDTreeCascadeSingleChildDir=0
	let NERDTreeCascadeOpenSingleChildDir=0
	let g:NERDTreeAutoDeleteBuffer=1
	let g:NERDTreeShowIgnoredStatus = 0
	let g:NERDTreeDirArrowExpandable = '>'
	let g:NERDTreeDirArrowCollapsible = '-'
	"-----------------------------------------------------------------------------}}}

	" grep.vim -------------------------------------------------------------------{{{
	nnoremap <silent> <leader>f :Rgrep<CR>
	let Grep_Default_Options = '-IR'
	let Grep_Skip_Files = '*.log *.db'
	let Grep_Skip_Dirs = '.git node_modules'
	"-----------------------------------------------------------------------------}}}

	"" Navigate between vim buffers and tmux panels ------------------------------{{{
	let g:tmux_navigator_no_mappings = 0
	"----------------------------------------------------------------------------}}}


	"" Language settings
	""******************************************************************************

	" Java ----------------------------------------------------------------------{{{
	autocmd FileType java setlocal omnifunc=javacomplete#Complete
	" let g:deoplete#sources#clang#libclang_path="/usr/local/Cellar/llvm/HEAD-74479e8/lib/libclang.dylib"
	" let g:deoplete#sources#clang#clang_header="/usr/bin/clang"
	"----------------------------------------------------------------------------}}}

	" Python --------------------------------------------------------------------{{{
	let g:python_host_prog = '<<nvimpy2>>'
	let g:python3_host_prog = '<<nvimpy3>>'
	" let $NVIM_PYTHON_LOG_FILE='nvim-python.log'

	" vim-python
	augroup vimrc-python
		autocmd!
		autocmd FileType python setlocal expandtab shiftwidth=4 tabstop=8 colorcolumn=79
					\ formatoptions+=croq softtabstop=4
					\ cinwords=if,elif,else,for,while,try,except,finally,def,class,with
	augroup END

	" jedi-vim
	let g:jedi#auto_vim_configuration = 1
	let g:jedi#completions_enabled = 0
	let g:jedi#popup_on_dot = 0
	let g:jedi#goto_assignments_command = "<leader>a"
	let g:jedi#goto_definitions_command = "<leader>g"
	let g:jedi#documentation_command = "<F1>"
	let g:jedi#usages_command = "<leader>n"
	let g:jedi#rename_command = "<F2>"
	let g:jedi#show_call_signatures = "1"
	let g:jedi#completions_command = "<C-p>"
	let g:jedi#smart_auto_mappings = 0

	" Syntax highlight
	" Default highlight is better than polyglot
	let g:polyglot_disabled = ['python']
	let python_highlight_all = 1

	"----------------------------------------------------------------------------}}}

	"" Visual Settings
	""*****************************************************************************

		"" Themes, Commands, etc  ----------------------------------------------------{{{
		" let g:oceanic_next_terminal_bold = 1
		" let g:oceanic_next_terminal_italic = 1
		" let g:oceanic_next_highlight_current_line =0
		" colorscheme OceanicNext
		" colorscheme one
		" set background=dark
		"----------------------------------------------------------------------------}}}
	" endif

	"" Vim-Devicons -------------------------------------------------------------{{{
	let g:NERDTreeGitStatusNodeColorization = 1
	"" 
	let g:webdevicons_enable_denite = 0
	" let g:WebDevIconsUnicodeDecorateFileNodesExtensionSymbols['vim'] = ''
	let g:WebDevIconsUnicodeDecorateFolderNodesDefaultSymbol = ''
	let g:WebDevIconsOS = 'Darwin'
	let g:WebDevIconsUnicodeDecorateFolderNodes = 1
	let g:WebDevIconsUnicodeDecorateFileNodesDefaultSymbol = ''
	let g:WebDevIconsUnicodeDecorateFolderNodes = 1
	let g:WebDevIconsUnicodeDecorateFolderNodesDefaultSymbol = ''
	let g:WebDevIconsUnicodeDecorateFileNodesExtensionSymbols = {}
	let g:WebDevIconsUnicodeDecorateFileNodesExtensionSymbols['js'] = ''
	let g:WebDevIconsUnicodeDecorateFileNodesExtensionSymbols['tsx'] = ''
	let g:WebDevIconsUnicodeDecorateFileNodesExtensionSymbols['css'] = ''
	let g:WebDevIconsUnicodeDecorateFileNodesExtensionSymbols['html'] = ''
	let g:WebDevIconsUnicodeDecorateFileNodesExtensionSymbols['json'] = ''
	let g:WebDevIconsUnicodeDecorateFileNodesExtensionSymbols['md'] = ''
	let g:WebDevIconsUnicodeDecorateFileNodesExtensionSymbols['sql'] = ''
	"----------------------------------------------------------------------------}}}

	" vim-airline ---------------------------------------------------------------{{{
	let g:airline#extensions#virtualenv#enabled = 1

	if !exists('g:airline_symbols')
		let g:airline_symbols = {}
	endif

	let g:webdevicons_enable_airline_statusline = 0

	let g:airline#extensions#tabline#enabled = 1
	let g:airline#extensions#mike#enabled = 1
	let g:airline#extensions#tabline#fnamemod = ':t'
	let g:airline#extensions#tabline#buffer_idx_mode = 1
	let g:airline_powerline_fonts = 1
	let g:airline_symbols.branch = ''
	let g:airline_theme='oceanicnext'
	nmap <leader>1 <Plug>AirlineSelectTab1
	nmap <leader>2 <Plug>AirlineSelectTab2
	nmap <leader>3 <Plug>AirlineSelectTab3
	nmap <leader>4 <Plug>AirlineSelectTab4
	nmap <leader>5 <Plug>AirlineSelectTab5
	nmap <leader>6 <Plug>AirlineSelectTab6
	nmap <leader>7 <Plug>AirlineSelectTab7
	nmap <leader>8 <Plug>AirlineSelectTab8
	nmap <leader>9 <Plug>AirlineSelectTab9
	let g:airline#extensions#branch#format = 0
	let g:airline_detect_spelllang=0
	let g:airline_detect_spell=0
	let g:airline#extensions#hunks#enabled = 0
	let g:airline#extensions#wordcount#enabled = 0
	let g:airline#extensions#whitespace#enabled = 0
	" let g:airline_section_c = '%f%m'
	" let g:airline_section_x = ''
	let g:airline_section_y = ''
	" let g:airline_section_z = '%l:%v'
	" let g:airline_section_z = '%{LineNoIndicator()} :%2c'
	" let g:line_no_indicator_chars = [' ', '▁', '▂', '▃', '▄', '▅', '▆', '▇', '█']
	let g:line_no_indicator_chars = ['⎺', '⎻', '⎼', '⎽', '_']
	let g:airline_mode_map = {
				\ 'n'  : '',
				\ 'i' : '',
				\ 'R' : '',
				\ 'v' : '',
				\ 'V' : '',
				\ 'c' : '',
				\ 's' : '',
				\ 'S' : '',
				\ ''  : '',
				\ 't' : '',
				\}
	let g:airline#extensions#tabline#buffer_idx_format = {
				\ '0': '0 ',
				\ '1': '1 ',
				\ '2': '2 ',
				\ '3': '3 ',
				\ '4': '4 ',
				\ '5': '5 ',
				\ '6': '6 ',
				\ '7': '7 ',
				\ '8': '8 ',
				\ '9': '9 ',
				\}


	if !exists('g:airline_powerline_fonts')
		let g:airline#extensions#tabline#left_sep = ' '
		let g:airline#extensions#tabline#left_alt_sep = '|'
		let g:airline_left_sep          = '▶'
		let g:airline_left_alt_sep      = '»'
		let g:airline_right_sep         = '◀'
		let g:airline_right_alt_sep     = '«'
		let g:airline#extensions#branch#prefix     = '⤴' "➔, ➥, ⎇
		let g:airline#extensions#readonly#symbol   = '⊘'
		let g:airline#extensions#linecolumn#prefix = '¶'
		let g:airline#extensions#paste#symbol      = 'ρ'
		let g:airline_symbols.linenr    = '␊'
		let g:airline_symbols.branch    = '⎇'
		let g:airline_symbols.paste     = 'ρ'
		let g:airline_symbols.paste     = 'Þ'
		let g:airline_symbols.paste     = '∥'
		let g:airline_symbols.whitespace = 'Ξ'
	else
		let g:airline#extensions#tabline#left_sep = ''
		let g:airline#extensions#tabline#left_alt_sep = ''

		" powerline symbols
		let g:airline_left_sep = ''
		let g:airline_left_alt_sep = ''
		let g:airline_right_sep = ''
		let g:airline_right_alt_sep = ''
		let g:airline_symbols.branch = ''
		let g:airline_symbols.readonly = ''
		let g:airline_symbols.linenr = ''
	endif
	"----------------------------------------------------------------------------}}}

	" Fold, gets it's own section  ----------------------------------------------{{{
	set foldtext=MyFoldText()
	autocmd InsertEnter * if !exists('w:last_fdm') | let w:last_fdm=&foldmethod | setlocal foldmethod=manual | endif
	autocmd InsertLeave,WinLeave * if exists('w:last_fdm') | let &l:foldmethod=w:last_fdm | unlet w:last_fdm | endif

	" autocmd FileType vim setlocal fdc=1
	set foldlevel=99

	autocmd FileType vim setlocal foldmethod=marker
	autocmd FileType vim setlocal foldlevel=0
	autocmd FileType javascript,html,css,scss,typescript setlocal foldlevel=99
	autocmd FileType css,scss,json setlocal foldmethod=marker
	autocmd FileType css,scss,json setlocal foldmarker={,}
	autocmd FileType coffee setl foldmethod=indent
	let g:xml_syntax_folding = 1
	autocmd FileType xml setl foldmethod=syntax
	autocmd FileType html setl foldmethod=expr
	autocmd FileType html setl foldexpr=HTMLFolds()
	autocmd FileType javascript,typescript,json setl foldmethod=syntax
	"----------------------------------------------------------------------------}}}

	" Git Fugitive --------------------------------------------------------------{{{
	if exists("*fugitive#statusline")
		set statusline+=%{fugitive#statusline()}
	endif
	"----------------------------------------------------------------------------}}}

	" vimshell.vim --------------------------------------------------------------{{{
	let g:vimshell_user_prompt = 'fnamemodify(getcwd(), ":~")'
	let g:vimshell_prompt =  '$ '
	"----------------------------------------------------------------------------}}}

	"" fzf.vim ------------------------------------------------------------------{{{
	set wildmode=list:longest,list:full
	set wildignore+=*.o,*.obj,.git,*.rbc,*.pyc,__pycache__
	let $FZF_DEFAULT_COMMAND =  "find * -path '*/\.*' -prune -o -path 'node_modules/**' -prune -o -path 'target/**' -prune -o -path 'dist/**' -prune -o  -type f -print -o -type l -print 2> /dev/null"
	"----------------------------------------------------------------------------}}}

	" The Silver Searcher -------------------------------------------------------{{{
	if executable('ag')
		let $FZF_DEFAULT_COMMAND = 'ag --hidden --ignore .git -g ""'
		set grepprg=ag\ --nogroup\ --nocolor
	endif
	"----------------------------------------------------------------------------}}}

	" ripgrep -------------------------------------------------------------------{{{
	if executable('rg')
		let $FZF_DEFAULT_COMMAND = 'rg --files --hidden --follow --glob "!.git/*"'
		set grepprg=rg\ --vimgrep
		command! -bang -nargs=* Find call fzf#vim#grep('rg --column --line-number --no-heading --fixed-strings --ignore-case --hidden --follow --glob "!.git/*" --color "always" '.shellescape(<q-args>).'| tr -d "\017"', 1, <bang>0)
	endif
	"----------------------------------------------------------------------------}}}

	" snippets ------------------------------------------------------------------{{{
	let g:UltiSnipsEditSplit="vertical"

	"----------------------------------------------------------------------------}}}

	" syntastic -----------------------------------------------------------------{{{
	let g:syntastic_always_populate_loc_list=1
	let g:syntastic_error_symbol='✗'
	let g:syntastic_warning_symbol='⚠'
	let g:syntastic_style_error_symbol = '✗'
	let g:syntastic_style_warning_symbol = '⚠'
	let g:syntastic_auto_loc_list=1
	let g:syntastic_aggregate_errors = 1
	"----------------------------------------------------------------------------}}}

	" Tagbar --------------------------------------------------------------------{{{
	let g:tagbar_autofocus = 1
	"----------------------------------------------------------------------------}}}

	" Easy search ---------------------------------------------------------------{{{
	let g:esearch#cmdline#help_prompt = 1
	let g:esearch#cmdline#dir_icon = '  '
	let g:esearch = {
				\ 'adapter':    'ag',
				\ 'backend':    'nvim',
				\ 'use':        ['visual', 'hlsearch', 'last'],
				\}
	"----------------------------------------------------------------------------}}}

	" command-T window ----------------------------------------------------------{{{
	let g:CommandTCursorLeftMap  = ['<Left>',  '<C-b>']
	let g:CommandTCursorRightMap = ['<Right>', '<C-f>']
	let g:CommandTBackspaceMap   = ['<BS>',    '<C-h>']
	let g:CommandTDeleteMap      = ['<Del>',   '<C-d>']
	"----------------------------------------------------------------------------}}}


	""*****************************************************************************
	"" Functions
	""*****************************************************************************

	if !exists('*s:setupWrapping')
		function s:setupWrapping()
			set wrap
			set wm=2
			set textwidth=79
		endfunction
	endif
	function! MyFoldText() " {{{
		let line = getline(v:foldstart)
		let nucolwidth = &fdc + &number * &numberwidth
		let windowwidth = winwidth(0) - nucolwidth - 3
		let foldedlinecount = v:foldend - v:foldstart

		" expand tabs into spaces
		let onetab = strpart('          ', 0, &tabstop)
		let line = substitute(line, '\t', onetab, 'g')

		let line = strpart(line, 0, windowwidth - 2 -len(foldedlinecount))
		" let fillcharcount = windowwidth - len(line) - len(foldedlinecount) - len('lines')
		" let fillcharcount = windowwidth - len(line) - len(foldedlinecount) - len('lines   ')
		let fillcharcount = windowwidth - len(line)
		" return line . '…' . repeat(" ",fillcharcount) . foldedlinecount . ' Lines'
		return line . '⋯'. repeat(" ",fillcharcount)
	endfunction "----------------------------------------------------------------------------}}}
	function! <SID>SynStack()
		if !exists("*synstack")
			return
		endif
		echo map(synstack(line('.'), col('.')), 'synIDattr(v:val, "name")')
	endfunc
	function! s:home()
		let start_col = col('.')
		normal! ^
		if col('.') == start_col
			normal! 0
		endif
		return ''
	endfunction

	function! s:kill_line()
		let [text_before_cursor, text_after_cursor] = s:split_line_text_at_cursor()
		if len(text_after_cursor) == 0
			normal! J
		else
			call setline(line('.'), text_before_cursor)
		endif
		return ''
	endfunction

	function! s:split_line_text_at_cursor()
		let line_text = getline(line('.'))
		let text_after_cursor  = line_text[col('.')-1 :]
		let text_before_cursor = (col('.') > 1) ? line_text[: col('.')-2] : ''
		return [text_before_cursor, text_after_cursor]
	endfunction

	function! WinMove(key)
	let t:curwin = winnr()
	exec "wincmd ".a:key
	if (t:curwin == winnr()) "we havent moved
		if (match(a:key,'[jk]')) "were we going up/down
		wincmd v
		else
		wincmd s
		endif
		exec "wincmd ".a:key
	endif
	endfunction
endif
