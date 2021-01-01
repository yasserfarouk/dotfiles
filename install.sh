#!/usr/bin/env bash
function install_or_upgrade {
    if brew ls --versions "$1" >/dev/null; then
        HOMEBREW_NO_AUTO_UPDATE=1 brew upgrade "$1"
    else
        HOMEBREW_NO_AUTO_UPDATE=1 brew install "$1"
    fi
}
function install_if_not_installed {
    if brew ls --versions "$1" >/dev/null; then
		:
    else
        HOMEBREW_NO_AUTO_UPDATE=1 brew install "$1"
    fi
}

while true; do
	read -p "Do you have root access to this machine? [yn] " has_root
	case $has_root in
		[Yy]* ) echo "May be prompted for your password later"; break;;
		[Nn]* ) echo "Will not be prompted for a sudo password"; break;;
		* ) echo "Please answer yes or no.";;
	esac
done

packages=(
	"stow"
	"ccls"
	"gdb"
	"git"
	"node"
	# "neovim"
	"zsh"
	"fzf"
	"fd"
	"vifm"
	"tree"
	"pyenv"
	"pyenv-virtualenv"
	"ag"
	"ripgrep"
	"rg"
	"languagetool"
	"antiword"
	"docx2txt"
	"poppler"
	"mutt"
	"yarn"
	"ack"
	"bat"
	"cloc"
	"diff-so-fancy"
	"entr"
	"exa"
	"gh"
	"gnupg"
	"grep"
	"highlight"
	"htop"
	"hub"
	"jq"
	"lazydocker"
	"lazygit"
	"markdown"
	"mas"
	# "neofetch"
	"nmap"
	"noti"
	"reattach-to-user-namespace"
	"schniz/tap/fnm"
	"shellcheck"
	"tig"
	"tldr"
	"tmux"
	"trash"
	"tree"
	"vim"
	"wdiff"
	"wget"
	"youtube-dl"
	"z"
	"zsh"
	"neofetch"
	"zathura"
	"zathura-pdf-poppler"
	"transmission"
)
pip_packages=(
	"msgpack"
)
linux_packages=(
	"terminal-notifier"
)

mac_packages=(
	"alacritty"
	"macvim"
	"terminal-notifier"
	"mackup"
)

neovim_python_packages=(
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

	# curl -LO https://github.com/neovim/neovim/releases/download/nightly/nvim.appimage ~/bin
	# chmod u+x ~/bin/nvim.appimage
	# echo "+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++"
	# echo "neovim is installed in ~/bin/nvim.appimage. alias it to vim after installation"
	# echo "+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++"
	case $has_root in
		[Yy]* ) sudo apt install make lib64readline7 lib64readline7-dev sqlite sqlite3 zlib1g-dev zlibig bzip2;;
		[Nn]* ) echo "You should have make lib64readline7 lib64readline7-dev sqlite sqlite3 zlib1g-dev zlibig bzip2 installed. Proceeding assuming you do";;
		* ) echo "Should not be here";;
	esac
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
	install_or_upgrade gcc
	# brew install gcc
	# brew upgrade gcc
	# brew unlink gcc && brew link gcc

	# installing nvim nightly correctly with lua support
	brew tap jason0x43/homebrew-neovim-nightly
	brew cask install neovim-nightly
	;;

esac


brew tap "homebrew/bundle"
brew tap "homebrew/cask"
brew tap "homebrew/core"
brew tap "homebrew/cask-fonts"
brew tap "schniz/tap"

for i in "${packages[@]}"
do
	#brew unlink $i
	#brew uninstall $i
	install_if_not_installed $i
	# brew install $i
	# brew upgrade $i
	# brew unlink $i && brew link $i
	echo "---------------------------------------------------------"
done

