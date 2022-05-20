#!/usr/bin/env zsh

# [[ $ZSHENVCALLED = "" ]] && source ~/.zshenv
[ -f ~/.prezshrc ] && source ~/.prezshrc
[ -f  ~/.aliases ] && source ~/.aliases
[ -f  ~/.zshenv ] && source ~/.zshenv
[ -f ~/.zfolder/z.sh ] && source ~/.zfolder/z.sh
[ -f ~/.exports ] && source ~/.exports

if ! [ -z $ZPROFILE_EXPORTED ]; then
	[ -f  ~/.zprofile ] && source ~/.zprofile
fi

autoload -U promptinit; promptinit
unset file
# zstyle ':completion:*:*:git:*' script $HOME/.ysupport/git-completion.bash

zle -N edit-command-line

[ -f  ~/antigen.zsh ] && source ~/antigen.zsh
antigen bundle git
antigen bundle pip
antigen bundle zsh-users/zsh-syntax-highlighting
antigen bundle zsh-users/zsh-autosuggestions
antigen bundle mafredri/zsh-async
# antigen bundle sindresorhus/pure
antigen apply


[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion


if command -v direnv >/dev/null; then
	eval "$(direnv hook zsh)"
fi

# Enable Ctrl-x-e to edit command line
autoload -U edit-command-line
# Emacs style
zle -N edit-command-line
bindkey '^xe' edit-command-line
bindkey '^x^e' edit-command-line
autoload -Uz compinit
zstyle ':completion:*' menu select
fpath+=~/.zfunc

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh


eval "$(starship init zsh)"


# # >>> conda initialize >>>
# # !! Contents within this block are managed by 'conda init' !!
# __conda_setup="$('/Users/yasser/miniforge3/bin/conda' 'shell.zsh' 'hook' 2> /dev/null)"
# if [ $? -eq 0 ]; then
#     eval "$__conda_setup"
# else
#     if [ -f "/Users/yasser/miniforge3/etc/profile.d/conda.sh" ]; then
#         . "/Users/yasser/miniforge3/etc/profile.d/conda.sh"
#     else
#         export PATH="/Users/yasser/miniforge3/bin:$PATH"
#     fi
# fi
# unset __conda_setup
# # <<< conda initialize <<<
#
if command -v pyenv >/dev/null; then
	eval "$(pyenv init -)"
	eval "$(pyenv virtualenv-init -)"
	# make py-launcher use pyenv global version
	export PY_PYTHON=$(pyenv exec python -c "import sys; print('.'.join(map(str, sys.version_info[:2])))")
	ANACONDAPATH=`pyenv virtualenv-prefix miniforge3`
	if [ -z $ANACONDAPATH ]; then
		if [ -d "$HOME/anaconda3" ]; then
			ANACONDAPATH="$HOME/anaconda3"
		else
			ANACONDAPATH="$HOME/miniforge3"
		fi
	fi
else
	if [ -d "$HOME/anaconda3" ]; then
		ANACONDAPATH="$HOME/anaconda3"
	else
		ANACONDAPATH="$HOME/miniforge3"
	fi
fi

[ -f ~/.postzsh ] && source ~/.postzsh

export PATH="$HOME/.poetry/bin:$PATH"
