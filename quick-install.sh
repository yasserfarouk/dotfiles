#!/usr/bin/env zsh
echo "Cloning my dotfiles into .dotfiles and others to .ysupport"
echo "----------------------------------------------------------"
git submodule init
git submodule update --recursive
rm -rf ~/.dotfiles
mkdir ~/.dotfiles 2>&1 >/dev/null
cp -r ./dot/* ~/.dotfiles
touch ~/.z-data
touch ~/.z_history
rm -rf ~/.ysupport
mkdir ~/.ysupport 2>&1 >/dev/null
cp -r ./nondot/* ~/.ysupport

echo "Updating init files with replacements"
echo "-------------------------------------"
export PATH="~/.pyenv/bin:$PATH"
eval "$(pyenv init -)"
eval "$(pyenv virtualenv-init -)"
pyenv activate neovim2
neovim2_py=`pyenv which python`  # Note the path
echo "neovim2 in $neovim2_py"
pyenv activate neovim3
neovim3_py=`pyenv which python`  # Note the path
echo "neovim3 in $neovim3_py"

function replace_tag_in_file(){
  python -c "s=open('$3', 'r').read().replace('$1','$2'); open('$3', 'w').write(s)" 2>&1 >/dev/null
}

function replace_tag_in_all(){
  for file_name in $(find ~/.dotfiles -type f -and ! -name '*.otf' -and ! -name '.*' -and ! -path '*tmux/plugins*' -and ! -name '*.png' -and ! -name 'Makefile' -and ! -path '*z*' );
  do
    python -c "s=open('$file_name', 'r').read().replace('$1','$2'); open('$file_name', 'w').write(s)" 2>&1 >/dev/null
  done
  for file_name in $(find ~/.ysupport -type f -and ! -name '*.otf' -and ! -name '.*' -and ! -path '*tmux/plugins*' -and ! -name 'Makefile' -and ! -name '*.png' -and ! -path '*z*');
  do
    python -c "s=open('$file_name', 'r').read().replace('$1','$2'); open('$file_name', 'w').write(s)"  2>&1 >/dev/null
  done
}

replace_tag_in_file '<<nvimpy2>>' $neovim2_py "$HOME/.vimrc"
replace_tag_in_file '<<nvimpy3>>' $neovim3_py "$HOME/.vimrc"


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

echo "Sourcing all files"
echo "------------------"
mkdir $HOME/.vim/doc 2>&1 >/dev/null
#vim --cmd "helptags $HOME/.vim/doc" --cmd "q"
source ~/.bash_profile
source ~/.zshrc
echo "Installing Plug"
curl -fLo ~/.vim/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim

echo "Installing vim plugins"
echo "----------------------"
vim +PlugInstall +UpdateRemotePlugins +qa
nvim +PlugInstall +UpdateRemotePlugins +CheckHealth +qa

echo "Changing to zsh"
chsh -s $(which zsh)


echo "You'll need to log out for this to take effect"
echo "----------------------------------------------"


case "$(uname -s)" in
   Darwin)
     echo "running oxs defaults"
     ~/.dotfiles/osx.sh

     ;;

   Linux)
     echo 'Linux ... no osx defaults'

     ;;
esac

echo "Correcting group permissions"
echo "----------------------------"
compaudit | xargs chmod g-w

# echo "Installing vimemacs"
# echo "-------------------"

# mkdir -p $HOME/.vim/doc 2>&1 >/dev/null
# mkdir -p $HOME/.vim/plugin 2>&1 >/dev/null
# cp -R ~/nondot/vimacs-0.93/doc $HOME/.vim/doc/
# cp -R ~/nondot/vimacs-0.93/plugin $HOME/.vim/plugin/


echo "------------------------------------------------------------"
echo "                             All done!                      "
echo "Change your terminal font to <Source Code Pro for Powerline>"
echo "------------------------------------------------------------"

exit 0