case "$(uname -s)" in
	Darwin)
		for i in "${mac_packages[@]}"
		do
			#brew unlink $i
			#brew uninstall $i
			install_if_not_installed $i
			# brew install $i
			# brew upgrade $i
			# brew unlink $i && brew link $i
			echo "---------------------------------------------------------"
		done

		;;

	Linux)
		for i in "${linux_packages[@]}"
		do
			#brew unlink $i
			#brew uninstall $i
			install_if_not_installed $i
			# brew install $i
			# brew upgrade $i
			# brew unlink $i && brew link $i
			echo "---------------------------------------------------------"
		done
		brew install vim --HEAD --without-python --with-python3
		brew unlink vim
		brew link vim
		;;
esac


# installing fzf shortcuts
yes | $(brew --prefix)/opt/fzf/install --all

# installing programs that require special care (e.g. tmux from HEAD and devicons usin npm)
brew install tmux --HEAD
brew link tmux
brew tap homebrew/cask-fonts
brew cask install font-hack-nerd-font
brew cask link font-hack-nerd-font
current_dir=`pwd`
cd $HOME
npm install -g devicons
npm install -g write-good
cd $current_dir

command -v git 2>&1 >/dev/null # improvement by tripleee
GIT_IS_AVAILABLE=$?

if [ $GIT_IS_AVAILABLE ]
then
	echo "git is all good"
else
	install_or_upgrade git
fi
# Okay so everything should be good
# Now lets clone my dotfiles repo into .dotfiles/

echo "Installing pip packages assuming that pip is available"
echo "------------------------------------------------------"
for i in "${pip_packages[@]}"
do
	pip3 install --upgrade $i
done

echo "Installing neovim2/3 python envs"
echo "--------------------------------"
# curl -L https://raw.githubusercontent.com/pyenv/pyenv-installer/master/bin/pyenv-installer | bash
export PATH="~/.pyenv/bin:$PATH"
eval "$(pyenv init -)"
eval "$(pyenv virtualenv-init -)"

# I am using python3 for both py and p3 in vim
# pyenv install 2.7.17
# pyenv install 3.7.6
# pyenv install 3.8.6
pyenv install 3.9.0

# remove existing neovim envs
unlink ~/.pyenv/versions/neovim2 2>&1 >/dev/null
unlink ~/.pyenv/versions/neovim3 2>&1 >/dev/null

# pyenv virtualenv 2.7.17 neovim2 2>&1 >/dev/null
pyenv virtualenv 3.9.0 neovim3 2>&1 >/dev/null
pyenv virtualenv 3.9.0 neovim2 2>&1 >/dev/null

# echo "Installing neovim for python, and node"
# echo "--------------------------------------------"
# pyenv activate neovim2
# pip install --upgrade pip
# for i in "${neovim_python_packages[@]}"
# do
# 	pip install $i
# done

neovim2_py=`pyenv which python`  # Note the path

pyenv activate neovim3
pip install --upgrade pip
pip install neovim-remote

for i in "${neovim_python_packages[@]}"
do
	pip install -U $i
done
neovim3_py=`pyenv which python`  # Note the path

gem install neovim
npm install -g neovim

echo "Installing CTAGS"
echo "----------------"
brew install --HEAD universal-ctags/universal-ctags/universal-ctags

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

echo "Linking Zathura PDF"
mkdir -p $(brew --prefix zathura)/lib/zathura
ln -s $(brew --prefix zathura-pdf-poppler)/libpdf-poppler.dylib $(brew --prefix zathura)/lib/zathura/libpdf-poppler.dylib

echo "Installing Plug for NVIM"
echo "-------------------------"
curl -fLo ~/.vim/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim

echo "Installing antigen for zsh"
echo "--------------------------"
mkdir ~/antigen 2>&1 >/dev/null
curl -L git.io/antigen > ~/antigen/antigen.zsh

echo "Installing pure theme"
echo "--------------------------"
npm install --global pure-prompt

echo "Updating npm"
echo "------------"
npm install -g npm

echo "----------------------"
echo "Installed prerequisits"
echo "----------------------"
./quick-install.sh


case "$(uname -s)" in
	Darwin)
		echo "-----------------------------"
		echo "           Manual Installs   "
		echo "-----------------------------"
		echo "- Install MacVim latest release"
		;;

	Linux)
		echo "=============="
		echo "   ALL DONE   "
		echo "=============="
		;;
esac
