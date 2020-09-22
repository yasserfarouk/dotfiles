
" Ask before unsafe actions
set confirm
" sane defaults
let mapleader = ' '
let maplocalleader = ','

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

" file encoding
set encoding=utf-8
set fileencoding=utf-8
set fileencodings=utf-8

" sane defaults
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
set updatetime=200
set cmdheight=2
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
set signcolumn=yes
set shortmess=atIc
set isfname-==
" set nospell
set spell
set splitbelow
set completeopt+=noselect,menuone
set completeopt-=preview
"  Directories for swp files
set nobackup
set noswapfile
set fileformats=unix,mac,dos
set autoread
set lazyredraw
set dictionary+=/usr/share/dict/words
set thesaurus+=$HOME/.ysupport/thesaurii.txt

" folding
set foldenable
set foldnestmax=12
set foldmethod=indent
set foldlevelstart=99
set foldlevel=99

" local vim
set exrc
set secure
" cursor line
set cursorline
set wildignore+=*/tmp/*,*.so,*.swp,*.zip,*.pyc,*.db,*.sqlite

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
set scrolloff=3
set laststatus=2
set modeline
set modelines=10
set title
set titleold="Terminal"
set titlestring=%F
let g:make = 'gmake'
if exists('make')
	let g:make = 'make'
endif
set wildmode=list:longest,list:full
set wildignore+=*.o,*.obj,.git,*.rbc,*.pyc,__pycache__
" Indicate we have a fast terminal connection. Improves smooth redrawing
set ttyfast

" Use old regex engine. It's said that it speeds up matching syntax elements
" https://github.com/vim/vim/issues/2712
" Vim 7.4 has introduced a weaker regex engine and setting this option will revert it to older
set regexpengine=1

" After given time, Vim will stop hihglighting further matches
" Syntax highlighting vs performance trade-off
set redrawtime=500

" Delay screen redraw for macros, uncompleted commands
" Redraw as fewer as possible
set lazyredraw

" Don't try to highlight lines longer than N characters.
set synmaxcol=100
" set inccommand=split
let $NVIM_TUI_ENABLE_CURSOR_SHAPE=1
" Add Plug to the runtime path:
set rtp +=~/.config/nvim
" In some versions of vim it was reported that cursorline cause lags with scrolling
" set nocursorline
if has('nvim')
	let g:esearch = {
				\ 'adapter':    'rg',
				\ 'backend':    'nvim',
				\ 'out':        'win',
				\ 'batch_size': 1000,
				\ 'use':        ['visual', 'hlsearch', 'last'],
				\}
else
	let g:esearch = {
				\ 'adapter':    'rg',
				\ 'backend':    'vim',
				\ 'out':        'win',
				\ 'batch_size': 1000,
				\ 'use':        ['visual', 'hlsearch', 'last'],
				\}
endif
" change cursor in normal mode
if exists('$TMUX')
	let &t_SI = "\<Esc>Ptmux;\<Esc>\<Esc>]50;CursorShape=1\x7\<Esc>\\"
	let &t_EI = "\<Esc>Ptmux;\<Esc>\<Esc>]50;CursorShape=0\x7\<Esc>\\"
else
	let &t_SI = "\<Esc>]50;CursorShape=1\x7"
	let &t_EI = "\<Esc>]50;CursorShape=0\x7"
endif
"  auto-mappings ---------------------------------------------------------{{{

if !exists('g:vscode')
	autocmd! bufwritepost $MYVIMRC source %

	"  remove trailing whitespaces before writing a file
	" autocmd BufWritePre * %s/\s\+$//e

	" "  Remember cursor position between vim sessions
	" autocmd BufReadPost *
	" 	\ if line("'\" ) > 0 && line ("'\" ) <= line("$") |
	" 	\   exe "normal! g'\"  |
	" 	\ endif

	"  center buffer around cursor when opening files
	autocmd BufRead * normal zz
	" autocmd InsertEnter * let save_cwd = getcwd() | set autochdir
	" autocmd InsertLeave * set noautochdir | execute 'cd' fnameescape(save_cwd)
	augroup vimrc
		au BufReadPre * setlocal foldmethod=indent
		au BufWinEnter * if &fdm == 'indent' | setlocal foldmethod=manual | endif
	augroup END
	"  The PC is fast enough, do syntax highlight syncing from start unless 200 lines
	augroup vimrc-sync-fromstart
		autocmd!
		autocmd BufEnter * :syntax sync maxlines=200
	augroup END
endif
