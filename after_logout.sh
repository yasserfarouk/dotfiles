#!/usr/bin/env bash
echo "Installing Plug"
curl -fLo ~/.vim/autoload/plug.vim --create-dirs \
    https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim

echo "Sourcing all files"
echo "------------------"
vim --cmd "helptags $HOME/.vim/doc" --cmd "q"
source ~/.bashrc
source ~/.zshrc
vim +PlugInstall +qa

echo "Installing Neobundle"
echo "--------------------"
mkdir ~/tmp 2>&1 >/dev/null
curl https://raw.githubusercontent.com/Shougo/neobundle.vim/master/bin/install.sh > ~/tmp/install.sh
sh ~/tmp/install.sh
rm ~/tmp/install.sh
rmdir ~/tmp 2>&1 >/dev/null

echo "Editing neovim"
echo "--------------"
mkdir ~/bin 2>&1 >/dev/null
rm ~/bin/python2 2>&1 >/dev/null
rm ~/bin/python3 2>&1 >/dev/null
ln -s `which python2` ~/bin/python2
ln -s `which python3` ~/bin/python3
touch ~/.local.vim
brew edit neovim

echo "----------------------------"
echo "         ALL DONE           "
echo "----------------------------"
