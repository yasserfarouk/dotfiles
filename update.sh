#!/usr/bin/env bash
rm -rf $HOME/.dotfiles; 
rm -rf $HOME/.vim; 
git add .; 
git commit -m"corrections"; 
git push; 
./install.sh