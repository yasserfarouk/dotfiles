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

" A function to conditionally load a plugin
function! Cond(cond, ...)
	let opts = get(a:000, 0, {})
	return a:cond ? opts : extend(opts, { 'on': [], 'for': [] })
endfunction

" define all plugins
call plug#begin(expand('~/.vim/plugged'))

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
Plug 'justinmk/vim-sneak'
Plug 'samoshkin/vim-mergetool'
Plug 'ntpeters/vim-better-whitespace'
Plug 'voldikss/vim-floaterm'
Plug 'dhruvasagar/vim-zoom'
Plug 'rhysd/vim-grammarous'
Plug 'dyng/ctrlsf.vim'
Plug 'alvan/vim-closetag'
Plug 'lervag/vimtex'
" Plug 'easymotion/vim-easymotion'
Plug 'vim-pandoc/vim-pandoc-syntax'
Plug 'unblevable/quick-scope'
Plug 'heavenshell/vim-pydocstring', Cond(!has('nvim'))
Plug 'morhetz/gruvbox'
if has('macunix')
	Plug 'rizzatti/dash.vim'
endif
Plug 'vim-python/python-syntax'
" adds motions for python
Plug 'jeetsukumaran/vim-pythonsense'
" better indenting for python
Plug 'Vimjas/vim-python-pep8-indent'
Plug 'luochen1990/rainbow'
" Plug 'junegunn/limelight.vim'
" Plug 'junegunn/goyo.vim'
Plug 'puremourning/vimspector'
" Plug 'vim-vdebug/vdebug'
Plug 'tpope/vim-projectionist'        "|
Plug 'tpope/vim-dispatch'             "| Optional
Plug 'tpope/vim-eunuch'
Plug 'terryma/vim-multiple-cursors'
Plug 'janko/vim-test'
Plug 'alfredodeza/pytest.vim'
Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'majutsushi/tagbar'
Plug 'altercation/vim-colors-solarized'
Plug 'mhartington/oceanic-next'
Plug 'tpope/vim-fugitive'
Plug 'dhruvasagar/vim-table-mode'
Plug 'elzr/vim-json'
Plug 'flazz/vim-colorschemes'
Plug 'sgeb/vim-diff-fold'
Plug 'tmhedberg/SimpylFold', {'for': 'python'}
Plug 'tpope/vim-markdown', {'for': 'markdown'}
Plug 'godlygeek/tabular'
Plug 'iamcco/markdown-preview.nvim', { 'do': 'cd app & yarn install' }
Plug 'nelstrom/vim-markdown-folding', {'for': 'markdown'}
Plug 'vim-scripts/grep.vim'
Plug 'Yggdroot/indentLine'
Plug 'vim-scripts/guicolorscheme.vim'
Plug 'christoomey/vim-tmux-navigator'
Plug 'Shougo/neosnippet-snippets'
if isdirectory('/usr/local/opt/fzf')
	Plug '/usr/local/opt/fzf' | Plug 'junegunn/fzf.vim'
else
	Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --bin' }
	Plug 'junegunn/fzf.vim'
endif
call plug#end()
" Plug 'z-huabao/vim-submode'
" Plug 'z-huabao/vim-slime-ipython'
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
" Plug 'vim-scripts/SyntaxRange'
" Plug 'ludovicchabant/vim-gutentags'
" Plug 'SirVer/ultisnips'
" Plug 'MartinLafreniere/vim-PairTools'
" Plug 'ryanoasis/vim-devicons'
" Plug 'NLKNguyen/pipe.vim'
" Plug 'NLKNguyen/pipe-mysql.vim'
" Plug 'camspiers/animate.vim'
" Plug 'camspiers/lens.vim'
" Plug 'chrisbra/Colorizer'
" Plug 'Rykka/riv.vim'
" Plug 'Rykka/InstantRst'
" Plug 'psf/black', { 'tag': '19.10b0' }
" Plug 'ervandew/supertab'
" better highlighting for python
" }}}
