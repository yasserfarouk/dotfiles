set nocompatible
filetype plugin indent on


source $HOME/.config/vim/settings/basic.vim
source $HOME/.config/vim/settings/functions.vim
source $HOME/.config/vim/settings/mappings.vim
source $HOME/.config/vim/settings/textobjects.vim
if !exists('g:vscode')
	let g:telescope_available = 0
	" source $HOME/.config/vim/settings/telescope.vim
	source $HOME/.config/vim/settings/statusline.vim
	source $HOME/.config/vim/settings/gui.vim
	source $HOME/.config/vim/settings/plugins.vim
	" firenvim for chrome
	if has('nvim')
		" source $HOME/.config/vim/settings/firenvim.vim
		source $HOME/.config/vim/settings/ghost.vim
	endif
	" language tool for grammatical check
	" source $HOME/.config/vim/settings/languagetool.vim
	" navigation
	" source $HOME/.config/vim/settings/quickscope.vim
	" source $HOME/.config/vim/settings/multicursor.vim
	" source $HOME/.config/vim/settings/session.vim
	source $HOME/.config/vim/settings/startify.vim
	" window management
	" source $HOME/.config/vim/settings/lens.vim
	" language client
	source $HOME/.config/vim/settings/coc.vim
	" source $HOME/.config/vim/settings/ale.vim
	" debugging
	source $HOME/.config/vim/settings/vimspector.vim
	" source $HOME/.config/vim/settings/languageclient.vim
	" testing
	source $HOME/.config/vim/settings/vimtest.vim
	source $HOME/.config/vim/settings/ultest.vim
	" code editing
	source $HOME/.config/vim/settings/rainbow.vim
	source $HOME/.config/vim/settings/closetag.vim
	source $HOME/.config/vim/settings/tcomment.vim
	source $HOME/.config/vim/settings/unstack.vim
	" source $HOME/.config/vim/settings/treesitter.vim
	" git
	source $HOME/.config/vim/settings/git.vim
	source $HOME/.config/vim/settings/mergetool.vim
	" source $HOME/.config/vim/settings/gitgutter.vim
	source $HOME/.config/vim/settings/fugitive.vim
	" language settings
	source $HOME/.config/vim/settings/markdown.vim
	source $HOME/.config/vim/settings/html.vim
	source $HOME/.config/vim/settings/java.vim
	source $HOME/.config/vim/settings/python.vim
	source $HOME/.config/vim/settings/pydocstring.vim
	source $HOME/.config/vim/settings/tex.vim
	" writing
	source $HOME/.config/vim/settings/grammarous.vim
	" searching
	source $HOME/.config/vim/settings/fzf.vim
	source $HOME/.config/vim/settings/ctrls.vim
	source $HOME/.config/vim/settings/anyjump.vim
	" source $HOME/.config/vim/settings/ag.vim
	" source $HOME/.config/vim/settings/easysearch.vim
	" tmux
	source $HOME/.config/vim/settings/tmux.vim
	source $HOME/.config/vim/settings/tmux_navigator.vim
	" snippets
	source $HOME/.config/vim/settings/snippets.vim
	" terminals
	source $HOME/.config/vim/settings/floatterm.vim
	source $HOME/.config/vim/settings/tablemode.vim
	" display
	source $HOME/.config/vim/settings/context.vim
	" close buffer without closing window
	source $HOME/.config/vim/settings/bunlink.vim
	" source $HOME/.config/vim/settings/unstack.vim
	" file drawer (I use coc-explorer now)
	" source $HOME/.config/vim/settings/fern.vim
	" source $HOME/.config/vim/settings/nerdtree.vim
	" session management
	" source $HOME/.config/vim/settings/workspace.vim
	" key help
	" source $HOME/.config/vim/settings/ultisnip.vim
	" ripple
	" source $HOME/.config/vim/settings/slime.vim
	" coloring
	" source $HOME/.config/vim/settings/hexokinase.vim
	" statusbar
	" source $HOME/.config/vim/settings/airline.vim
	" distraction free editing
	" source $HOME/.config/vim/settings/goyo.vim
	" source $HOME/.config/vim/settings/limelight.vim
	" visual appearance
	source $HOME/.config/vim/settings/visual.vim
	source $HOME/.config/vim/settings/theme.vim
	source $HOME/.config/vim/settings/whichkey.vim
else
	" source $HOME/.config/vim/settings/vscode.vim
endif
