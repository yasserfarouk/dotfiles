#!/usr/bin/env bash
packages=(
"git"
"node"
"tmux"
"neovim"
"zsh"
)

linux_packages=(
"vim"
)

mac_packages=(
"macvim"
"terminal-notifier"
)

python_packages = (
"neovim"
"flake8"
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
    brew unlink gcc && brew link gcc    
    ;;
esac

for i in "${packages[@]}"
do
  #brew unlink $i
  #brew uninstall $i
  brew install $i
  brew upgrade $i
  brew unlink $i && brew link $i
  echo "---------------------------------------------------------"
done

case "$(uname -s)" in
   Darwin)
    for i in "${mac_packages[@]}"
    do
      #brew unlink $i
      #brew uninstall $i
      brew install $i
      brew upgrade $i
      brew unlink $i && brew link $i
      echo "---------------------------------------------------------"
    done
    
    ;;

   Linux)
    for i in "${linux_packages[@]}"
    do
      #brew unlink $i
      #brew uninstall $i
      brew install $i
      brew upgrade $i
      brew unlink $i && brew link $i
      echo "---------------------------------------------------------"
    done
    ;;
esac


echo "installing RCM, for dotfiles management and terminal-notifier"
brew tap thoughtbot/formulae
#brew unlink $i
#brew uninstall $i
brew install rcm
brew upgrade rcm
brew unlink $i && brew link $i
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

echo "Installing neovim2/3 python envs"
curl -L https://raw.githubusercontent.com/pyenv/pyenv-installer/master/bin/pyenv-installer | bash

pyenv install 2.7
pyenv install 3.6

pyenv virtualenv 2.7 neovim2
pyenv virtualenv 3.6 neovim3

pyenv activate neovim2
for i in "${python_packages[@]}"
do
  pip install $i
done

neovim2_py=`pyenv which python`  # Note the path

pyenv activate neovim3
for i in "${python_packages[@]}"
do
  pip install $i
done
neovim3_py=`pyenv which python`  # Note the path


echo "Updating init files with replacements"

function replace_tag_in_all(){  
  for f in $(find ./dot -type f -and ! -name '*.otf' -and ! -name '.*' -and ! -path '*tmux/plugins*' -and ! -name 'Makefile' -and ! -path '*z*'); 
  do 
    sed -i 's/$1/$2/g'  
  done  
}
replace_tag_in_all '<<nvimpy2>>' $neovim2_py
replace_tag_in_all '<<nvimpy3>>' $neovim3_py

echo "----------------------"
echo "Installed prerequisits"
echo "----------------------"
./quick-install.sh
