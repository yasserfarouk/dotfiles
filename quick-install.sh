echo "---------------------------------------------------------"

echo "Cloning my dotfiles into .dotfiles"
git submodule init
git submodule update --recursive
rm -rf ~/.dotfiles
mkdir ~/.dotfiles 2>&1 >/dev/null
cp -r ./dot/* ~/.dotfiles
mkdir ~/z-data  2>&1 >/dev/null
rm -rf ~/.ysupport
mkdir ~/.ysupport 2>&1 >/dev/null
cp -r ./nondot/* ~/.ysupport

cd $HOME
echo "running RCM's rcup command"
echo "This is symlink the rc files in .dofiles"
echo "with the rc files in $HOME"
echo "---------------------------------------------------------"

case "$(uname -s)" in
   Darwin)
    rcup

    ;;
   Linux)
    rcup    
    export PATH="$(brew --prefix)/bin:$(brew --prefix)/sbin:$PATH"
    echo "export PATH='$(brew --prefix)/bin:$(brew --prefix)/sbin'":'"$PATH"' >>~/.bashrc
    ;;
esac
echo "---------------------------------------------------------"

echo "Changing to zsh"
chsh -s $(which zsh)

echo "Installing antigen for zsh"
echo "--------------------------"
mkdir ~/antigen
curl -L git.io/antigen > ~/antigen/antigen.zsh

echo "You'll need to log out for this to take effect"
echo "----------------------------------------------"


case "$(uname -s)" in
   Darwin)
     echo "running oxs defaults"
     ~/.dotfiles/osx.sh
     echo "Correcting group permissions"
     echo "----------------------------"
     compaudit | xargs chmod g-w
     ;;

   Linux)
     echo 'Linux ... no osx defaults'
     ;;
esac




#!/usr/bin/env bash
echo "Installing Plug"
curl -fLo ~/.vim/autoload/plug.vim --create-dirs \
    https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim

echo "Sourcing all files"
echo "------------------"
mkdir $HOME/.vim/doc 2>&1 >/dev/null
vim --cmd "helptags $HOME/.vim/doc" --cmd "q"
source ~/.bashrc
source ~/.zshrc
vim +PlugInstall +qa

echo "Installing vimemacs"
echo "-------------------"

mkdir -p $HOME/.vim/doc 2>&1 >/dev/null
mkdir -p $HOME/.vim/plugin 2>&1 >/dev/null
cp -R ~/nondot/vimacs-0.93/doc $HOME/.vim/doc/
cp -R ~/nondot/vimacs-0.93/plugin $HOME/.vim/plugin/

echo "Installing Neobundle"
echo "--------------------"
mkdir ~/.tmp 2>&1 >/dev/null
curl -fLo > ~/.tmp/install_neobundle.sh --create-dirs \
    https://raw.githubusercontent.com/Shougo/neobundle.vim/master/bin/install.sh 
sh ~/.tmp/install_neobundle.sh
rm ~/.tmp/install_neobundle.sh
rmdir ~/.tmp 2>&1 >/dev/null

echo "Editing neovim"
echo "--------------"
mkdir ~/bin 2>&1 >/dev/null

#rm ~/bin/python2 2>&1 >/dev/null
#rm ~/bin/python3 2>&1 >/dev/null
#ln -s `which python2` ~/bin/python2
#ln -s `which python3` ~/bin/python3
touch ~/.local.vim
brew edit neovim

echo "------------------------------------------------------------"
echo "                             All done!                      "
echo "Change your terminal font to <Source Code Pro for Powerline>"
echo "------------------------------------------------------------"

exit 0
