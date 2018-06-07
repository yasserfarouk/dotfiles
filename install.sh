#!/usr/bin/env bash
packages=(
"git"
"node"
"neovim"
"zsh"
"fzf"
"fd"
"ranger"
)
pip_packages=(
)
linux_packages=(
"terminal-notifier"
)

mac_packages=(
"macvim"
"terminal-notifier"
"mackup"
)

python_packages=(
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
    # [[ -e "$HOME/bin" ]] || mkdir "$HOME/bin"

    # curl -LO https://github.com/neovim/neovim/releases/download/nightly/nvim.appimage ~/bin
    # chmod u+x ~/bin/nvim.appimage
    # echo "+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++"
    # echo "neovim is installed in ~/bin/nvim.appimage. alias it to vim after installation"
    # echo "+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++"
    command -v brew 2>&1 >/dev/null # improvement by tripleee
    BREW_IS_AVAILABLE=$?
    if [ $BREW_IS_AVAILABLE ]
    then
      echo "Homebrew is installed, nothing to do here"
    else
      echo "Installing Linuxbrew"
      echo "---------------------"
      sh -c "$(curl -fsSL https://raw.githubusercontent.com/Linuxbrew/install/master/install.sh)"
      test -d ~/.linuxbrew && PATH="$HOME/.linuxbrew/bin:$HOME/.linuxbrew/sbin:$PATH"
      test -d /home/linuxbrew/.linuxbrew && PATH="/home/linuxbrew/.linuxbrew/bin:/home/linuxbrew/.linuxbrew/sbin:$PATH"
      export PATH="$(brew --prefix)/bin:$(brew --prefix)/sbin:$PATH"
      echo "export PATH='$(brew --prefix)/bin:$(brew --prefix)/sbin'":'"$PATH"' >>~/.bashrc
    fi
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
    brew install vim --HEAD --without-python --with-python3
    brew unlink vim
    brew link vim
    ;;
esac


# installing fzf shortcuts
$(brew --prefix)/opt/fzf/install

# installing programs that require special care (e.g. tmux from HEAD and devicons usin npm)
brew install tmux --HEAD
brew link tmux
brew tap caskroom/fonts
brew cask install font-hack-nerd-font
brew cask link font-hack-nerd-font
current_dir=`pwd`
cd $HOME
npm install -g devicons
cd $current_dir

echo "installing RCM, for dotfiles management and terminal-notifier"
brew tap thoughtbot/formulae
brew install rcm
brew upgrade rcm
brew unlink $i && brew link $i
echo "---------------------------------------------------------"

command -v git 2>&1 >/dev/null # improvement by tripleee
GIT_IS_AVAILABLE=$?

if [ $GIT_IS_AVAILABLE ]
then
  echo "git is all good"
else
  brew install git
  brew upgrad git
fi
# Okay so everything should be good
# Fingers cross at least
# Now lets clone my dotfiles repo into .dotfiles/

echo "Installing pip packages assuming that pip is available"
echo "------------------------------------------------------"
for i in "${pip_packages[@]}"
do
    pip install --upgrade $i
  echo "---------------------------------------------------------"
done

echo "Installing neovim2/3 python envs"
echo "--------------------------------"
curl -L https://raw.githubusercontent.com/pyenv/pyenv-installer/master/bin/pyenv-installer | bash
export PATH="~/.pyenv/bin:$PATH"
eval "$(pyenv init -)"
eval "$(pyenv virtualenv-init -)"

pyenv install 2.7
pyenv install 3.6.4

pyenv virtualenv 2.7 neovim2 2>&1 >/dev/null
pyenv virtualenv 3.6.4 neovim3 2>&1 >/dev/null

echo "Installing neovim for python, ruby, and node"
echo "--------------------------------------------"
pyenv activate neovim2
for i in "${python_packages[@]}"
do
  pip install $i
done

neovim2_py=`pyenv which python`  # Note the path

pyenv activate neovim3
for i in "${python_packages[@]}"
do
  pip install $i 2>&1 >/dev/null
done
neovim3_py=`pyenv which python`  # Note the path

gem install neovim
npm install -g neovim

echo "Installing diff-so-fancy"
echo "------------------------"
mkdir ~/bin 2>&1 >/dev/null
curl https://raw.githubusercontent.com/so-fancy/diff-so-fancy/master/third_party/build_fatpack/diff-so-fancy >~/bin/diff-so-fancy
chmod +x ~/bin/diff-so-fancy

echo "Installing source code nerd font"
echo "--------------------------------"
$current_dir=`pwd`
mkdir $HOME/fonts 2>&1 >/dev/null
cd $HOME/fonts
curl -OJL https://github.com/ryanoasis/nerd-fonts/releases/download/v1.2.0/SourceCodePro.zip
unzip SourceCodePro.zip

curl -OJL https://github.com/ryanoasis/nerd-fonts/releases/download/v1.2.0/FiraCode.zip
unzip FiraCode.zip

rm "*windows*" 2>&1 >/dev/null
rm "*Windows*" 2>&1 >/dev/null
case "$(uname -s)" in
   Darwin)
	mkdir $HOME/Library/Fonts 2>&1 >/dev/null
	mv *.ttf $HOME/Library/Fonts
    ;;

   Linux)
	mkdir $HOME/.fonts 2>&1 >/dev/null
	mv *.ttf $HOME/.fonts
    ;;
esac
cd $current_dir

echo "Installing antigen for zsh"
echo "--------------------------"
mkdir ~/antigen 2>&1 >/dev/null
curl -L git.io/antigen > ~/antigen/antigen.zsh

echo "Installing pure theme"
echo "--------------------------"
npm install --global pure-prompt

echo "----------------------"
echo "Installed prerequisits"
echo "----------------------"
./quick-install.sh


echo "-----------------------------"
echo "           Manual Installs   "
echo "-----------------------------"
echo "- Install Hex Fied from https://ridiculousfish.com/hexfiend/"
echo "- Install Skype, Slack"
echo "- Install MacVim latest release from https://github.com/macvim-dev/macvim/releases/tag/snapshot-147"
