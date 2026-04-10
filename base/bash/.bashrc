#!/usr/bin/env bash

# load the correct .inputrc file
# source  ~/.inputrc
[ -f ~/.prebashrc ] && source ~/.prebashrc
[ -f ~/.exports ] && source ~/.exports
[ -f ~/.aliases ] && source ~/.aliases
[ -f ~/.zfolder/z.sh ] && source ~/.zfolder/z.sh
[ -f $HOME/fzf.bash ] && source $HOME/.fzf.bash
[ -f ~/.postbashrc ] && source ~/.postbashrc

# Starship prompt
if command -v starship >/dev/null; then
	eval "$(starship init bash)"
fi

# broot launcher (if it exists)
[ -f ~/.config/broot/launcher/bash/br ] && source ~/.config/broot/launcher/bash/br
