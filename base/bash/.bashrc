#!/usr/bin/env bash

# load the correct .inputrc file
# source  ~/.inputrc
[ -f ~/.prebashrc ] && source ~/.prebashrc
[ -f ~/.exports ] && source ~/.exports
[ -f ~/.aliases ] && source ~/.aliases
[ -f ~/.zfolder/z.sh ] && source ~/.zfolder/z.sh
[ -f $HOME/fzf.bash ] && source $HOME/.fzf.bash
[ -f ~/.postbashrc ] && source ~/.postbashrc

# if command -v pyenv >/dev/null; then
# 	eval "$(pyenv init -)"
# 	eval "$(pyenv virtualenv-init -)"
# 	# make py-launcher use pyenv global version
# 	export PY_PYTHON=$(pyenv exec python -c "import sys; print('.'.join(map(str, sys.version_info[:2])))")
# 	ANACONDAPATH=`pyenv virtualenv-prefix miniforge3`
# 	if [ -z $ANACONDAPATH ]; then
# 		if [ -d "$HOME/anaconda3" ]; then
# 			ANACONDAPATH="$HOME/anaconda3"
# 		else
# 			ANACONDAPATH="$HOME/miniforge3"
# 		fi
# 	fi
# else
# 	if [ -d "$HOME/anaconda3" ]; then
# 		ANACONDAPATH="$HOME/anaconda3"
# 	else
# 		ANACONDAPATH="$HOME/miniforge3"
# 	fi
# fi
