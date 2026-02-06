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
fpath+=$HOME/.zfunc

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
export PATH="/opt/homebrew/opt/ruby@2.7/bin:$PATH"

source /Users/yasser/.config/broot/launcher/bash/br

[ -f ~/.secrets ] && source ~/.secrets
. "$HOME/.cargo/env"

if command -v starship >/dev/null; then
	eval "$(starship init zsh)"
fi

fpath+=~/.zfunc; autoload -Uz compinit; compinit
export PATH="/Users/yasser/.config/herd-lite/bin:$PATH"
export PHP_INI_SCAN_DIR="/Users/yasser/.config/herd-lite/bin:$PHP_INI_SCAN_DIR"
