#!/usr/bin/env bash
packages=(
"git"
"node"
"tmux"
"vim"
"neovim"
"zsh"
)

linux_packages=(
"vim"
)

mac_packages=(
"vim"
)

case "$(uname -s)" in
   Darwin)
    brew="/usr/local/bin/brew"
    if [ -f "$brew" ]
    then
      echo "Homebrew is installed, nothing to do here"
    else
      echo "Homebrew is not installed, installing now"
      echo "This may take a while"
      echo "Homebrew requires osx command lines tools, please download xcode first"
      ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"

    fi    

    ;;

   Linux)
    [[ -e "$HOME/bin" ]] || mkdir "$HOME/bin"

    curl -LO https://github.com/neovim/neovim/releases/download/nightly/nvim.appimage ~/bin
    chmod u+x ~/bin/nvim.appimage
    echo "+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++"
    echo "neovim is installed in ~/bin/nvim.appimage. alias it to vim after installation" 
    echo "+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++" 

    echo "Installing Linuxbrew"
    echo "---------------------"
    sh -c "$(curl -fsSL https://raw.githubusercontent.com/Linuxbrew/install/master/install.sh)"
    test -d ~/.linuxbrew && PATH="$HOME/.linuxbrew/bin:$HOME/.linuxbrew/sbin:$PATH"
    test -d /home/linuxbrew/.linuxbrew && PATH="/home/linuxbrew/.linuxbrew/bin:/home/linuxbrew/.linuxbrew/sbin:$PATH"
    export PATH="$(brew --prefix)/bin:$(brew --prefix)/sbin:$PATH"
    echo "export PATH='$(brew --prefix)/bin:$(brew --prefix)/sbin'":'"$PATH"' >>~/.bashrc
    brew install gcc
    brew upgrade gcc
    # echo "installing RCM"
    # echo "--------------"
    # curl -LO https://thoughtbot.github.io/rcm/dist/rcm-1.3.1.tar.gz && \
    # tar -xvf rcm-1.3.1.tar.gz && \
    # cd rcm-1.3.1 && \

    # ./configure --prefix=$HOME/bin/rcm && \
    # make && \
    # make install
    ;;
esac

for i in "${packages[@]}"
    do
      brew install $i
      brew upgrade $i
      brew link $i
      echo "---------------------------------------------------------"
    done

case "$(uname -s)" in
   Darwin)
    for i in "${mac_packages[@]}"
      do
        brew install $i
        brew upgrade $i
        brew link $i
        echo "---------------------------------------------------------"
      done
    ;;

   Linux)
    for i in "${linux_packages[@]}"
      do
        brew install $i
        brew upgrade $i
        brew link $i
        echo "---------------------------------------------------------"
      done
    ;;
esac


echo "installing RCM, for dotfiles management and terminal-notifier"
brew tap thoughtbot/formulae
brew install rcm
brew upgrade rcm
brew install terminal-notifier
brew upgrade terminal-notifier
echo "---------------------------------------------------------"

command -v git 2>&1 >/dev/null # improvement by tripleee
GIT_IS_AVAILABLE=$?

if [ GIT_IS_AVAILABLE ]
then
  echo "git is all good"
else  
  brew install git
  brew upgrad git
fi
# Okay so everything should be good
# Fingers cross at least
# Now lets clone my dotfiles repo into .dotfiles/
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
cp -r ./dot/* ~/.ysupport

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


echo "Installing vimemacs"
echo "-------------------"

mkdir -p $HOME/.vim/doc 2>&1 >/dev/null
mkdir -p $HOME/.vim/plugin 2>&1 >/dev/null
cp -R ~/.dotfiles/misc/vimacs-0.93/doc $HOME/.vim
cp -R ~/.dotfiles/misc/vimacs-0.93/plugin $HOME/.vim

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
