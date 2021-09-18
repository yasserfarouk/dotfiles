#!/usr/bin/env bash

# load the correct .inputrc file
# source  ~/.inputrc
[ -f ~/.prebashrc ] && source ~/.prebashrc
[ -f ~/.exports ] && source ~/.exports
[ -f ~/.aliases ] && source ~/.aliases
[ -f ~/.zfolder/z.sh ] && source ~/.zfolder/z.sh

[ -f $HOME/fzf.bash ] && source $HOME/.fzf.bash
[ -f ~/.postbashrc ] && source ~/.postbashrc


if command -v direnv >/dev/null; then
	eval "$(direnv hook bash)"
fi


if [ -f $HOME/anaconda3/bin/conda ] ; then
	# >>> conda initialize >>>
	# !! Contents within this block are managed by 'conda init' !!
	__conda_setup="$('/export/home/yasser/anaconda3/bin/conda' 'shell.bash' 'hook' 2> /dev/null)"
	if [ $? -eq 0 ]; then
			eval "$__conda_setup"
	else
			if [ -f "/export/home/yasser/anaconda3/etc/profile.d/conda.sh" ]; then
					. "/export/home/yasser/anaconda3/etc/profile.d/conda.sh"
			else
					export PATH="/export/home/yasser/anaconda3/bin:$PATH"
			fi
	fi
	unset __conda_setup
	# <<< conda initialize <<<
fi

eval "$(starship init bash)"
