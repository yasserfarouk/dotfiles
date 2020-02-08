# Obligatory Dotfile Repo

This repository contains my dotfiles (mostly vim/tmux) which is adjusted to work for both OSX and linux machines. It is base on [Mark Hartington](https://github.com/mhartington/dotfiles).

The main differences between this fork and the original repository are the following:
- It is optimized for a python developer (mostly a data scientist) instead of for web development
- It works for both MacOSX and Linux
- It installs more of the prerequisits and assumes very little about the machine
- For linux machines, it installes linuxbrew and uses it to make all needed instlalations in the user's home directory without any need for root permissions
- better restructuring of vim/nvim configuration
- I use plug for both vim and nvim
- I add backup and restoration of MacOSX program settings for may programs using (Mackup)[https://github.com/lra/mackup]
- Sublime text settings are also synced in this repository.
- .....


## Note to iterm
I mostly use iterm2. Remember in this case use Source Code Pro for Powerline as the terminal font.

If you are using MacOS's iterm, Iterm nightly is a must.
Or any terminal that supports true colors.

Once installed, click on the iterm color config in `config/colors` to add oceanicNext

## Key VIM plugins
Both .vimrc and .config/nvim/init.vim will be installed with more or less the same options. That allows you to use vim and nvim as needed.


### [ryanoasis/vim-devicons](https://github.com/ryanoasis/vim-devicons)

This is really optional and over the top, but it adds icons to your file tree (if using nerdTree). So over the top....I need it.

I use Source Code Pro for my fonts, maybe you do too. But we're using powerline here folks, so we need some patched fonts.

https://github.com/ryanoasis/nerd-fonts

Install one of these fonts and you should be good to go. Don't forget to set your terminal font to that font as well.

## Tmux

The tmux script is based on [this one](https://github.com/gpakosz/.tmux?files=1)

## Inspiration
- [Mark Hartington](https://github.com/mhartington/dotfiles)
- [Maximum Awesome](https://github.com/square/maximum-awesome)
- [Paul's Dotfiles](https://github.com/paulirish/dotfiles)
- [Andrew's Dotfiles](https://github.com/ajoslin/dot)
