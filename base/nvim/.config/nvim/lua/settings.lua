vim.cmd([[
set signcolumn=yes
let mapleader = ' '
let maplocalleader = ','
set clipboard=unnamed,unnamedplus
set confirm
set termguicolors
set t_Co=256
set conceallevel=0
set mouse=a
set mousemodel=popup
set encoding=utf-8
set fileencoding=utf-8
set fileencodings=utf-8
set hidden
set nopaste
set noshowmode
set tabstop=4 shiftwidth=4 expandtab
set splitbelow splitright
set conceallevel=0
set colorcolumn=79
set virtualedit=
set laststatus=2
set linebreak nolist
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
set timeoutlen=500
set updatetime=200
set guifont="JetBrainsMono Nerd Font Mono":h10
set colorcolumn=79
set wildmenu
set wildmode=list:longest,list:full
set wildignore+=*/tmp/*,*.so,*.swp,*.pyc,*.db,*.sqlite
set wildignore+=*.o,*.obj,.git,*.rbc,*.pyc,__pycache__,*_build/*,**coverage/*
set wildignore+=**node_modules/*,**android/*,**/.git/*
set complete=.,w,b,u,t,k
set ttyfast
set synmaxcol=200
set backspace=indent,eol,start
set ignorecase
set smartcase
set fileencoding=utf-8
set fileencodings=utf-8
set noswapfile
set lazyredraw
set redrawtime=500
set title
set titleold="Terminal"
set titlestring=%F
set scrolloff=3
set laststatus=2
set ruler
set nowrap
set modeline
set modelines=10
set undofile
set undodir="$HOME/.VIM_UNDO_FILES"
set exrc
set secure
set nobackup
set noswapfile
set fileformats=unix,mac,dos
set autoread
set dictionary+=/usr/share/dict/words
set thesaurus+=$HOME/.ysupport/thesaurii.txt
set cursorline
let g:neoformat_enabled_python = ['black']
let g:python_host_prog='$HOME/virtualenvs/neovim2/bin/python'
let g:python3_host_prog='$HOME/virtualenvs/neovim3/bin/python'
set foldmethod=indent
set foldcolumn=1
]])
