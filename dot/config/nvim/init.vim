" sane defaults
let mapleader = ' '

if !has('nvim')
	set nocompatible
endif
set noerrorbells visualbell t_vb=
" Disable visualbell
if has('autocmd')
	autocmd GUIEnter * set visualbell t_vb=
endif

"  Copy/Paste/Cut
if has('unnamedplus')
	set clipboard=unnamed,unnamedplus
endif
if has('nvim')
	set termguicolors
endif
set t_Co=256

"  mouse settings
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
set linebreak nolist
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
" set nospell
set splitbelow
set completeopt+=noselect,menuone
set completeopt-=preview
"  Directories for swp files
set nobackup
set noswapfile
set fileformats=unix,mac,dos
set autoread
set lazyredraw

" folding
set foldenable
set foldlevelstart=99
set foldnestmax=12
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
set nowrap

"  Disable the blinking cursor.
" set gcr=a:blinkon0
set scrolloff=3

"  Status bar
set laststatus=2

"  Use modeline overrides
set modeline
set modelines=10
set title
set titleold="Terminal"
set titlestring=%F

let g:make = 'gmake'
if exists('make')
    let g:make = 'make'
endif


" Install Plugins -----------------------------------------------------------{{{

" install Plug if needed
if has('nvim')
	let vimplug_exists=expand('~/.local/share/nvim/site/autoload/plug.vim')
else
	let vimplug_exists=expand('~/.vim/autoload/plug.vim')
endif
if !filereadable(vimplug_exists)
    if !executable("curl")
        echoerr "You have to install curl or first install vim-plug yourself!"
        execute "q!"
    endif
    echo "Installing Vim-Plug..."
	if has('nvim')
		silent !\curl -fLo ~/.local/share/nvim/site/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
	else
		silent !\curl -fLo ~/.vim/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
	endif
    let g:not_finish_vimplug = "yes"
    autocmd VimEnter * PlugInstall
endif

" Add Plug to the runtime path:
set rtp +=~/.config/nvim

function! Cond(cond, ...)
  let opts = get(a:000, 0, {})
  return a:cond ? opts : extend(opts, { 'on': [], 'for': [] })
endfunction

" define all plugins
call plug#begin(expand('~/.vim/plugged'))
	" if !exists('g:vscode')
	Plug 'asvetliakov/vim-easymotion', Cond(exists('g:vscode'))
	Plug 'easymotion/vim-easymotion', Cond(!exists('g:vscode'))
	Plug 'tpope/vim-surround'
	Plug 'tpope/vim-unimpaired'
	Plug 'tomtom/tcomment_vim'
	Plug 'tpope/vim-repeat'
	Plug 'junegunn/vim-easy-align'
	Plug 'jiangmiao/auto-pairs'
	Plug 'ervandew/supertab'
	if !exists('g:vscode')
		Plug 'Shougo/dein.vim', Cond(!exists('g:vscode'))
		Plug 'Shougo/denite.nvim'
		Plug 'Shougo/deol.nvim'
		Plug 'roxma/nvim-yarp', Cond(!has('nvim'))
		Plug 'roxma/vim-hug-neovim-rpc', Cond(!has('nvim'))
		if has('nvim')
			Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }
		else
			Plug 'Shougo/deoplete.nvim'
		endif
		Plug 'dense-analysis/ale'
		Plug 'Shougo/echodoc.vim'
		Plug 'Shougo/neco-vim'
		Plug 'Shougo/neoinclude.vim'
		Plug 'Shougo/neomru.vim'
		Plug 'zchee/deoplete-jedi'
		Plug 'vim-scripts/SyntaxRange'
		Plug 'ludovicchabant/vim-gutentags'
		Plug 'SirVer/ultisnips'
		Plug 'MartinLafreniere/vim-PairTools'
		Plug 'lervag/vimtex'
		Plug 'majutsushi/tagbar'
		Plug 'altercation/vim-colors-solarized'
		Plug 'mhartington/oceanic-next'
		Plug 'airblade/vim-gitgutter'
		Plug 'tpope/vim-fugitive'
		Plug 'davidhalter/jedi-vim', {'for': 'python'}
		Plug 'dhruvasagar/vim-table-mode'
		Plug 'elzr/vim-json'
		Plug 'flazz/vim-colorschemes'
		Plug 'scrooloose/nerdtree'
		Plug 'jistr/vim-nerdtree-tabs'
		Plug 'Xuyuanp/nerdtree-git-plugin'
		Plug 'sgeb/vim-diff-fold'
		Plug 'sheerun/vim-polyglot'
		Plug 'tmhedberg/SimpylFold', {'for': 'python'}
		Plug 'tpope/vim-markdown', {'for': 'markdown'}
		Plug 'nelstrom/vim-markdown-folding', {'for': 'markdown'}
		Plug 'vim-airline/vim-airline'
		Plug 'vim-airline/vim-airline-themes'
		Plug 'vim-scripts/grep.vim'
		Plug 'Yggdroot/indentLine'
		Plug 'vim-scripts/vim-auto-save'
		Plug 'vim-scripts/guicolorscheme.vim'
		Plug 'christoomey/vim-tmux-navigator'
	endif
	if isdirectory('/usr/local/opt/fzf')
		Plug '/usr/local/opt/fzf' | Plug 'junegunn/fzf.vim'
	else
		Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --bin' }
		Plug 'junegunn/fzf.vim'
	endif
