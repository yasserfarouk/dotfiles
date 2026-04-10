#!/usr/bin/env bash

# load the correct .inputrc file
# source  ~/.inputrc
[ -f ~/.prebashrc ] && source ~/.prebashrc
[ -f ~/.exports ] && source ~/.exports
[ -f ~/.aliases ] && source ~/.aliases
[ -f ~/.zfolder/z.sh ] && source ~/.zfolder/z.sh
[ -f $HOME/fzf.bash ] && source $HOME/.fzf.bash

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
		export PATH="$NVM_DIR/versions/node/$(cat $NVM_DIR/alias/default)/bin:$PATH"
	fi
}

[ -f ~/.postbashrc ] && source ~/.postbashrc

# Starship prompt
if command -v starship >/dev/null; then
	eval "$(starship init bash)"
fi

# broot launcher (if it exists)
[ -f ~/.config/broot/launcher/bash/br ] && source ~/.config/broot/launcher/bash/br
