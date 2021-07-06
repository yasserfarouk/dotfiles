"
" Ask before unsafe actions
set confirm
" sane defaults
let mapleader = ' '
let maplocalleader = ','

set nocompatible
set noerrorbells visualbell t_vb=
" Disable visualbell
if has('autocmd')
	autocmd GUIEnter * set visualbell t_vb=
endif

"  Copy/Paste/Cut
if has('unnamedplus')
	set clipboard=unnamed,unnamedplus
endif
" colors
set t_Co=256
" set termguicolors
syntax on

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
set colorcolumn=79
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
set synmaxcol=300
" set inccommand=split
" Add Plug to the runtime path:
set rtp +=~/.vim/plugged
set rtp +=~/.config/vim
" In some versions of vim it was reported that cursorline cause lags with scrolling
" set nocursorline
let g:esearch = {
			\ 'adapter':    'rg',
			\ 'backend':    'vim',
			\ 'out':        'win',
			\ 'batch_size': 1000,
			\ 'use':        ['visual', 'hlsearch', 'last'],
			\}
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
" stolen frm vim-cursorline-current 
augroup cursorline_current
  autocmd!

  " If g:cursorline_current_line is true at plugin load time (defaults to on
  " if unset), set 'cursorline' to the user-configured window-global value on
  " entering a window, and unset it on leaving.
  "
  if get(g:, 'cursorline_current_line', 1)
    autocmd WinEnter *
          \ setlocal cursorline<
    autocmd WinLeave *
          \ setlocal nocursorline
  endif

  " Do the same for 'cursorcolumn' if g:cursorline_current_column is true at
  " load time, which again defaults to being on if unset.
  "
  if get(g:, 'cursorline_current_column', 1)
    autocmd WinEnter *
          \ setlocal cursorcolumn<
    autocmd WinLeave *
          \ setlocal nocursorcolumn
  endif

  " If g:cursorline_current_insert is set at plugin load time (defaults to on
  " if unset), also blank 'cursorline' even in the current window while in
  " insert mode.  Note that CTRL-C's default behaviour breaks this.
  "
  if get(g:, 'cursorline_current_insert', 1)
    autocmd InsertEnter *
          \ doautocmd cursorline_current WinLeave
    autocmd InsertLeave *
          \ doautocmd cursorline_current WinEnter
  endif

  " If g:cursorline_current_focus is set at plugin load time (defaults to on
  " if unset), also blank 'cursorline' even in the current window if Vim loses
  " focus.  This probably only works in the GUI.
  "
  if get(g:, 'cursorline_current_focus', 1)
    autocmd FocusGained *
          \ doautocmd cursorline_current WinEnter
    autocmd FocusLost *
          \ doautocmd cursorline_current WinLeave
  endif

  " Stack up BufEnter and BufLeave events to trigger the corresponding window
  " events, too; although this often means we set or unset the same option
  " twice, it correctly handles entering a new window for a buffer that had
  " already loaded.
  "
  autocmd BufEnter *
        \ doautocmd cursorline_current WinEnter
  autocmd BufLeave *
        \ doautocmd cursorline_current WinLeave

  " When Vim starts up, go through all of the windows in all of the tabs and
  " trigger the leave hooks to set 'cursorline' and/or 'cursorcolumn' locally
  " off, and then return to the first window of the first tab, and trigger the
  " enter hook to restore it to its user-configured window-global value again.
  " This is intended to correctly handle -o and -O options from the command
  " line, or vimrc files or plugins that open their own windows on Vim
  " startup.
  "
  autocmd VimEnter *
        \ tabdo windo doautocmd cursorline_current WinLeave
  autocmd VimEnter *
        \ tabfirst | 1 wincmd w | doautocmd WinEnter

  " If we just loaded a session, however, prevent those VimEnter hooks from
  " running by deleting them.  The session should have recorded values for
  " both options in each of the windows it saved, so we don't need to (and
  " shouldn't) mess with them.
  "
  autocmd SessionLoadPost *
        \ autocmd! cursorline_current VimEnter

augroup END
let g:indentLine_conceallevel = 0
" statusline
set statusline^=%{coc#status()}%{get(b:,'coc_current_function','')}
set statusline+=%{zoom#statusline()}