call plug#end()
" }}}

" set inccommand=split


let $NVIM_TUI_ENABLE_CURSOR_SHAPE=1

" Mark the current line clearly
:autocmd InsertEnter * set cul
:autocmd InsertLeave * set nocul
if !exists('g:vscode')

	let g:airline#extensions#ale#error_symbol='• '
	let g:airline#extensions#ale#warning_symbol='•  '

	let g:airline#extensions#neomake#error_symbol='• '
	let g:airline#extensions#neomake#warning_symbol='•  '

" Write this in your vimrc file
	let g:ale_sign_warning = '•'
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

" deoplete ------------------------------------------------------------------{{{
let g:deoplete#enable_at_startup = 1

" }}}


" *************************************************************
"  Mappings
" *************************************************************


" Normal mapping ----------------------------------------------------------{{{
nnoremap <space> za

noremap  <silent> <Home> g<Home>
noremap  <silent> <End>  g<End>

" copy to end using Y because we cut to end with D

nnoremap <M-O> <S-O><Esc>j
nnoremap Y y$

if has('nvim')
	nnoremap <leader><leader>vim :e ~/.config/nvim/init.vim<CR>
else
	nnoremap <leader><leader>vim :e ~/.vimrc<CR>
endif

if !exists('g:vscode')
"  function keys
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

"  Navigate between display lines
nnoremap <silent><expr>k      v:count == 0 ? 'gk' : 'k'
nnoremap <silent><expr>j      v:count == 0 ? 'gj' : 'j'
nnoremap <silent><expr><Up>   v:count == 0 ? 'gk' : 'k'
nnoremap <silent><expr><Down> v:count == 0 ? 'gj' : 'j'

"  copy current file path to clipboard
nnoremap cp :let @+= expand("%") <cr>

"  Search mappings: These will make it so that going to the next one in a
"  search will center on the line it is found in.
nnoremap n nzzzv
nnoremap N Nzzzv

"  removing search highlighting using <esc>
nnoremap <silent> <esc> :noh<cr>

"  a map to delete to the blackhole _ register (no cutting)
nnoremap <leader>d "_d

"  Align blocks of text and keep them selected
nnoremap <leader>a :call <SID>SynStack()<CR>

"  Space to toggle folds.
nnoremap <Space> za

if !exists('g:vscode')
"  Opens an edit command with the path of the currently edited file filled in
	noremap <Leader>E :e <C-R>=expand("%:p:h") . "/" <CR>

"  Opens a tab edit command with the path of the currently edited file filled
	noremap <Leader>te :tabe <C-R>=expand("%:p:h") . "/" <CR>
"  FZF shortcuts
	nnoremap <silent> <leader>b :Buffers<CR>uun
	nnoremap <silent> <leader>e :FZF -m<CR>
	nnoremap <silent> <leader>F :FZF -m<CR>
endif


"  terminal emulation
nnoremap <silent> <leader>sh :terminal<CR>

"  Clean search (highlight)
nnoremap <silent> <leader><leader> :noh<cr>

