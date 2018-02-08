#!/bin/sh
packages=(
"git"
"node"
"tmux"
"neovim"
"zsh"
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
    if ! [-f $HOME/bin]; then
        mkdir $HOME/bin
    fi

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
    test -r ~/.bash_profile && echo "export PATH='$(brew --prefix)/bin:$(brew --prefix)/sbin'":'"$PATH"' >>~/.bashrc
    echo "export PATH='$(brew --prefix)/bin:$(brew --prefix)/sbin'":'"$PATH"' >>~/.profile

    echo "installing RCM"
    echo "--------------"
    curl -LO https://thoughtbot.github.io/rcm/dist/rcm-1.3.1.tar.gz && \

    sha=$(sha256 rcm-1.3.1.tar.gz | cut -f1 -d' ') && \
    [ "$sha" = "9c8f92dba63ab9cb8a6b3d0ccf7ed8edf3f0fb388b044584d74778145fae7f8f" ] && \

    tar -xvf rcm-1.3.1.tar.gz && \
    cd rcm-1.3.1 && \

    ./configure --prefix=$HOME/bin/rcm && \
    make && \
    make install
    ;;
esac

for i in "${packages[@]}"
    do
      brew install $i
      echo "---------------------------------------------------------"
    done

echo "installing RCM, for dotfiles management"
brew tap thoughtbot/formulae
brew install rcm
echo "---------------------------------------------------------"

command -v git 2>&1 >/dev/null # improvement by tripleee
GIT_IS_AVAILABLE=$?

if [ GIT_IS_AVAILABLE ]
then
  echo "git is all good"
else  
  case "$(uname -s)" in
    Darwin)
        brew install git
        ;;
    Linux)
        echo "git is not installed" 
  esac
fi
# Okay so everything should be good
# Fingers cross at least
# Now lets clone my dotfiles repo into .dotfiles/
echo "---------------------------------------------------------"

echo "Cloning my dotfiles insto .dotfiles"
git clone https://github.com/yasserfarouk/dotfiles.git ~/.dotfiles

cd ~/.dotfiles
git submodule update --init --recursive

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
    test -r ~/.bash_profile && echo "export PATH='$(brew --prefix)/bin:$(brew --prefix)/sbin'":'"$PATH"' >>~/.bashrc
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
echo "---------------------------------------------------------"


case "$(uname -s)" in

   Darwin)
     echo "running oxs defaults"
     ~./osx.sh
     echo "Correcting group permissions"
     echo "----------------------------"
     compaudit | xargs chmod g-w
     ;;

   Linux)
     echo 'Linux ... no osx defaults'
     ;;
esac


echo "Installing Plug"
curl -fLo ~/.vim/autoload/plug.vim --create-dirs \
    https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim

echo "Sourcing all files"
echo "------------------"

source ~/.bashrc
source ~/.zshrc
vim +PlugInstall +qa

echo "---------------------------------------------------------"
echo "All done!"
echo "and change your terminal font to source code pro"
echo "Cheers"
echo "---------------------------------------------------------"

exit 0
