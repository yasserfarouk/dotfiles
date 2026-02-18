#!/bin/zsh

# [[ $ZSHENVCALLED = "" ]] && source ~/.zshenv
[ -f ~/.prezshrc ] && source ~/.prezshrc
[ -f  ~/.aliases ] && source ~/.aliases
[ -f  ~/.zshenv ] && source ~/.zshenv
[ -f ~/.zfolder/z.sh ] && source ~/.zfolder/z.sh
[ -f ~/.exports ] && source ~/.exports
[ -f ~/.keys ] && source ~/.keys

if ! [ -z $ZPROFILE_EXPORTED ]; then
	[ -f  ~/.zprofile ] && source ~/.zprofile
fi

autoload -U promptinit; promptinit
unset file
# zstyle ':completion:*:*:git:*' script $HOME/.ysupport/git-completion.bash

zle -N edit-command-line

[ -f  ~/antigen.zsh ] && source ~/antigen.zsh

# Use antigen cache for faster loading and less verbose output
ANTIGEN_CACHE="$HOME/.antigen/init.zsh"

antigen bundle git
antigen bundle pip
antigen bundle zsh-users/zsh-syntax-highlighting
antigen bundle zsh-users/zsh-autosuggestions
antigen bundle mafredri/zsh-async
# antigen bundle sindresorhus/pure

# Apply quietly - suppress both stdout and stderr
antigen apply &> /dev/null

# Lazy load NVM to speed up shell startup
# NVM bash completion - only load if NVM is actually installed
[ -s "$NVM_DIR/nvm.sh" ] && {
	# Lazy load nvm - only initialize when called
	nvm() {
		unset -f nvm
		[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"
		[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"
		nvm "$@"
	}
	# Add default node to path without loading full nvm
	export PATH="$NVM_DIR/versions/node/$(cat $NVM_DIR/alias/default 2>/dev/null || echo 'v20.0.0')/bin:$PATH"
}


if command -v direnv >/dev/null; then
	eval "$(direnv hook zsh)"
fi

# Enable Ctrl-x-e to edit command line
autoload -U edit-command-line
# Emacs style
zle -N edit-command-line
bindkey '^xe' edit-command-line
bindkey '^x^e' edit-command-line

# Optimize compinit - only run once per day
fpath+=$HOME/.zfunc
autoload -Uz compinit
# Check if compinit cache is older than 24 hours
if [[ -n ~/.zcompdump(#qN.mh+24) ]]; then
	compinit
else
	compinit -C  # Skip security check for speed
fi
zstyle ':completion:*' menu select

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh



# if [ $ENABLE_PYENV = true ] ; then
# 	function pyenvrehash(){
# 		command pyenv rehash 2>/dev/null
# 	}
# 	if command -v pyenv >/dev/null; then
# 		export PYENV_ROOT="$HOME/.pyenv"
# 		command -v pyenv >/dev/null || export PATH="$PYENV_ROOT/bin:$PATH"
# 		# eval "$(pyenv init -)"
# 		#
# 		PATH="$(bash --norc -ec 'IFS=:; paths=($PATH); for i in ${!paths[@]}; do if [[ ${paths[i]} == "'/Users/yasser/.pyenv/shims'" ]]; then unset '\''paths[i]'\''; fi; done; echo "${paths[*]}"')"
# 		export PATH="/Users/yasser/.pyenv/shims:${PATH}"
# 		export PYENV_SHELL=zsh
# 		source '/opt/homebrew/Cellar/pyenv/2.3.3/libexec/../completions/pyenv.zsh'
# 		pyenv() {
# 		  local command
# 		  command="${1:-}"
# 		  if [ "$#" -gt 0 ]; then
# 			shift
# 		  fi
#
# 		  case "$command" in
# 		  activate|deactivate|rehash|shell)
# 			eval "$(pyenv "sh-$command" "$@")"
# 			;;
# 		  *)
# 			command pyenv "$command" "$@"
# 			;;
# 		  esac
# 		}
# 		# eval "$(pyenv init --path)"
# 		eval "$(pyenv virtualenv-init -)"
# 		# # make py-launcher use pyenv global version
# 		export PY_PYTHON=$(pyenv exec python -c "import sys; print('.'.join(map(str, sys.version_info[:2])))")
# 		ANACONDAPATH=`pyenv virtualenv-prefix miniforge3`
# 	else
# 		if [ $ENABLE_CONDA=true ]; then
# 			if [ -d "$HOME/anaconda3" ]; then
# 				ANACONDAPATH="$HOME/anaconda3"
# 			else
# 				ANACONDAPATH="$HOME/miniforge3"
# 			fi
# 			eval "$(conda init -)"
# 		fi
#
# 	fi
# fi
[ -f ~/.postzsh ] && source ~/.postzsh

# Tmux floating terminal popup function
if command -v tmux >/dev/null && [ -n "$TMUX" ]; then
	# Float a terminal popup in tmux
	float() {
		tmux display-popup -E -w 80% -h 80% "$@"
	}
	
	# Quick floating terminal (just opens shell)
	alias ft='tmux display-popup -E -w 80% -h 80%'
	
	# Floating file manager (if you have one installed)
	if command -v yazi >/dev/null; then
		alias fy='tmux display-popup -E -w 90% -h 90% yazi'
	elif command -v ranger >/dev/null; then
		alias fr='tmux display-popup -E -w 90% -h 90% ranger'
	elif command -v lf >/dev/null; then
		alias fl='tmux display-popup -E -w 90% -h 90% lf'
	fi
	
	# Floating git status
	alias fg='tmux display-popup -E -w 90% -h 90% "git status && echo && git diff --stat && zsh"'
fi

export PATH="/opt/homebrew/opt/ruby@2.7/bin:$PATH"

source /Users/yasser/.config/broot/launcher/bash/br

[ -f ~/.secrets ] && source ~/.secrets
. "$HOME/.cargo/env"

if command -v starship >/dev/null; then
	eval "$(starship init zsh)"
fi

# Removed duplicate compinit call
export PATH="/Users/yasser/.config/herd-lite/bin:$PATH"
export PHP_INI_SCAN_DIR="/Users/yasser/.config/herd-lite/bin:$PHP_INI_SCAN_DIR"
