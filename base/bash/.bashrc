#!/usr/bin/env bash

# load the correct .inputrc file
# source  ~/.inputrc
[ -f ~/.prebashrc ] && source ~/.prebashrc
[ -f ~/.exports ] && source ~/.exports
[ -f ~/.aliases ] && source ~/.aliases
[ -f ~/.zfolder/z.sh ] && source ~/.zfolder/z.sh
[ -f $HOME/fzf.bash ] && source $HOME/.fzf.bash
[ -f ~/.postbashrc ] && source ~/.postbashrc


