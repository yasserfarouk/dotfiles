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
	# PRIORITY: Install these first
	"uv"
	"neovim"
	"tmux"
	# Core tools
	"stow"
	"ccls"
	"gdb"
	"git"
	"node"
	"zsh"
	"fzf"
	"fd"
	"vifm"
	"tree"
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
	"javac"
	"starship"
	"glances"
)
# Tools to install via uv tool (replaces pipx)
uv_tool_packages=(
	"asciinema"
	"autoflake"
	"black"
	"cookiecutter"
	"copier"
	"doq"
	"isort"
	"pip-tools"
	"pre-commit"
	"proselint"
	"tiptop"
	"typer"
	"tox"
	"removestar"
	"pygments"
	"typer-cli"
	"ruff"
	"neovim-remote"
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

		# installing nvim nightly correctly with lua support
		brew tap jason0x43/homebrew-neovim-nightly
		brew install neovim-nightly
		;;

	Linux)
		[[ -e "$HOME/bin" ]] || mkdir "$HOME/bin"
        test -d ~/.linuxbrew && eval "$(~/.linuxbrew/bin/brew shellenv)"
        test -d /home/linuxbrew/.linuxbrew && eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"
        test -r ~/.bash_profile && echo "eval \"\$($(brew --prefix)/bin/brew shellenv)\"" >>~/.bash_profile
        echo "eval \"\$($(brew --prefix)/bin/brew shellenv)\"" >>~/.profile
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
            test -d ~/.linuxbrew && eval $(~/.linuxbrew/bin/brew shellenv)
            test -d /home/linuxbrew/.linuxbrew && eval $(/home/linuxbrew/.linuxbrew/bin/brew shellenv)
            test -r ~/.bash_profile && echo "eval \$($(brew --prefix)/bin/brew shellenv)" >>~/.bash_profile
            echo "eval \$($(brew --prefix)/bin/brew shellenv)" >>~/.profile
			echo "export PATH='$(brew --prefix)/bin:$(brew --prefix)/sbin'":'"$PATH"' >>~/.bashrc
		fi
		install_or_upgrade gcc
		# brew install gcc
		# brew upgrade gcc
		# brew unlink gcc && brew link gcc

		# installing nvim nightly correctly with lua support
		brew install --HEAD luajit
		brew install --fetch-HEAD --HREAD neovim
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

echo "Installing uv tool packages (replaces pipx)"
echo "--------------------------------------------"
for i in "${uv_tool_packages[@]}"
do
	uv tool install $i || echo "Warning: Failed to install $i"
done
echo "Installing neovim2/3 python envs using uv"
echo "-----------------------------------------"
# Install Python using uv
uv python install 3.12

# remove existing neovim envs
rm -rf ~/.local/share/uv/venvs/neovim2 2>&1 >/dev/null
rm -rf ~/.local/share/uv/venvs/neovim3 2>&1 >/dev/null

# Create virtual environments for neovim
uv venv ~/.local/share/uv/venvs/neovim2 --python 3.12
uv venv ~/.local/share/uv/venvs/neovim3 --python 3.12

# Install packages in neovim2 venv
source ~/.local/share/uv/venvs/neovim2/bin/activate
uv pip install --upgrade pip
for i in "${neovim_python_packages[@]}"
do
	uv pip install $i
done
neovim2_py="$HOME/.local/share/uv/venvs/neovim2/bin/python"
deactivate

# Install packages in neovim3 venv
source ~/.local/share/uv/venvs/neovim3/bin/activate
uv pip install --upgrade pip
uv pip install neovim-remote

for i in "${neovim_python_packages[@]}"
do
	uv pip install -U $i
done
neovim3_py="$HOME/.local/share/uv/venvs/neovim3/bin/python"
deactivate

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

echo "Installing starship theme"
echo "--------------------------"
# npm install --global pure-prompt
sh -c "$(curl -fsSL https://starship.rs/install.sh)"

echo "Installing AI Coding Assistants"
echo "--------------------------------"
# Install OpenCode CLI
npm install -g @anthropic/opencode || echo "Warning: Failed to install OpenCode"
# Install Claude Code CLI
npm install -g @anthropic/claude-code || echo "Warning: Failed to install Claude Code"

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
