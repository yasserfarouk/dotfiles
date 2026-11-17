#!/usr/bin/env bash
# Interactive bash. Login shells get here through ~/.bash_profile → ~/.profile.
case $- in *i*) ;; *) return ;; esac

[ -f ~/.prebashrc ] && source ~/.prebashrc
[ -f ~/.exports ] && source ~/.exports
[ -f ~/.aliases ] && source ~/.aliases

# history: bash's own file (.exports points HISTFILE at zsh's ~/.z_history, whose format differs)
HISTFILE=~/.bash_history
HISTSIZE=100000
HISTFILESIZE=100000
HISTCONTROL=ignoreboth:erasedups
shopt -s histappend checkwinsize 2>/dev/null
shopt -s globstar autocd 2>/dev/null

# z: zoxide (initialized below after the prompt); fall back to z.sh if zoxide is missing
command -v zoxide >/dev/null || { [ -f ~/.zfolder/z.sh ] && source ~/.zfolder/z.sh; }
[ -f ~/.bashrc.local ] && source ~/.bashrc.local
[ -f ~/.exports.local ] && source ~/.exports.local
[ -f "$HOME/.cargo/env" ] && . "$HOME/.cargo/env"

# NVM (Node Version Manager)
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && {
	# Lazy load nvm - only initialize when called
	nvm() {
		unset -f nvm
		[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"
		[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"
		nvm "$@"
	}
	# Add default node to path without loading full nvm
	if [ -f "$NVM_DIR/alias/default" ]; then
		export PATH="$NVM_DIR/versions/node/$(cat "$NVM_DIR/alias/default")/bin:$PATH"
	fi
}

# git completion (bundled in this package)
[ -f ~/git-completion.bash ] && source ~/git-completion.bash

[ -f ~/.postbashrc ] && source ~/.postbashrc

# Starship prompt
if command -v starship >/dev/null; then
	eval "$(starship init bash)"
fi

# zoxide provides z / zi
if command -v zoxide >/dev/null; then
	eval "$(zoxide init bash)"
fi

# broot launcher (if it exists)
[ -f ~/.config/broot/launcher/bash/br ] && source ~/.config/broot/launcher/bash/br

# fzf key bindings / completion: brew's ~/.fzf.bash, else fzf's built-in script (fzf >= 0.48)
if [ -f ~/.fzf.bash ]; then
	source ~/.fzf.bash
elif command -v fzf >/dev/null; then
	eval "$(fzf --bash 2>/dev/null)"
fi