" Buffer management
noremap <leader>c :bd<CR>
nmap <leader>, :bnext<CR>
nmap <leader>. :bprevious<CR>

" comment
if has('macunix')
	nnoremap <C-/> :TComment<cr>
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
" }}}

" Insert mapping ----------------------------------------------------------{{{
"  duplicate a line
inoremap <C-d> <Esc>yyPji

"  Get out of insert mode using jk or jj
inoremap jk <Esc>
inoremap jj <Esc>

"  Navigate between display lines
inoremap <silent> <Home> <C-o>g<Home>
inoremap <silent> <End>  <C-o>g<End>

"  insert mode
inoremap <C-a> <C-o>:call <SID>home()<CR>
inoremap <C-e> <End>
inoremap <M-Left> <C-o>ba
inoremap <M-Right> <C-o>wa

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

" }}}

" Visual mapping ----------------------------------------------------------{{{
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

"  Space to toggle folds.
vnoremap <Space> za

if has('macunix')
" pbcopy for OSX copy/paste
	vmap <D-v> :r !pbpaste<CR>
	vmap <D-c> :w !pbcopy<CR><CR>
endif

"  Vmap for maintain Visual Mode after shifting > and <
vmap < <gv
vmap > >gv

"  Move visual block
vnoremap J :m '>+1<CR>gv=gv
vnoremap K :m '<-2<CR>gv=gv

"  C mappings -----------------------------------------------------------{{{
"  Basic cursor movement and deletion keybindings from emacs, for vim.
"  command line mode
cnoremap <C-a> <Home>
cnoremap <C-e> <End>
cnoremap <C-d> <Del>
cnoremap <C-h> <BS>
cnoremap <M-j> :call split_line_text_at_cursor()<CR>

"  no one is really happy until you have this shortcuts
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
"  cnoremap <C-P> <C-R>=expand("%:p:h") . "/" <CR>


"  allow saving to protected file using sudo without leaving vim
cmap w!! w !sudo tee % >/dev/null
" }}}

" *************************************************************
"  Auto-mappings and related settings
" *************************************************************

"  auto-mappings
"  automatic sourcing of this file after writing
autocmd! bufwritepost ~/.config/nvim/init.vim source %
autocmd! bufwritepost ~/.vimrc source %

"  remove trailing whitespaces before writing a file
autocmd BufWritePre * %s/\s\+$//e

" "  Remember cursor position between vim sessions
" autocmd BufReadPost *
" 	\ if line("'\" ) > 0 && line ("'\" ) <= line("$") |
" 	\   exe "normal! g'\"  |
" 	\ endif

"  center buffer around cursor when opening files
autocmd BufRead * normal zz

set updatetime=200
" autocmd InsertEnter * let save_cwd = getcwd() | set autochdir
" autocmd InsertLeave * set noautochdir | execute 'cd' fnameescape(save_cwd)

" let no_buffers_menu=1

"  underline current line
set cursorline
highlight CursorLine gui=underline cterm=underline

"  customize search results colors
highlight Search ctermbg=DarkBlue ctermfg=Yellow guibg=DarkBlue guifg=Yellow

"  GUI only options
if has('gui_running')
	set guioptions=egmrti
	set gfn=SourceCodePro\ Nerd\ Font
	set guicursor=n-v-c-sm:block,i-ci-ve:ver25,r-cr-o:hor20
endif

colorscheme OceanicNext
" colorscheme solarized
set background=dark


if !exists('g:vscode')
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
"  The PC is fast enough, do syntax highlight syncing from start unless 200 lines
	augroup vimrc-sync-fromstart
		autocmd!
		autocmd BufEnter * :syntax sync maxlines=200
	augroup END

