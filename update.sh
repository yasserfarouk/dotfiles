#!/usr/bin/env bash
rm -rf $HOME/.dotfiles
rm -rf $HOME/.vim
rm -rf $HOME/.tmux
rm -rf $HOME/antigen
rm -rf $HOME/.z
rm $HOME/.vimrc
rm $HOME/.bashrc
rm $HOME/.zshrc
rm $HOME/.tmux.conf
rm $HOME/.z-data

./install.sh