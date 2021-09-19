#!/usr/bin/env zsh

# [[ $ZSHENVCALLED = "" ]] && source ~/.zshenv
[ -f ~/.prezshrc ] && source ~/.prezshrc
[ -f  ~/.aliases ] && source ~/.aliases
[ -f  ~/.zshenv ] && source ~/.zshenv
[ -f ~/.zfolder/z.sh ] && source ~/.zfolder/z.sh

if ! [ -z $ZPROFILE_EXPORTED ]; then
	[ -f  ~/.zprofile ] && source ~/.zprofile
fi

autoload -U promptinit; promptinit
unset file
# zstyle ':completion:*:*:git:*' script $HOME/.ysupport/git-completion.bash

zle -N edit-command-line

[ -f  ~/antigen/antigen.zsh ] && source ~/antigen/antigen.zsh
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
[ -f ~/.postzsh ] && source ~/.postzsh

if [ -f $HOME/anaconda3/bin/conda ] ; then
	__conda_setup="$('$HOME/anaconda3/bin/conda' 'shell.zsh' 'hook' 2> /dev/null)"
	if [ $? -eq 0 ]; then
			eval "$__conda_setup"
	else
			if [ -f "$HOME/anaconda3/etc/profile.d/conda.sh" ]; then
					. "$HOME/anaconda3/etc/profile.d/conda.sh"
			else
					export PATH="$HOME/anaconda3/bin:$PATH"
			fi
	fi
	unset __conda_setup
fi

eval "$(starship init zsh)"
