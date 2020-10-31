set nocompatible
filetype plugin indent on


source $HOME/.config/nvim/settings/basic.vim  
source $HOME/.config/nvim/settings/functions.vim
source $HOME/.config/nvim/settings/mappings.vim
source $HOME/.config/nvim/settings/textobjects.vim
if !exists('g:vscode')
	source $HOME/.config/nvim/settings/statusline.vim
	source $HOME/.config/nvim/settings/gui.vim
	source $HOME/.config/nvim/settings/plugins.vim
	" firenvim for chrome
	if has('nvim')
		source $HOME/.config/nvim/settings/firenvim.vim
	endif
	" language tool for grammatical check
	" source $HOME/.config/nvim/settings/languagetool.vim
	" navigation
	" source $HOME/.config/nvim/settings/quickscope.vim
	source $HOME/.config/nvim/settings/multicursor.vim
	" file drawer (I use coc-explorer now)
	" source $HOME/.config/nvim/settings/fern.vim
	" source $HOME/.config/nvim/settings/nerdtree.vim
	" session management
	" source $HOME/.config/nvim/settings/workspace.vim
	source $HOME/.config/nvim/settings/session.vim
	" window management
	source $HOME/.config/nvim/settings/lens.vim
	" language client
	source $HOME/.config/nvim/settings/coc.vim
	" source $HOME/.config/nvim/settings/ale.vim
	" debugging
	source $HOME/.config/nvim/settings/vimspector.vim
	" source $HOME/.config/nvim/settings/languageclient.vim
	" testing
	source $HOME/.config/nvim/settings/vimtest.vim
	" code editing
	source $HOME/.config/nvim/settings/rainbow.vim
	source $HOME/.config/nvim/settings/closetag.vim
	source $HOME/.config/nvim/settings/tcomment.vim
	" git
	source $HOME/.config/nvim/settings/git.vim
	source $HOME/.config/nvim/settings/mergetool.vim
	" source $HOME/.config/nvim/settings/gitgutter.vim
	source $HOME/.config/nvim/settings/fugitive.vim
	" language settings
	source $HOME/.config/nvim/settings/markdown.vim
	source $HOME/.config/nvim/settings/html.vim
	source $HOME/.config/nvim/settings/java.vim
	source $HOME/.config/nvim/settings/python.vim
	source $HOME/.config/nvim/settings/tex.vim
	" writing
	source $HOME/.config/nvim/settings/grammarous.vim
	" searching
	source $HOME/.config/nvim/settings/fzf.vim
	source $HOME/.config/nvim/settings/ctrls.vim
	" source $HOME/.config/nvim/settings/ag.vim
	" source $HOME/.config/nvim/settings/easysearch.vim
	" tmux
	source $HOME/.config/nvim/settings/tmux.vim
	source $HOME/.config/nvim/settings/tmux_navigator.vim
	" snippets
	source $HOME/.config/nvim/settings/snippets.vim
	" terminals
	source $HOME/.config/nvim/settings/floatterm.vim
	source $HOME/.config/nvim/settings/tablemode.vim
	" key help
	" source $HOME/.config/nvim/settings/ultisnip.vim
	" ripple
	" source $HOME/.config/nvim/settings/slime.vim
	" coloring
	" source $HOME/.config/nvim/settings/hexokinase.vim
	" statusbar
	" source $HOME/.config/nvim/settings/airline.vim
	" distraction free editing
	" source $HOME/.config/nvim/settings/goyo.vim
	" source $HOME/.config/nvim/settings/limelight.vim
	" visual appearance
	source $HOME/.config/nvim/settings/visual.vim
	source $HOME/.config/nvim/settings/theme.vim
	source $HOME/.config/nvim/settings/whichkey.vim
else
	" source $HOME/.config/nvim/settings/vscode.vim
endif
