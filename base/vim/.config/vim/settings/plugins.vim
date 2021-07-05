" Install Plugins -----------------------------------------------------------{{{

" install Plug if needed
let vimplug_exists=expand('~/.vim/autoload/plug.vim')
if !filereadable(vimplug_exists)
	if !executable("curl")
		echoerr "You have to install curl or first install vim-plug yourself!"
		execute "q!"
	endif
	echo "Installing Vim-Plug..."
	if has('nvim')
		let $NVIM_TUI_ENABLE_TRUE_COLOR=1
	endif
	silent !\curl -fLo ~/.vim/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
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
" Better way to see registers upon hitting ", @, <C-R> (insert)
" Plug 'junegunn/vim-peekaboo'
" replacement of :bd that does not close the window.
" jump to any definition or reference
Plug 'pechorin/any-jump.vim'
" copy a visual block and move it anywhere using Block command
Plug 'Rasukarusan/vim-block-paste'
" sidebar with symbols (works with coc. Not sure if it works with builtin lsp)
Plug 'liuchengxu/vista.vim'
" allows for moving arguments or lists or some table columns sideways
Plug 'AndrewRadev/sideways.vim'
" shows surrounding context for code
Plug 'wellle/context.vim'
" search and replace
Plug 'brooth/far.vim'
" shows whichkey menues when leader or other keys are pressed
Plug 'liuchengxu/vim-which-key'
" Asynchronous running
Plug 'skywind3000/asyncrun.vim'
" testing plugins
Plug '5long/pytest-vim-compiler'
" Plug 'reinh/vim-makegreen'
" remove the need to use ; for f/t
" Plug 'rhysd/clever-f.vim'
" search and replace multiple forms of a word and turn to snake_case,
" camelCase, etc
Plug 'tpope/vim-abolish'
" A simple REPL for vim
Plug 'urbainvaes/vim-ripple'
Plug 'schickling/vim-bufonly'
" allows for using * to search on a visual selection
Plug 'nelstrom/vim-visual-star-search'
" easy navigation between vim and tmux
Plug 'christoomey/vim-tmux-navigator'
" undo history
Plug 'mbbill/undotree'
" extra text objects
Plug 'kana/vim-textobj-user'
Plug 'rhysd/vim-textobj-anyblock'
Plug 'kana/vim-textobj-line'
Plug 'michaeljsmith/vim-indent-object'
Plug 'vim-scripts/argtextobj.vim'
" moves with CamelCase and snake_case words
" Plug 'bkad/CamelCaseMotion'
" nice ripple with results in virtual text.
" Plug 'metakirby5/codi.vim'
" provides gF in normal and visual mode to go to file with line and column
" numbers.
Plug 'wsdjeg/vim-fetch'
" " highlight yanked text only needed for old vim/nvim
" Plug 'machakann/vim-highlightedyank'
" diff full folders
Plug 'will133/vim-dirdiff'
" nice icons for file explorers
Plug 'ryanoasis/vim-devicons'
" file explorer
" Plug 'lambdalisue/fern.vim'
" changes the highlighting on the current search match
Plug 'PeterRincker/vim-searchlight'
" Session management
" Plug 'tpope/vim-obsession'
Plug 'mhinz/vim-startify'
" Plug 'dhruvasagar/vim-prosession'
" match parenthesis etc
Plug 'tmhedberg/matchit'
" add closing parentheses automatically.
Plug 'jiangmiao/auto-pairs'
" closes html tags
Plug 'alvan/vim-closetag'
" maps <leader>[, <leader>] to move to top and bottom of indent
Plug 'tmhedberg/indent-motion'
" snippets
Plug 'honza/vim-snippets'
" surrounding text
Plug 'tpope/vim-surround'
" provides pairs of useful maps
Plug 'tpope/vim-unimpaired'
" allows repeating more things with .
Plug 'tpope/vim-repeat'
" commenting
Plug 'tomtom/tcomment_vim'
" replace text without yanking. I mapped it to gr for replace and gx for
" exchange
Plug 'romgrk/replace.vim'
" Laravel support
Plug 'noahfrederick/vim-laravel'
" Plug 'mattn/emmet-vim'
" fast search with two characters mapped to s
Plug 'justinmk/vim-sneak'
" gives MergetoolToggle command to handle merging of conflicts
Plug 'samoshkin/vim-mergetool'
" colorizes whitespaces at the end of lines
Plug 'ntpeters/vim-better-whitespace'
Plug 'voldikss/vim-floaterm'
" zooms windows out and in using <c-w>m
Plug 'dhruvasagar/vim-zoom'
" grammer checks
Plug 'rhysd/vim-grammarous'
" Plug 'vigoux/LanguageTool.nvim'
" search using CtrlSF
Plug 'dyng/ctrlsf.vim'
" vimtex support
Plug 'lervag/vimtex'
" " improves concealment vimtext
" Plug   'KeitaNakamura/tex-conceal.vim', {'for': 'tex'} " for VimPlug
" syntax highlighting for pandoc
Plug 'vim-pandoc/vim-pandoc-syntax'
Plug 'heavenshell/vim-pydocstring', { 'do': 'make install' }
" colorschemes 
Plug 'morhetz/gruvbox'
Plug 'flazz/vim-colorschemes'
" Plug 'joshdick/onedark.vim'
" Plug 'altercation/vim-colors-solarized'
Plug 'mhartington/oceanic-next'
" dash search
if has('macunix')
	Plug 'rizzatti/dash.vim'
