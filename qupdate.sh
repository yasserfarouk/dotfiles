#!/usr/bin/env bash
cp -r dot/* ~/.dotfiles
source ~/.bashrc
source ~/.zshrc

# "\e[5~": history-search-backward
#"\e[6~": history-search-forward
#"\e[A": history-search-backward
#"\e[B": history-search-forward