"  Remember cursor position
	" if !has('nvim')
	" 	augroup vimrc-remember-cursor-position
	" 		autocmd!
	" 		autocmd BufReadPost * if line("'\" ) > 1 && line("'\" ) <= line("$") | exe "normal! g`\"  | endif
	" 	augroup END
	" endif

"  txt
	augroup vimrc-wrapping
		autocmd!
		autocmd BufRead,BufNewFile *.txt call s:setupWrapping()
	augroup END
endif

" "  make/cmake
"  augroup vimrc-make-cmake
"  	autocmd!
"  	autocmd FileType make setlocal noexpandtab
"  	autocmd BufNewFile,BufRead CMakeLists.txt setlocal filetype=cmake
"  augroup END


" *************************************************************
"  Other settings (for plugins etc)
" *************************************************************

"  Operation management
" *************************************************************

"  session management ----------------------------------------------------{{{
if has('nvim')
	let g:session_directory = "~/.config/nvim/session"
else
	let g:session_directory = "~/.vim/session"
endif

let g:session_autoload = "no"
let g:session_autosave = "no"
let g:session_command_aliases = 0
" }}}

"  session management ----------------------------------------------------{{{
let g:auto_save = 0" enable AutoSave on Vim startup
let g:auto_save_no_updatetime = 1" do not change the 'updatetime' option
let g:auto_save_silent = 0" do not display the auto-save notification
let g:auto_save_postsave_hook = 'TagsGenerate'" this will run :TagsGenerate after each save
" }}}

if !exists('g:vscode')
" Git ------------------------------------------------------------------------{{{
	set signcolumn=yes
	let g:conflict_marker_enable_mappings = 0
	let g:gitgutter_sign_added = '│'
	let g:gitgutter_sign_modified = '│'
	let g:gitgutter_sign_removed = '│'
	let g:gitgutter_sign_removed_first_line = '│'
	let g:gitgutter_sign_modified_removed = '│'
" }}}

" Easy Git -------------------------------------------------------------------{{{
"  let g:easygit_enable_command = 0
" }}}

"  NERDTree configuration ----------------------------------------------------{{{
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
	augroup vfinit
		autocmd FileType unite call s:uniteinit()
	augroup END
	function! s:uniteinit()
		nmap <buffer> <Esc> <Plug>(unite_exit)
	endfunction
	function! s:nerdtreeinit() abort
		nunmap <buffer> K
		nunmap <buffer> J
	endf

" }}}

" grep.vim -------------------------------------------------------------------{{{
	nnoremap <silent> <leader>f :Rgrep<CR>
	let Grep_Default_Options = '-IR'
	let Grep_Skip_Files = '*.log *.db'
	let Grep_Skip_Dirs = '.git node_modules'
" }}}

"  Navigate between vim buffers and tmux panels ------------------------------{{{
	let g:tmux_navigator_no_mappings = 0
" }}}

" Tex ------------------------{{{
	let g:vimtex_compiler_progname='nvr'
" }}}

" terminal emulation --------------------------------------------------------{{{
	if has('nvim')
		nnoremap <silent> <leader>sh :terminal<CR>
	endif
" }}}
" change cursor in normal mode
	if exists('$TMUX')
 	    let &t_SI = "\<Esc>Ptmux;\<Esc>\<Esc>]50;CursorShape=1\x7\<Esc>\\"
	    let &t_EI = "\<Esc>Ptmux;\<Esc>\<Esc>]50;CursorShape=0\x7\<Esc>\\"
	else
	    let &t_SI = "\<Esc>]50;CursorShape=1\x7"
	    let &t_EI = "\<Esc>]50;CursorShape=0\x7"
	endif

" Nvim terminal -------------------------------------------------------------{{{

	au BufEnter * if &buftype == 'terminal' | :startinsert | endif
	autocmd BufEnter term://* startinsert
	if has('nvim')
		autocmd TermOpen * set bufhidden=hide
	endif

" }}}


"  Language settings
" ******************************************************************************

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

" jedi-vim --------------------------------------------------------------------------{{{
	let g:jedi#auto_vim_configuration = 1
	let g:jedi#completions_enabled = 0
	let g:jedi#popup_on_dot = 0
	let g:jedi#goto_assignments_command = "ga"
	let g:jedi#goto_definitions_command = "gd"
	let g:jedi#documentation_command = "S-k"
	let g:jedi#usages_command = "gr"
	let g:jedi#rename_command = "<F2>"
	let g:jedi#show_call_signatures = "1"
	let g:jedi#completions_command = "<C-Space>"
	let g:jedi#smart_auto_mappings = 0

" Syntax highlight
" Default highlight is better than polyglot
	let g:polyglot_disabled = ['python']
	let python_highlight_all = 1

" }}}

" ALE ------------------------------------------------------------------------{{{
	let g:ale_fixers = {
	\   '*': ['remove_trailing_lines', 'trim_whitespace'],
	\   'javascript': ['eslint'],
	\   'python': ['black'],
	\}

	" Set this variable to 1 to fix files when you save them.
	let g:ale_fix_on_save = 1
	let g:ale_completion_enabled = 0

	" this can prevent ALE from running continuously
	" let g:ale_lint_on_enter = 0
	" let g:ale_lint_on_text_changed = 'never'
" }}}

"  Visual Settings
" *****************************************************************************

"  Themes, Commands, etc  ----------------------------------------------------{{{
let g:oceanic_next_terminal_bold = 1
let g:oceanic_next_terminal_italic = 1
let g:oceanic_next_highlight_current_line =0
" colorscheme OceanicNext
" colorscheme one
" set background=dark
" }}}

"  Vim-Devicons -------------------------------------------------------------{{{
" 	let g:NERDTreeGitStatusNodeColorization = 1
"  
" let g:webdevicons_enable_denite = 0
" let g:WebDevIconsUnicodeDecorateFileNodesExtensionSymbols['vim'] = ''
" let g:WebDevIconsUnicodeDecorateFolderNodesDefaultSymbol = ''
" let g:WebDevIconsOS = 'Darwin'
" let g:WebDevIconsUnicodeDecorateFolderNodes = 1
" let g:WebDevIconsUnicodeDecorateFileNodesDefaultSymbol = ''
" let g:WebDevIconsUnicodeDecorateFolderNodes = 1
" let g:WebDevIconsUnicodeDecorateFolderNodesDefaultSymbol = ''
" let g:WebDevIconsUnicodeDecorateFileNodesExtensionSymbols = {}
" let g:WebDevIconsUnicodeDecorateFileNodesExtensionSymbols['js'] = ''
" let g:WebDevIconsUnicodeDecorateFileNodesExtensionSymbols['tsx'] = ''
" let g:WebDevIconsUnicodeDecorateFileNodesExtensionSymbols['css'] = ''
" let g:WebDevIconsUnicodeDecorateFileNodesExtensionSymbols['html'] = ''
" let g:WebDevIconsUnicodeDecorateFileNodesExtensionSymbols['json'] = ''
" let g:WebDevIconsUnicodeDecorateFileNodesExtensionSymbols['md'] = ''
" let g:WebDevIconsUnicodeDecorateFileNodesExtensionSymbols['sql'] = ''
" }}}

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
" }}}

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

"  fzf.vim ------------------------------------------------------------------{{{
	set wildmode=list:longest,list:full
	set wildignore+=*.o,*.obj,.git,*.rbc,*.pyc,__pycache__
	let $FZF_DEFAULT_COMMAND =  "find * -path '*/\.*' -prune -o -path 'node_modules/**' -prune -o -path 'target/**' -prune -o -path 'dist/**' -prune -o  -type f -print -o -type l -print 2> /dev/null"
	"----------------------------------------------------------------------------}}}

" The Silver Searcher -------------------------------------------------------{{{
	if executable('ag')
		let $FZF_DEFAULT_COMMAND = 'ag --hidden --ignore .git -g" '
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
" let g:syntastic_always_populate_loc_list=1
" let g:syntastic_error_symbol='✗'
" let g:syntastic_warning_symbol='⚠'
" let g:syntastic_style_error_symbol = '✗'
" let g:syntastic_style_warning_symbol = '⚠'
" let g:syntastic_auto_loc_list=1
" let g:syntastic_aggregate_errors = 1
" }}}

" Tagbar --------------------------------------------------------------------{{{
	let g:tagbar_autofocus = 1
" }}}

" Easy search ---------------------------------------------------------------{{{
	let g:esearch#cmdline#help_prompt = 1
	let g:esearch#cmdline#dir_icon = '  '
	let g:esearch = {
				\ 'adapter':    'rg',
				\ 'backend':    'nvim',
				\ 'use':        ['visual', 'hlsearch', 'last'],
				\}
" }}}

endif

" *****************************************************************************
"  Functions
" *****************************************************************************

if !exists('*s:setupWrapping')
	function s:setupWrapping()
		set wrap
		set wm=2
		set textwidth=79
	endfunction
endif
function! MyFoldText()" {{{
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