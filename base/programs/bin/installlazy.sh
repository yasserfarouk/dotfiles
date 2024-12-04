#!/bin/sh
base="lazyvim"
# required
mv ~/.config/$base{,.bak}

# optional but recommended
mv ~/.local/share/$base{,.bak}
mv ~/.local/state/$base{,.bak}
mv ~/.cache/$base{,.bak}
git clone https://github.com/LazyVim/starter ~/.config/$base
rm -rf ~/.config/$base/.git
NVIM_APPNAME=$base nvim
