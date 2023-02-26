" Basic settings -----------------------------------------------------------{{{

set nocompatible
filetype plugin indent on

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
set foldlevelstart=99
set foldnestmax=12
set foldmethod=indent

" local vim
set exrc
set secure
" cursor line
set cursorline
set wildignore+=*/tmp/*,*.so,*.swp,*.zip,*.pyc,*.db,*.sqlite

"  GUI only options
if has('gui_running')
	set guioptions=egmrti
	set gfn=JetBrainsMono\ NF
	set guicursor=n-v-c-sm:block,i-ci-ve:ver25,r-cr-o:hor20
endif


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
" set inccommand=split
let $NVIM_TUI_ENABLE_CURSOR_SHAPE=1
if !exists('g:vscode')
	let g:airline#extensions#ale#error_symbol='• '
	let g:airline#extensions#ale#warning_symbol='•  '
	" let g:airline#extensions#neomake#error_symbol='• '
	" let g:airline#extensions#neomake#warning_symbol='•  '
	" let g:airline#extensions#coc#enabled = 1
	" let airline#extensions#coc#error_symbol = 'E:'
	" let airline#extensions#coc#warning_symbol = 'W:'
	" let airline#extensions#coc#stl_format_err = '%E{[%e(#%fe)]}'
endif

" }}}
"

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

	if !exists('g:vscode')
		Plug 'machakann/vim-highlightedyank'
		Plug 'will133/vim-dirdiff'
		Plug 'lambdalisue/fern.vim'
		Plug 'PeterRincker/vim-searchlight'
		Plug 'tpope/vim-obsession'
		Plug 'dhruvasagar/vim-prosession'
		Plug 'tmhedberg/matchit'
		Plug 'tmhedberg/indent-motion'
		Plug 'honza/vim-snippets'
		Plug 'tpope/vim-surround'
		Plug 'tpope/vim-unimpaired'
		Plug 'tomtom/tcomment_vim'
		Plug 'tpope/vim-repeat'
		Plug 'romgrk/replace.vim'
		Plug 'junegunn/vim-easy-align'
		Plug 'jiangmiao/auto-pairs'
		Plug 'noahfrederick/vim-laravel'
		Plug 'mattn/emmet-vim'
		" Plug 'airblade/vim-rooter'
		Plug 'justinmk/vim-sneak'
		" Plug 'thaerkh/vim-workspace'
		Plug 'samoshkin/vim-mergetool'
		Plug 'ntpeters/vim-better-whitespace'
		" Plug 'inkarkat/vim-ReplaceWithRegister'
		" Plug 'rrethy/vim-hexokinase', { 'do': 'make hexokinase' }
		" Plug 'airblade/vim-gitgutter'
		Plug 'voldikss/vim-floaterm'
		Plug 'dhruvasagar/vim-zoom'
		Plug 'rhysd/vim-grammarous'
		Plug 'dyng/ctrlsf.vim'
		Plug 'alvan/vim-closetag'
		Plug 'lervag/vimtex'
		" Plug 'easymotion/vim-easymotion'
		Plug 'vim-pandoc/vim-pandoc-syntax'
		Plug 'unblevable/quick-scope'
		" Plug 'z-huabao/vim-submode'
		" Plug 'z-huabao/vim-slime-ipython'
		" Plug 'chrisbra/Colorizer'
		Plug 'heavenshell/vim-pydocstring', Cond(!has('nvim'))
		" Plug 'Rykka/riv.vim'
		" Plug 'Rykka/InstantRst'
		Plug 'morhetz/gruvbox'
		" Plug 'psf/black', { 'tag': '19.10b0' }
		if has('macunix')
			Plug 'rizzatti/dash.vim'
		endif
		" Plug 'ervandew/supertab'
		" better highlighting for python
		Plug 'vim-python/python-syntax'
		" adds motions for python
		" Plug 'jeetsukumaran/vim-pythonsense'
		" better indenting for python
		" Plug 'Vimjas/vim-python-pep8-indent'
		Plug 'luochen1990/rainbow'
		Plug 'junegunn/limelight.vim'
		Plug 'junegunn/goyo.vim'
		Plug 'puremourning/vimspector'
		" Plug 'vim-vdebug/vdebug'
		Plug 'tpope/vim-projectionist'        "|
		" Plug 'camspiers/animate.vim'
		" Plug 'camspiers/lens.vim'
		Plug 'tpope/vim-dispatch'             "| Optional
		Plug 'tpope/vim-eunuch'
		Plug 'ryanoasis/vim-devicons'
		" Plug 'NLKNguyen/pipe.vim'
		" Plug 'NLKNguyen/pipe-mysql.vim'
		Plug 'terryma/vim-multiple-cursors'
		Plug 'janko/vim-test'
		Plug 'alfredodeza/pytest.vim'
		" Plug 'dense-analysis/ale'
		" Plug 'Shougo/denite.nvim'
		" Plug 'Shougo/neco-vim'
		" Plug 'neoclide/coc-neco'
		" " needed for deoplete
		" Plug 'roxma/nvim-yarp', Cond(!has('nvim'))
		" Plug 'roxma/vim-hug-neovim-rpc', Cond(!has('nvim'))
		" if has('nvim')
		" 	Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }
		" else
		" 	Plug 'Shougo/deoplete.nvim'
		" endif
		" " vim source for deoplete
		" echos documentation (may be needed only with LanguageClient)
		" Plug 'Shougo/echodoc.vim'
		" Plug 'Shougo/neoinclude.vim'
		" Plug 'Shougo/neomru.vim'
		" Plug 'autozimu/LanguageClient-neovim', {
		" 	\ 'branch': 'next',
		" 	\ 'do': 'bash install.sh',
		" 	\ }
		" if has('nvim')
		" 	Plug 'numirias/semshi', {'do': ':UpdateRemotePlugins'}
		" endif
		" Plug 'zchee/deoplete-jedi'
		" Plug 'davidhalter/jedi-vim', {'for': 'python'}
		Plug 'neoclide/coc.nvim', {'branch': 'release'}
		" Plug 'vim-scripts/SyntaxRange'
		" Plug 'ludovicchabant/vim-gutentags'
		" Plug 'SirVer/ultisnips'
		" Plug 'MartinLafreniere/vim-PairTools'
		Plug 'majutsushi/tagbar'
		Plug 'altercation/vim-colors-solarized'
		Plug 'mhartington/oceanic-next'
		Plug 'tpope/vim-fugitive'
		Plug 'dhruvasagar/vim-table-mode'
		Plug 'elzr/vim-json'
		Plug 'flazz/vim-colorschemes'
		" Plug 'scrooloose/nerdtree'
		" Plug 'jistr/vim-nerdtree-tabs'
		" Plug 'Xuyuanp/nerdtree-git-plugin'
		Plug 'sgeb/vim-diff-fold'
		" Plug 'sheerun/vim-polyglot'
		Plug 'tmhedberg/SimpylFold', {'for': 'python'}
		Plug 'tpope/vim-markdown', {'for': 'markdown'}
		Plug 'godlygeek/tabular'
		Plug 'iamcco/markdown-preview.nvim', { 'do': 'cd app & yarn install' }
		Plug 'nelstrom/vim-markdown-folding', {'for': 'markdown'}
		" Plug 'vim-airline/vim-airline'
		" Plug 'vim-airline/vim-airline-themes'
		Plug 'vim-scripts/grep.vim'
		Plug 'Yggdroot/indentLine'
		" Plug 'vim-scripts/vim-auto-save'
		Plug 'vim-scripts/guicolorscheme.vim'
		" Plug 'christoomey/vim-tmux-navigator'
		" Plug 'tpope/vim-vinegar'
		" if has('nvim')
			" Plug 'Shougo/neosnippet.vim'
			Plug 'Shougo/neosnippet-snippets'
			" Plug 'himkt/docstring.nvim', { 'do': ':UpdateRemotePlugins' }
		" endif
		if isdirectory('/usr/local/opt/fzf')
			Plug '/usr/local/opt/fzf' | Plug 'junegunn/fzf.vim'
		else
			Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --bin' }
			Plug 'junegunn/fzf.vim'
		endif
	endif
call plug#end()
" }}}


" Performance optimizations{{{
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
set synmaxcol=200

" In some versions of vim it was reported that cursorline cause lags with scrolling
" set nocursorline
" }}}

" Normal mapping ----------------------------------------------------------{{{
" nnoremap ; :
nnoremap <silent> <leader>rws :let _s=@/ <Bar> :%s/\s\+$//e <Bar> :let @/=_s <Bar> :nohl <Bar> :unlet _s<CR><Esc><C-o>
nmap <leader>mt <plug>(MergetoolToggle)
nnoremap <leader>TM :TableModeToggle<CR>

nnoremap <leader>q :wq<CR>
" Float Term
nnoremap <leader>xh :FloatermNew<CR>
nnoremap <leader>xx :FloatermToggle<CR>
nnoremap <leader>xf :FloatermNew vifm<CR>
nnoremap <leader>xt :FloatermNew ytop<CR>
nnoremap <leader>xG :FloatermNew lazygit<CR>
nnoremap <leader>xP :FloatermNew ipython<CR>
nnoremap <leader>xb :call <SID>run_black()<CR>
nnoremap <leader>xi :call <SID>run_isort()<CR>
nnoremap <leader>xB :call <SID>run_black_dir()<CR>
nnorema <leader>xg :FloatermNew googler
nnoremap <leader>xn :FloatermNext<CR>
nnoremap <leader>xp :FloatermPrev<CR>

"  terminal emulation
nnoremap <silent> <leader>term :terminal<CR>
nnoremap <silent> <leader>shr :FloatermNew --wintype=normal --position=right<CR>
nnoremap <silent> <leader>shb :FloatermNew --wintype=normal --height=0.3 --position=bottom<CR>
nnoremap <silent> <leader>shl :FloatermNew --wintype=normal --position=left<CR>
nnoremap <silent> <leader>sht :FloatermNew --wintype=normal --position=top<CR>
nnoremap <silent> <leader>run :FloatermSend<CR>

" toggle workspace
nnoremap <silent> <leader>se :ToggleWorkspace<CR>
nnoremap <silent> <leader>ch :CloseHiddenBuffers<CR>

" Basic file system commands
nnoremap <M-n> :!touch<Space>
nnoremap <M-d> :!mkdir<Space>
nnoremap <M-m> :!mv<Space>%<Space>
nnoremap <leader><leader>b :call SetBackground()<CR>
" Syntax Highlighting --------------{{{
function! GoHighlight()
	syntax on
	syntax sync fromstart
endfunction
" }}}
noremap <F12> :call GoHighlight()<CR>
inoremap <F12> <C-o>:syntax sync fromstart<CR>

" replace.vim mappings
" nmap R <Plug>ReplaceOperator
" vmap R <Plug>ReplaceOperator
" nmap S <Plug>ReplaceOperator
" nmap X <Plug>ExchangeOperator

" multi-cursoer mappings
let g:multi_cursor_use_default_mapping=0
let g:multi_cursor_start_word_key      = '<C-n>'
let g:multi_cursor_select_all_word_key = '<A-n>'
let g:multi_cursor_start_key           = 'g<C-n>'
let g:multi_cursor_select_all_key      = 'g<A-n>'
let g:multi_cursor_next_key            = '<C-n>'
let g:multi_cursor_prev_key            = '<C-p>'
let g:multi_cursor_skip_key            = '<C-x>'
let g:multi_cursor_quit_key            = '<Esc>'

" vim-test mappings
nmap <silent> <localleader>tn :TestNearest<CR>
nmap <silent> <localleader>tf :TestFile<CR>
nmap <silent> <localleader>ts :TestSuite<CR>
nmap <silent> <localleader>tl :TestLast<CR>
nmap <silent> <localleader>tv :TestVisit<CR>


nnoremap \ za

noremap  <silent> <Home> g<Home>
noremap  <silent> <End>  g<End>

" copy to end using Y because we cut to end with D
" nnoremap <A-O> <S-O><Esc>j
nnoremap Y y$

nnoremap <leader><leader>vim :vs $MYVIMRC<CR>

if !exists('g:vscode')
"  function keys
	nnoremap <leader>tt :TagbarToggle<CR>

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
nnoremap <leader>cp :let @+= expand("%") <cr>

"  Search mappings: These will make it so that going to the next one in a
"  search will center on the line it is found in.
nnoremap n nzzzv
nnoremap N Nzzzv

"  removing search highlighting using <esc>
nnoremap <silent> <esc> :noh<cr>

"  a map to delete to the blackhole _ register (no cutting)
nnoremap <leader>d "_d
nnoremap <leader>D "_D

"  Align blocks of text and keep them selected
" nnoremap <leader>a :call <SID>SynStack()<CR>

"  Space to toggle folds.
nnoremap \ za

if !exists('g:vscode')
"  Opens an edit command with the path of the currently edited file filled in
	noremap <Leader>E :e <C-R>=expand("%:p:h") . "/" <CR>

"  FZF shortcuts
	nnoremap <silent> <leader>b :Buffers<CR>
	nnoremap <silent> <leader>c :Commands<CR>
	nnoremap <silent> <leader>f :Files<CR>
endif

" setting working directory
nnoremap <leader>cd :cd %:p:h<cr>

" Buffer management
nnoremap <leader>bd :bd<CR>
nmap <leader>. :bnext<CR>
nmap <leader>, :bprevious<CR>

" comment
nnoremap <C-/> :TComment<cr>
if has('macunix')
	nnoremap <D-/> :TComment<cr>
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

nmap     <leader>r <Plug>CtrlSFPrompt
vmap     <leader>r <Plug>CtrlSFVwordPath
vmap     <leader>R <Plug>CtrlSFVwordExec
nmap     <C-F>n <Plug>CtrlSFCwordPath
nmap     <C-F>p <Plug>CtrlSFPwordPath
nnoremap <C-F>o :CtrlSFOpen<CR>
nnoremap <C-F>t :CtrlSFToggle<CR>
inoremap <C-F>t <Esc>:CtrlSFToggle<CR>


noremap <silent> <Up>    :wincmd k<CR>
noremap <silent> <Down>  :wincmd j<CR>
noremap <silent> <Left>  :wincmd h<CR>
noremap <silent> <Right> :wincmd l<CR>

noremap <silent> <C-s> :wincmd s<CR>
noremap <silent> <C-\> :wincmd v<CR>
" Use 'H' and 'L' keys to move to start/end of the line
" noremap H ^
" noremap L $

" Recenter when jump back and forward
nnoremap <C-o> <C-o>zz
nnoremap <C-l> <C-i>zz

" z+, moves next line below the window
" z-, moves next line above the window
nnoremap z- z^

" Tag matching list
nnoremap <silent> ]t :tnext<CR>
nnoremap <silent> [t :tprev<CR>
nnoremap <silent> ]T :tlast<CR>
nnoremap <silent> [T :tfirst<CR>

" Tags in preview window
nnoremap <silent> ]p :ptnext<CR>
nnoremap <silent> [p :ptprev<CR>
nnoremap <silent> ]P :ptlast<CR>
nnoremap <silent> [P :ptfirst<CR>

" Center screen after navigation shortcuts
nnoremap } }zvzz
nnoremap { {zvzz

nnoremap ]] ]]zvzz
nnoremap [[ [[zvzz
nnoremap [] []zvzz
nnoremap ][ ][zvzz
" Drop into insert mode on Backspace
nnoremap <BS> i<BS>
" Close all folds except the one under the cursor, and center the screen
nnoremap <leader>z zMzvzz
" Kill buffer
nnoremap <silent> <leader>k :bd!<CR>
if has('macunix')
	" Open current directory in Finder
	nnoremap <leader>o :silent exec "!open %:p:h" \| redraw!<CR>
endif

function! GoogleSearch()
     let searchterm = getreg("g")
     silent! exec "silent! !chrome \"http://google.com/search?q=" . searchterm . "\" &"
endfunction
vnoremap <leader>g "gy<Esc>:call GoogleSearch()<CR>

let g:LanguageClient_serverCommands = {
    \ 'python': ['pyls'],
    \ }
" }}}
 

" FERN ----------------{{{

" Disable netrw.
let g:loaded_netrw  = 1
let g:loaded_netrwPlugin = 1
let g:loaded_netrwSettings = 1
let g:loaded_netrwFileHandlers = 1

augroup my-fern-hijack
  autocmd!
  autocmd BufEnter * ++nested call s:hijack_directory()
augroup END

function! s:hijack_directory() abort
  let path = expand('%:p')
  if !isdirectory(path)
    return
  endif
  bwipeout %
  execute printf('Fern %s', fnameescape(path))
endfunction

" Custom settings and mappings.
let g:fern#disable_default_mappings = 1

noremap <silent> <Leader>nf :Fern . -drawer -reveal=% -toggle -width=35<CR><C-w>=
noremap <silent> <F3> :Fern . -drawer -reveal=% -toggle -width=35<CR><C-w>=
noremap <silent> - :Fern . -reveal=% -opener=edit<CR>

function! FernInit() abort
  nmap <buffer><expr>
        \ <Plug>(fern-my-open-expand-collapse)
        \ fern#smart#leaf(
        \   "\<Plug>(fern-action-open:select)",
        \   "\<Plug>(fern-action-expand)",
        \   "\<Plug>(fern-action-collapse)",
        \ )
  nmap <buffer> <CR> <Plug>(fern-my-open-expand-collapse)
  nmap <buffer> <2-LeftMouse> <Plug>(fern-my-open-expand-collapse)
  nmap <buffer> n <Plug>(fern-action-new-path)
  nmap <buffer> c <Plug>(fern-action-new-path)
  nmap <buffer> d <Plug>(fern-action-remove)
  nmap <buffer> m <Plug>(fern-action-move)
  nmap <buffer> M <Plug>(fern-action-rename)
  nmap <buffer> h <Plug>(fern-action-hidden-toggle)
  nmap <buffer> r <Plug>(fern-action-reload)
  nmap <buffer> s <Plug>(fern-action-mark-toggle)
  nmap <buffer> b <Plug>(fern-action-open:split)
  nmap <buffer> v <Plug>(fern-action-open:vsplit)
  nmap <buffer><nowait> < <Plug>(fern-action-leave)
  nmap <buffer><nowait> > <Plug>(fern-action-enter)
endfunction

augroup FernGroup
  autocmd!
  autocmd FileType fern call FernInit()
augroup END
" }}}

" COC ----------------{{{
" Use tab for trigger completion with characters ahead and navigate.
" inoremap <silent><expr> <TAB>
"       \ pumvisible() ? "\<C-n>" :
"       \ <SID>check_back_space() ? "\<TAB>" :
"       \ coc#refresh()
inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"
inoremap <silent><expr> <TAB>
      \ pumvisible() ? coc#_select_confirm() :
      \ coc#expandableOrJumpable() ? "\<C-r>=coc#rpc#request('doKeymap', ['snippets-expand-jump',''])\<CR>" :
      \ <SID>check_back_space() ? "\<TAB>" :
      \ coc#refresh()

function! s:check_back_space() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction

let g:coc_snippet_next = '<tab>'

" Use <c-space> to trigger completion.
inoremap <silent><expr> <c-space> coc#refresh()

" Use <cr> to confirm completion, `<C-g>u` means break undo chain at current
" position. Coc only does snippet and additional edit on confirm.
if has('patch8.1.1068')
  " Use `complete_info` if your (Neo)Vim version supports it.
  inoremap <expr> <cr> complete_info()["selected"] != "-1" ? "\<C-y>" : "\<C-g>u\<CR>"
else
  imap <expr> <cr> pumvisible() ? "\<C-y>" : "\<C-g>u\<CR>"
endif

" Use `[g` and `]g` to navigate diagnostics
nmap <silent> [G <Plug>(coc-diagnostic-first)
nmap <silent> [g <Plug>(coc-diagnostic-prev)
nmap <silent> ]g <Plug>(coc-diagnostic-next)
nmap <silent> ]G <Plug>(coc-diagnostic-last)

" GoTo code navigation.
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> <S-F7> <Plug>(coc-references)
nmap <silent> gu <Plug>(coc-references)
nnoremap <silent> K :call <SID>show_documentation()<CR>

function! s:show_documentation()
  if (index(['vim','help'], &filetype) >= 0)
    execute 'h '.expand('<cword>')
  else
    call CocAction('doHover')
  endif
endfunction

function! s:run_black()
  execute ':!black '.expand('%')
  execute ':e %'
endfunction

function! s:run_isort()
  execute ':!isort '.expand('%')
  execute ':e %'
endfunction
function! s:run_black_dir()
  execute ':!black .' 
  execute ':e %'
endfunction
" Highlight the symbol and its references when holding the cursor.
" autocmd CursorHold * silent call CocActionAsync('highlight')

" Symbol renaming.
nmap <F2> <Plug>(coc-rename)
nnoremap <leader>rr <Plug>(coc-rename)

" Formatting selected code.
xmap <leader>ff  <Plug>(coc-format-selected)
nmap <leader>ff  <Plug>(coc-format-selected)

augroup mygroup
  autocmd!
  " Setup formatexpr specified filetype(s).
  autocmd FileType typescript,json setl formatexpr=CocAction('formatSelected')
  " Update signature help on jump placeholder.
  autocmd User CocJumpPlaceholder call CocActionAsync('showSignatureHelp')
augroup end

" Applying codeAction to the selected region.
" Example: `<leader>aap` for current paragraph
xmap <leader>a  <Plug>(coc-codeaction-selected)
nmap <leader>a  <Plug>(coc-codeaction-selected)

" Remap keys for applying codeAction to the current line.
nmap <leader>ac  <Plug>(coc-codeaction)
" Apply AutoFix to problem on the current line.
nmap <leader>qf  <Plug>(coc-fix-current)

" Introduce function text object
" NOTE: Requires 'textDocument.documentSymbol' support from the language server.
xmap if <Plug>(coc-funcobj-i)
xmap af <Plug>(coc-funcobj-a)
omap if <Plug>(coc-funcobj-i)
omap af <Plug>(coc-funcobj-a)

" Use <TAB> for selections ranges.
" NOTE: Requires 'textDocument/selectionRange' support from the language server.
" coc-tsserver, coc-python are the examples of servers that support it.
" nmap <silent> <TAB> <Plug>(coc-range-select)
" xmap <silent> <TAB> <Plug>(coc-range-select)

" Add `:Format` command to format current buffer.
command! -nargs=0 Format :call CocAction('format')

" Add `:Fold` command to fold current buffer.
command! -nargs=? Fold :call     CocAction('fold', <f-args>)

" Add `:OR` command for organize imports of the current buffer.
command! -nargs=0 OR   :call     CocAction('runCommand', 'editor.action.organizeImport')

" Add (Neo)Vim's native statusline support.
" NOTE: Please see `:h coc-status` for integrations with external plugins that
" provide custom statusline: lightline.vim, vim-airline.
set statusline^=%{coc#status()}%{get(b:,'coc_current_function','')}

" Mappings using CoCList:
" Show all diagnostics.
nnoremap <silent> <localleader>a  :<C-u>CocList diagnostics<cr>
" Manage extensions.
nnoremap <silent> <localleader>e  :<C-u>CocList extensions<cr>
" Show commands.
nnoremap <silent> <localleader>c  :<C-u>CocList commands<cr>
" Find symbol of current document.
nnoremap <silent> <localleader>o  :<C-u>CocList outline<cr>
" Search workspace symbols.
nnoremap <silent> <localleader>s  :<C-u>CocList -I symbols<cr>
" Do default action for next item.
nnoremap <silent> <localleader>j  :<C-u>CocNext<CR>
" Do default action for previous item.
nnoremap <silent> <localleader>k  :<C-u>CocPrev<CR>
" Resume latest coc list.
nnoremap <silent> <localleader>p  :<C-u>CocListResume<CR>" }}}
" }}}
" Vimspector -------------{{{
nnoremap <F5> <Plug>VimspectorContinue
nnoremap <S-F5> <Plug>VimspectorStop
nnoremap <C-F5> <Plug>VimspectorRestart
nnoremap <F4> <Plug>VimspectorPause
nnoremap <F9> <Plug>VimspectorToggleBreakpoint
nnoremap <S-F9> <Plug>VimspectorToggleConditionalBreakpoint
nnoremap <C-F9> <Plug>VimspectorAddFunctionBreakpoint
nnoremap <F8> <Plug>VimspectorStepOver
nnoremap <F7> <Plug>VimspectorStepInto
nnoremap <S-F8> <Plug>VimspectorStepOut
nnoremap <leader>dd :call vimspector#Launch()<CR>
nnoremap <leader>dx :VimspectorReset<CR>
nnoremap <leader>de :VimspectorEval
nnoremap <leader>dw :VimspectorWatch
nnoremap <leader>do :VimspectorShowOutput
autocmd FileType java nmap <leader>dd :CocCommand java.debug.vimspector.start<CR>

inoremap <F5> <Plug>VimspectorContinue
inoremap <S-F5> <Plug>VimspectorStop
inoremap <C-F5> <Plug>VimspectorRestart
inoremap <F4> <Plug>VimspectorPause
inoremap <F9> <Plug>VimspectorToggleBreakpoint
inoremap <S-F9> <Plug>VimspectorToggleConditionalBreakpoint
inoremap <C-F9> <Plug>VimspectorAddFunctionBreakpoint
inoremap <F8> <Plug>VimspectorStepOver
inoremap <F7> <Plug>VimspectorStepInto
inoremap <S-F8> <Plug>VimspectorStepOut
" }}}
" LanguageClient --------------{{{
" Or map each action separately
" nnoremap <silent>K :call LanguageClient#textDocument_hover()<CR>
" nnoremap <silent>gd :call LanguageClient#textDocument_definition()<CR>
" nnoremap <silent><F2> :call LanguageClient#textDocument_rename()<CR>
" nnoremap <silent><F8> :call LanguageClient_contextMenu()<CR>
" nnoremap <silent><F7> :call LanguageClient#textDocument_references()<CR>
" function SetLSPShortcuts()
"   nnoremap gd :call LanguageClient#textDocument_definition()<CR>
"   nnoremap <F2> :call LanguageClient#textDocument_rename()<CR>
"   nnoremap <leader>lf :call LanguageClient#textDocument_formatting()<CR>
"   nnoremap <leader>lt :call LanguageClient#textDocument_typeDefinition()<CR>
"   nnoremap <F7> :call LanguageClient#textDocument_references()<CR>
"   nnoremap <leader>la :call LanguageClient_workspace_applyEdit()<CR>
"   nnoremap <S-k> :call LanguageClient#textDocument_completion()<CR>
"   nnoremap <leader>lh :call LanguageClient#textDocument_hover()<CR>
"   nnoremap <leader>ls :call LanguageClient_textDocument_documentSymbol()<CR>
"   nnoremap <leader>lm :call LanguageClient_contextMenu()<CR>
" endfunction()
"
" augroup LSP
"   autocmd!
"   autocmd FileType cpp,c call SetLSPShortcuts()
"   autocmd FileType python call SetLSPShortcuts()
" augroup END
" }}}

" execution and quitting ---------------------------------------------------{{{
" Scratch buffer and Eread command

" " Read command output and show it in new scratch buffer
" " :Eread !{system_command}
" " :Eread {vim_command}
" command! -nargs=1 -complete=command Eread silent call <SID>read_command_output_in_new_buffer(<q-args>)
"
" " Capture command's output and show it in a new buffer
" function! s:read_command_output_in_new_buffer(cmd)
"   " Capture command output
"   if a:cmd =~ '^!'
"     let output = system(matchstr(a:cmd, '^!\zs.*'))
"   else
"     redir => output
"     execute a:cmd
"     redir END
"   endif
"
"   " Show in new scratch buffer
"   call s:new_scratch_buffer(output, "Command: " . a:cmd)
" endfunction
"
" " Show text of list of lines in new scratch buffer
" function s:new_scratch_buffer(content, ...)
"   let title = get(a:, "1", "[Scratch]")
"   let new_command = get(a:, "2", "enew")
"
"   exe new_command
"   let w:scratch = 1
"   setlocal buftype=nofile bufhidden=wipe nobuflisted noswapfile hidden
"   silent! exe "file! " . title
"
"   " Automatically kill buffer on WinLeave
"   augroup aug_scratch_autohide
"     autocmd!
"     execute 'autocmd WinLeave <buffer=' . bufnr('%') . '> bdelete'
"   augroup END
"
"   if type(a:content) == type([])
"     call setline(1, a:content)
"   else
"     call setline(1, split(a:content, "\n"))
"   endif
" endfunction

" Smart quit window function
" QuitWindow call s:QuitWindow()
" nnoremap <silent> <leader>q :QuitWindow<CR>

" Close all readonly buffers with just a "q" keystroke, otherwise "q" is used to record macros in a normal mode
nnoremap  <expr> q &readonly ? ":quit\<CR>" : "q"

" Save and quit
nnoremap <silent> <leader>w :wall<CR>
" nnoremap ZZ :update! \| QuitWindow<CR>

" Save and quit for multiple buffers
nnoremap <silent> <leader>W :wall<CR>
nnoremap <silent> <leader>Q :confirm qall<CR>
nnoremap <silent> ZX :confirm xall<CR>


" Close list of windows
function s:CloseEachWindow(windows)
  " Reverse sort window numbers, start closing from the highest window number: 3,2,1
  " This is to ensure window numbers are not shifted while closing
  for _win in sort(copy(a:windows), {a, b -> b - a})
    exe _win . "wincmd c"
  endfor
endfunction

" Context-aware quit window logic
" function s:QuitWindow()
"
"   " If we're in merge mode, exit it
"   if get(g:, 'mergetool_in_merge_mode', 0)
"     call mergetool#stop()
"     return
"   endif
"
"   " TODO: maybe use buffers instead of windows
"   let l:diff_windows = s:GetDiffWindows()
"
"   " When running as 'vimdiff' or 'vim -d', close both files and exit Vim
"   if get(g:, 'is_started_as_vim_diff', 0)
"     windo quit
"     return
"   endif
"
"   " If current window is in diff mode, and we have two or more diff windows
"   if &diff && len(l:diff_windows) >= 2
"     let l:fug_diff_windows = filter(l:diff_windows[:], { idx, val -> s:IsFugitiveDiffWindow(val) })
"
"     if s:GetFugitiveStatusWindow() != -1
"       call s:CloseEachWindow(l:diff_windows)
"     elseif !empty(l:fug_diff_windows)
"       call s:CloseEachWindow(l:fug_diff_windows)
"     else
"       quit
"     endif
"
"     diffoff!
"     diffoff!
"
"     exe "norm zvzz"
"
"     return
"   endif
"
"   windo quit
" endfunction
"
"  }}}


" Terminal mappings -------------------------------------------------------{{{
if has('nvim')
  tnoremap <Esc> <C-\><C-n>
  tnoremap <A-[> <Esc>
  tnoremap <C-v><Esc> <Esc>
endif
if has('nvim')
  " Terminal mode:
  tnoremap <C-h> <c-\><c-n><c-w>h
  tnoremap <C-j> <c-\><c-n><c-w>j
  tnoremap <C-k> <c-\><c-n><c-w>k
  tnoremap <C-l> <c-\><c-n><c-w>l
endif
"  }}}

" Insert mapping ----------------------------------------------------------{{{
"  duplicate a line
" Shift-Enter to start editing new line without splitting the current one
inoremap <S-CR> <C-o>o
inoremap <C-d> <Esc>yyPji

"  Get out of insert mode using jk or jj
inoremap jk <Esc>
" inoremap jj <Esc>

"  Navigate between display lines
inoremap <silent> <Home> <C-o>g<Home>
inoremap <silent> <End>  <C-o>g<End>

"  insert mode
" inoremap <C-a> <C-o>:call <SID>home()<CR>
inoremap <C-e> <End>
inoremap <M-Left> <C-o>ba
inoremap <M-Right> <C-o>wa

" Split management
inoremap <C-h> <ESC><C-w>h
inoremap <C-j> <ESC><C-w>j
inoremap <C-k> <ESC><C-w>k
inoremap <C-l> <ESC><C-w>l

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

" vmap R <Plug>ReplaceOperator
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
vnoremap \ za

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
" }}}

"  C mappings -----------------------------------------------------------{{{
"  Basic cursor movement and deletion keybindings from emacs, for vim.
"  command line mode
cnoremap <C-a> <Home>
cnoremap <C-e> <End>
cnoremap <C-d> <Del>
cnoremap <C-h> <BS>
cnoremap <A-j> :call split_line_text_at_cursor()<CR>

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
"  Remember cursor position
" if !has('nvim')
" 	augroup vimrc-remember-cursor-position
" 		autocmd!
" 		autocmd BufReadPost * if line("'\" ) > 1 && line("'\" ) <= line("$") | exe "normal! g`\"  | endif
" 	augroup END
" endif

" "  make/cmake
"  augroup vimrc-make-cmake
"  	autocmd!
"  	autocmd FileType make setlocal noexpandtab
"  	autocmd BufNewFile,BufRead CMakeLists.txt setlocal filetype=cmake
"  augroup END

"  txt
" augroup vimrc-wrapping
" 	autocmd!
" 	autocmd BufRead,BufNewFile *.txt call s:setupWrapping()
" augroup END
" if has('nvim')
" 	au BufEnter * if &buftype == 'terminal' | :startinsert | endif
" 	autocmd BufEnter term://* startinsert
" 	autocmd TermOpen * set bufhidden=hide
" endif
"
" " vim-python
" augroup vimrc-python
" 	autocmd!
" 	autocmd FileType python setlocal expandtab shiftwidth=4 tabstop=4 colorcolumn=79
" 				\ formatoptions+=croq softtabstop=4 expandtab
" 				\ cinwords=if,elif,else,for,while,try,except,finally,def,class,with
" augroup END
" }}}

" display settings -------------------------------------------------------{{{
if !exists('g:vscode')
	colorscheme gruvbox
	set background=dark
	let g:gruvbox_contrast_dark = "hard"
	let g:gruvbox_contrast_light = "hard"
	let g:gruvbox_hls_cursor = "orange"
	let g:gruvbox_sign_column = "bg1"
	let g:gruvbox_italicize_strings = 0
	let g:gruvbox_improved_strings = 0
	let g:gruvbox_italic = 0
	let g:gruvbox_termcolors = 256
	if has("gui_running")
		let g:indentLine_color_gui = '#343d46'
		set guifont=JetbrainsMono\ NF:h13
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
	"  Themes, Commands, etc  ----------------------------------------------------{{{
	let g:oceanic_next_terminal_bold = 1
	let g:oceanic_next_terminal_italic = 1
	let g:oceanic_next_highlight_current_line =0
	" colorscheme OceanicNext
	" colorscheme one
	" set background=dark
	" }}}

	"  Vim-Devicons -------------------------------------------------------------{{{
		" let g:NERDTreeGitStatusNodeColorization = 1
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

	" vim-mergetool ----------------------------------------------{{{
	let g:mergetool_layout = 'mr'
	let g:mergetool_prefer_revision = 'local'
	"" }}}

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
	let g:airline_theme='gruvbox'
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
	let g:line_no_indicator_chars = [' ', '▁', '▂', '▃', '▄', '▅', '▆', '▇', '█']
	" let g:line_no_indicator_chars = ['⎺', '⎻', '⎼', '⎽', '_']
	" let g:airline_mode_map = {
	" 			\ 'n'  : 'N',
	" 			\ 'i' : 'I',
	" 			\ 'R' : 'R',
	" 			\ 'v' : 'v',
	" 			\ 'V' : 'V',
	" 			\ 'c' : 'C',
	" 			\ 's' : 's',
	" 			\ 'S' : 'S',
	" 			\ ''  : '',
	" 			\ 't' : 't',
	" 			\}
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
endif
" }}}

if !exists('g:vscode')

	" MarkDown ------------------------------------------------------------------{{{

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

	" }}}

	" HTML ----------------------------------------------------------------------{{{

	let g:neomake_html_enabled_makers = []
	let g:neoformat_enabled_html = ['htmlbeautify']
	" " For conceal markers.
	" if has('conceal')
	" 	set conceallevel=0 concealcursor=niv
	" endif
	let g:esearch = {
				\ 'adapter':    'ag',
				\ 'backend':    'nvim',
				\ 'out':        'win',
				\ 'batch_size': 1000,
				\ 'use':        ['visual', 'hlsearch', 'last'],
				\}

	" }}}

	" deoplete ------------------------------------------------------------------{{{
	let g:deoplete#enable_at_startup = 1

	" }}}

	" Echodoc  ------------ {{{
	let g:echodoc#enable_at_startup = 1
	let g:echodoc#type = 'signature'
	" }}}
	"  VDegug  -----------------------------------------------------------------{{{
	let g:vdebug_keymap = {
				\    "run" : "<F5>",
				\    "run_to_cursor" : "<S-F5>",
				\    "step_over" : "<F10>",
				\    "step_into" : "<F11>",
				\    "step_out" : "<S-F11>",
				\    "close" : "<C-F5>",
				\    "detach" : "<F6>",
				\    "set_breakpoint" : "<F9>",
				\    "get_context" : "<F4>",
				\    "eval_under_cursor" : "<A-F5>",
				\    "eval_visual" : "<Leader>e",
				\}
	"  }}}

	"  session management ----------------------------------------------------{{{
	if has('nvim')
		let g:session_directory = "~/.config/nvim/session"
	else
		let g:session_directory = "~/.vim/session"
	endif

	let g:session_autoload = "no"
	let g:session_autosave = "no"
	let g:session_command_aliases = 0
	let g:auto_save = 0
	let g:auto_save_no_updatetime = 1
	let g:auto_save_silent = 0
	let g:auto_save_postsave_hook = 'TagsGenerate'

	" }}}

	" Git ------------------------------------------------------------------------{{{
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
	" let g:nerdtree_tabs_open_on_gui_startup=0
	" let g:NERDTreeChDirMode=2
	" let g:NERDTreeIgnore=['\.rbc$', '\~$', '\.pyc$', '\.db$', '\.sqlite$', '__pycache__']
	" let g:NERDTreeSortOrder=['^__\.py$', '\/$', '*', '\.swp$', '\.bak$', '\~$']
	" let g:NERDTreeShowBookmarks=1
	" let g:nerdtree_tabs_focus_on_files=1
	" let g:NERDTreeMapOpenInTabSilent = '<RightMouse>'
	" let g:NERDTreeWinSize = 50
	" let NERDTreeShowHidden=1
	" let NERDTreeMinimalUI=1
	" let NERDTreeHijackNetrw=0
	" let NERDTreeCascadeSingleChildDir=1
	" let NERDTreeCascadeOpenSingleChildDir=1
	" let g:NERDTreeAutoDeleteBuffer=1
	" let g:NERDTreeShowIgnoredStatus = 0
	" let g:NERDTreeDirArrowExpandable = '>'
	" let g:NERDTreeDirArrowCollapsible = '-'
	" augroup vfinit
	" 	autocmd FileType unite call s:uniteinit()
	" augroup END
	" function! s:uniteinit()
	" 	nmap <buffer> <Esc> <Plug>(unite_exit)
	" endfunction
	" function! s:nerdtreeinit() abort
	" 	nunmap <buffer> K
	" 	nunmap <buffer> J
	" endf
	" }}}

	" vim-grammarous-------------------------------------------------------------{{{
	 let g:grammarous#hooks = {}
	 function! g:grammarous#hooks.on_check(errs) abort
		 nmap <buffer><C-n> <Plug>(grammarous-move-to-next-error)
		 nmap <buffer><C-p> <Plug>(grammarous-move-to-previous-error)
	 endfunction

	 function! g:grammarous#hooks.on_reset(errs) abort
		 nunmap <buffer><C-n>
		 nunmap <buffer><C-p>
	 endfunction
	let g:grammarous#languagetool_cmd = 'languagetool'
	" }}}

	" Goyo -------------------------------------------------------------------{{{
	function! s:goyo_enter()
		if executable('tmux') && strlen($TMUX)
			silent !tmux set status off
			silent !tmux list-panes -F '\#F' | grep -q Z || tmux resize-pane -Z
		endif
		set noshowmode
		set noshowcmd
		set scrolloff=999
		Limelight
		" ...
	endfunction

	function! s:goyo_leave()
		if executable('tmux') && strlen($TMUX)
			silent !tmux set status on
			silent !tmux list-panes -F '\#F' | grep -q Z && tmux resize-pane -Z
		endif
		set showmode
		set showcmd
		set scrolloff=5
		Limelight!
		" ...
	endfunction

	autocmd! User GoyoEnter nested call <SID>goyo_enter()
	autocmd! User GoyoLeave nested call <SID>goyo_leave()
	" }}}

	" limelight -------------------------------------------------------------------{{{

	" Color name (:help cterm-colors) or ANSI code
	let g:limelight_conceal_ctermfg = 'gray'
	let g:limelight_conceal_ctermfg = 240
	" Color name (:help gui-colors) or RGB color
	let g:limelight_conceal_guifg = 'DarkGray'
	let g:limelight_conceal_guifg = '#777777'
	" Default: 0.5
	let g:limelight_default_coefficient = 0.7
	" Number of preceding/following paragraphs to include (default: 0)
	" let g:limelight_paragraph_span = 1

	" Beginning/end of paragraph
	"   When there's no empty line between the paragraphs
	"   and each paragraph starts with indentation
	" let g:limelight_bop = '^\s'
	" let g:limelight_eop = '\ze\n^\s'

	" Highlighting priority (default: 10)
	"   Set it to -1 not to overrule hlsearch
	let g:limelight_priority = -1

	" }}}
	" lens -------------------------------------------------------------------{{{
 	" let g:lens#disabled = 1
	" let g:lens#disabled_filetypes = ['nerdtree', 'fzf']
	" let g:lens#animate = 0
	" }}}
	" vim-test -------------------------------------------------------------------{{{
	let test#strategy = "dispatch"
	let test#python#runner = 'pytest'
	let g:dispatch_compilers = {}
	let g:dispatch_compilers['pytest'] = 'pytest'
	" }}}
	" rainbow -------------------------------------------------------------------{{{
	let g:rainbow_active = 1
	" }}}

	" grep.vim -------------------------------------------------------------------{{{
	nnoremap <silent> <leader>F :Rgrep<CR>
	let Grep_Default_Options = '-IR'
	let Grep_Skip_Files = 'ctags* *.tmp tmp* *.log *.db'
	let Grep_Skip_Dirs = '.git node_modules tmp .history'
	" }}}

	"  Navigate between vim buffers and tmux panels ------------------------------{{{
	let g:tmux_navigator_no_mappings = 1
	" }}}

	" Tex ------------------------{{{
	if has('unix')
		if has('mac')
			let g:vimtex_compiler_latexmk = {
					\ 'options' : [
					\   '-pdf',
					\   '-shell-escape',
					\   '-verbose',
					\   '-file-line-error',
					\   '-synctex=1',
					\   '-interaction=nonstopmode',
					\ ],
					\}
			let g:vimtex_view_method = "skim"
			let g:vimtex_view_general_viewer
					\ = '/Applications/Skim.app/Contents/SharedSupport/displayline'
			let g:vimtex_view_general_options = '-r @line @pdf @tex'
			" This adds a callback hook that updates Skim after compilation
			let g:vimtex_compiler_callback_hooks = ['UpdateSkim']
			let g:vimtex_view_general_options_latexmk = '--unique'
			function! UpdateSkim(status)
				if !a:status | return | endif

				let l:out = b:vimtex.out()
				let l:tex = expand('%:p')
				let l:cmd = [g:vimtex_view_general_viewer, '-r']
				if !empty(system('pgrep Skim'))
				call extend(l:cmd, ['-g'])
				endif
				if has('nvim')
				call jobstart(l:cmd + [line('.'), l:out, l:tex])
				elseif has('job')
				call job_start(l:cmd + [line('.'), l:out, l:tex])
				else
				call system(join(l:cmd + [line('.'), shellescape(l:out), shellescape(l:tex)], ' '))
				endif
			endfunction
		else
			let g:latex_view_general_viewer = "zathura"
			let g:vimtex_view_method = "zathura"
		endif
	elseif has('win32')
	endif
	let g:tex_flavor = "latex"
	let g:vimtex_quickfix_open_on_warning = 0
	autocmd FileType tex nnoremap <silent> <2-LeftMouse> :VimtexView<CR>
	let g:vimtex_quickfix_mode = 2
	if has('nvim')
		let g:vimtex_compiler_progname = 'nvr'
	endif

	" One of the neosnippet plugins will conceal symbols in LaTeX which is
	" confusing
	let g:tex_conceal = ""

	" Can hide specifc warning messages from the quickfix window
	" Quickfix with Neovim is broken or something
	" https://github.com/lervag/vimtex/issues/773
	let g:vimtex_quickfix_latexlog = {
				\ 'default' : 1,
				\ 'fix_paths' : 0,
				\ 'general' : 1,
				\ 'references' : 1,
				\ 'overfull' : 1,
				\ 'underfull' : 1,
				\ 'font' : 1,
				\ 'packages' : {
				\   'default' : 1,
				\   'natbib' : 1,
				\   'biblatex' : 1,
				\   'babel' : 1,
				\   'hyperref' : 1,
				\   'scrreprt' : 1,
				\   'fixltx2e' : 1,
				\   'titlesec' : 1,
				\ },
				\}
	" }}}

	" change cursor in normal mode
	if exists('$TMUX')
 	    let &t_SI = "\<Esc>Ptmux;\<Esc>\<Esc>]50;CursorShape=1\x7\<Esc>\\"
	    let &t_EI = "\<Esc>Ptmux;\<Esc>\<Esc>]50;CursorShape=0\x7\<Esc>\\"
	else
	    let &t_SI = "\<Esc>]50;CursorShape=1\x7"
	    let &t_EI = "\<Esc>]50;CursorShape=0\x7"
	endif



	" Java ----------------------------------------------------------------------{{{
		autocmd FileType java setlocal omnifunc=javacomplete#Complete
	" }}}

	" Python --------------------------------------------------------------------{{{
		let g:python_host_prog = '/Users/yasser/.pyenv/versions/neovim2/bin/python'
		let g:python3_host_prog = '/Users/yasser/.pyenv/versions/neovim3/bin/python'
		" let $NVIM_PYTHON_LOG_FILE='nvim-python.log'
   " }}}


	" jedi-vim --------------------------------------------------------------------------{{{
	" let g:jedi#auto_vim_configuration = 1
	" let g:jedi#completions_enabled = 0
	" let g:jedi#popup_on_dot = 0
	" let g:jedi#goto_assignments_command = "ga"
	" let g:jedi#goto_definitions_command = "gd"
	" let g:jedi#documentation_command = "S-k"
	" let g:jedi#usages_command = "<F7>"
	" let g:jedi#rename_command = "<F2>"
	" let g:jedi#show_call_signatures = "1"
	" let g:jedi#completions_command = "<C-Space>"
	" let g:jedi#smart_auto_mappings = 0

	" Syntax highlight
	" Default highlight is better than polyglot
		let python_highlight_all = 1

	" }}}

	" ALE ------------------------------------------------------------------------{{{
		let g:ale_fixers = {
		\   '*': ['remove_trailing_lines', 'trim_whitespace'],
		\   'javascript': ['eslint'],
		\   'python': [ 'isort'],
		\}

		let g:ale_linters = {
					\ 'python': ['pyls'],
					\}

		" Set this variable to 1 to fix files when you save them.
		let g:ale_fix_on_save = 0
		let g:ale_completion_enabled = 0

		" let g:neomake_verbose = 3
		let g:ale_sign_warning = '•'
		" let g:ale_lint_on_text_changed = 'always'
		" let g:ale_lint_on_enter = 1
	" }}}



	" Fold, gets it's own section  ----------------------------------------------{{{
	" set foldtext=MyFoldText()
	" autocmd InsertEnter * if !exists('w:last_fdm') | let w:last_fdm=&foldmethod | setlocal foldmethod=manual | endif
	" autocmd InsertLeave,WinLeave * if exists('w:last_fdm') | let &l:foldmethod=w:last_fdm | unlet w:last_fdm | endif

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
	" let g:UltiSnipsEditSplit="vertical"
	" let g:UltiSnipsEnableSnipMate = 1
	" let g:UltiSnipsSnippetDirectories = ["UltiSnips"]


	"----------------------------------------------------------------------------}}}

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
	let g:instant_rst_browser="chrome"
	" InstaRST ---------- {{{
	" }}}

	" vim-css-colors ------------ {{{
	let g:cssColorVimDoNotMessMyUpdatetime = 1
	" }}}
	" " vim-slime -------------- {{{
	" if has("nvim")
	" 	let g:slime_target = "neovim"
	" else
	" 	let g:slime_target = "vimterminal"
	" endif
	" let g:slime_python_ipython = 1
	" " }}}
	" vim-slime-ipython ---------- {{{
	" let g:slime_ipython_no_mapping = 1
    "
	" " show or hide REPL terminal-console
	" nnoremap <Leader>py :ToggleConsole<CR>
    "
	" " cell manager
	" call submode#MapEnterKeys('cell-mode', ['<A-CR>', '<Leader><Esc>'])
	" call submode#MapLeaveKeys('cell-mode', ['<CR>', 'q'])
	" call submode#SetMaps('cell-mode', {
	" 	\ '<A-CR>': ':SendCurrentCellNext<CR>',
	" 	\ 'j': ':NextCell<CR>',
	" 	\ 'k': ':PrevCell<CR>',
	" 	\ 'J': ':MoveCellDown<CR>',
	" 	\ 'K': ':MoveCellUp<CR>',
	" 	\ 'dd': ':CutCurrentCell<CR>',
	" 	\ 'yy': ':CopyCurrentCell<CR>',
	" 	\ })
	" let g:slime_ipython_console_layout = {'position': 'right', 'width': 0.5}
	" let g:slime_ipython_repls = {
	" 	\ 'python': ["ipython3\n", "%cpaste -q\n", "--\n"],
	" 	\ 'python3': ["ipython3\n", "%cpaste -q\n", "--\n"],
	" 	\ 'sh': ["zsh\n", "", ""],
	" 	\ }
	" " }}}

	" Git Gutter ----------------{{{
		highlight GitGutterAdd guifg=#009900 ctermfg=Green
		highlight GitGutterChange guifg=#bbbb00 ctermfg=Yellow
		highlight GitGutterDelete guifg=#ff2222 ctermfg=Red
		nmap ) <Plug>(GitGutterNextHunk)
		nmap ( <Plug>(GitGutterPrevHunk)
		let g:gitgutter_enabled = 1
		let g:gitgutter_map_keys = 0
		let g:gitgutter_highlight_linenrs = 1"
	"" }}}

	" " Vim Hexokinase --------------{{{
	" 	let g:Hexokinase_refreshEvents = ['InsertLeave']
    "
	" 	let g:Hexokinase_optInPatterns = [
	" 	\     'full_hex',
	" 	\     'triple_hex',
	" 	\     'rgb',
	" 	\     'rgba',
	" 	\     'hsl',
	" 	\     'hsla',
	" 	\     'colour_names'
	" 	\ ]
    "
	" 	let g:Hexokinase_highlighters = ['backgroundfull']
    "
	" 	" Reenable hexokinase on enter
	" 	autocmd VimEnter * HexokinaseTurnOn
	" " }}}

	" Vim Quickscope --------{{{
		" Trigger a highlight in the appropriate direction when pressing these keys:
		let g:qs_highlight_on_keys = ['f', 'F', 't', 'T']
		highlight QuickScopePrimary guifg='#afff5f' gui=underline ctermfg=155 cterm=underline
		highlight QuickScopeSecondary guifg='#5fffff' gui=underline ctermfg=81 cterm=underline
	" }}}

	" Vim Auto Closetag------ {{{
		" filenames like *.xml, *.html, *.xhtml, ...
		" These are the file extensions where this plugin is enabled.
		let g:closetag_filenames = '*.html,*.xhtml,*.php,*.phtml,*.js'

		" filenames like *.xml, *.xhtml, ...
		" This will make the list of non-closing tags self-closing in the specified files.
		let g:closetag_xhtml_filenames = '*.xhtml,*.php,*.jsx,*.js'

		" filetypes like xml, html, xhtml, ...
		" These are the file types where this plugin is enabled.
		let g:closetag_filetypes = 'html,xhtml,phtml,*.php,js'

		" filetypes like xml, xhtml, ...
		" This will make the list of non-closing tags self-closing in the specified files.
		let g:closetag_xhtml_filetypes = 'xhtml,jsx,js'

		" integer value [0|1]
		" This will make the list of non-closing tags case-sensitive (e.g. `<Link>` will be closed while `<link>` won't.)
		let g:closetag_emptyTags_caseSensitive = 1

		" dict
		" Disables auto-close if not in a "valid" region (based on filetype)
		let g:closetag_regions = {
					\ 'typescript.tsx': 'jsxRegion,tsxRegion',
					\ 'javascript.jsx': 'jsxRegion',
					\ }

		" Shortcut for closing tags, default is '>'
		let g:closetag_shortcut = '>'

		" Add > at current position without closing the current tag, default is ''
		let g:closetag_close_shortcut = '<leader>>'
	" }}}
	" vim-workspace ------------------{{{
	let g:workspace_create_new_tabs = 0
	let g:workspace_autosave = 0
	let g:workspace_autosave_untrailspaces = 1
	let g:workspace_autosave_ignore = ['gitcommit']
	let g:workspace_autosave_always = 0
	let g:workspace_persist_undo_history = 0
	" }}}
endif

" Functions -----------------------------------------------------------------{{{
if !exists('*s:setupWrapping')
	function s:setupWrapping()
		set wrap
		set wm=2
		set textwidth=79
	endfunction
endif

function! SetBackground()
	if &background == 'dark'
		execute "set background=light"
	else
		execute "set background=dark"
	endif
endfunction

function! MyFoldText()
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
endfunction

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

function! s:DiffWithSaved()
  let filetype=&ft
  diffthis
  vnew | r # | normal! 1Gdd
  diffthis
  exe "setlocal bt=nofile bh=wipe nobl noswf ro ft=" . filetype
endfunction
com! DiffSaved call s:DiffWithSaved()

" }}}
" supertab {{{
"  let g:SuperTabClosePreviewOnPopupClose = 1
"  let g:SuperTabCrMapping = 1
"  let g:SuperTabLongestHighlight = 1
"  let g:SuperTabDefaultCompletionType = "<c-n>"
"  let g:SuperTabContextDefaultCompletionType = "<c-n>"

 " }}}
 " true color things --- {{{
 if has('nvim')
	 let $NVIM_TUI_ENABLE_TRUE_COLOR=1
 endif
hi Quote ctermbg=109 guifg=#83a598
 " }}}
 "
" to close a hanging float use <c-w>o
" Highlighting colors
" highlight CursorLine gui=underline cterm=underline

"  customize search results colors
highlight Search ctermbg=LightBlue ctermfg=LightBlue guibg=DarkBlue guifg=Yellow
highlight IncSearch guibg=LightBlue ctermbg=LightBlue term=underline