endif
" adds motions for python
Plug 'jeetsukumaran/vim-pythonsense'
Plug 'vim-python/python-syntax'
" better indenting for python
Plug 'Vimjas/vim-python-pep8-indent'
" colorize parentheses
Plug 'luochen1990/rainbow'
" debugging
Plug 'puremourning/vimspector'
" Plug 'vim-vdebug/vdebug'
" used for alternate files etc. I do not use it
" Plug 'tpope/vim-projectionist'     
" Dispatch command to run things asyncronously. I need it for vimtest
Plug 'tpope/vim-dispatch'             
" Adds Move commands and the like
Plug 'tpope/vim-eunuch'
" " Multi-cursor support. Probably not needed
" Plug 'terryma/vim-multiple-cursors'

" testing
Plug 'janko/vim-test'
" language servers
Plug 'neoclide/coc.nvim', {'do': 'yarn install --frozen-lockfile'}
Plug 'majutsushi/tagbar'
" git
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-rhubarb'
" work with tables
Plug 'godlygeek/tabular'
Plug 'dhruvasagar/vim-table-mode'
" json highlighting
Plug 'elzr/vim-json'
" fold diffs
Plug 'sgeb/vim-diff-fold'
" Plug 'tmhedberg/SimpylFold', {'for': 'python'}
" Markdown support
Plug 'tpope/vim-markdown', {'for': 'markdown'}
Plug 'iamcco/markdown-preview.nvim', { 'do': 'cd app & yarn install' }
Plug 'nelstrom/vim-markdown-folding', {'for': 'markdown'}
Plug 'vim-scripts/grep.vim'
" shows indentation lines
Plug 'Yggdroot/indentLine'
Plug 'vim-scripts/guicolorscheme.vim'
" fuzzy search
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'
" used to unstack stack traces. just overides <space>s which I need.
Plug 'mattboehm/vim-unstack'
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
" Plug 'NLKNguyen/pipe.vim'
" Plug 'NLKNguyen/pipe-mysql.vim'
" Plug 'camspiers/animate.vim'
" Plug 'camspiers/lens.vim'
" Plug 'chrisbra/Colorizer'
" Plug 'Rykka/riv.vim'
" Plug 'Rykka/InstantRst'
" Plug 'psf/black', { 'tag': '19.10b0' }
" Plug 'ervandew/supertab'
" easy alignment. Seems broken somewhow
" Plug 'junegunn/vim-easy-align'
" better highlighting for python
" }}}


