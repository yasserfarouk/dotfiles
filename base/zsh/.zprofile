export ZPROFILE_EXPORTED=1
export PYENV_ROOT=$HOME/.pyenv

# case `uname` in
#   Darwin)
# 	PATH="/Library/Frameworks/Python.framework/Versions/3.7/bin:${PATH}"
# 	PATH="/Library/Frameworks/Python.framework/Versions/3.8/bin:${PATH}"
#   ;;
#   Linux)
#     # commands for Linux go here
#   ;;
#   FreeBSD)
#     # commands for FreeBSD go here
#   ;;
# esac
export PATH="$PATH:$HOME/.local/bin"
export PATH="$HOME/.poetry/bin:$PATH"
# export PATH="$HOME/.pyenv/bin:$PATH"
# export PATH="$PYENV_ROOT/bin:$PATH"
export PATH="/usr/local/sbin:$PATH"
export PATH="$PATH:/usr/local/mysql/bin"
export PATH="$PATH:$HOME/.composer/bin"
export PATH=$HOME/bin:$HOME/sbin:$HOME/bin-this:$PATH
export PATH="$PATH:."
export PATH="$HOME/.cargo/bin:$PATH"

export _Z_DATA="$HOME/.z-data"
export LANGUAGE="en_US.UTF-8"
export LANG="en_US.UTF-8"
export LC_CTYPE="en_US.UTF-8"
export LC_NUMERIC="en_US.UTF-8"
export LC_TIME="en_US.UTF-8"
export LC_COLLATE="en_US.UTF-8"
export LC_MONETARY="en_US.UTF-8"
export LC_MESSAGES="en_US.UTF-8"
export LC_PAPER="en_US.UTF-8"
export LC_NAME="en_US.UTF-8"
export LC_ADDRESS="en_US.UTF-8"
export LC_TELEPHONE="en_US.UTF-8"
export LC_MEASUREMENT="en_US.UTF-8"
export LC_IDENTIFICATIO="en_US.UTFUTF"
export LC_ALL="en_US.UTF-8"
export EDITOR="nvim"
export VISUA="nvim"
export VISUAL="nvim"
export HISTSIZE=1000000
export HISTFILESIZE=1000000000
export SAVEHIST=10000


# for lldb which should be installed using brew
#  export LDFLAGS="-L/usr/local/opt/llvm/lib"
# export CPPFLAGS="-I/usr/local/opt/llvm/include"
export LDFLAGS="-L/usr/local/opt/libffi/lib"
export CPPFLAGS="-I/usr/local/opt/libffi/include"

export FZF_DEFAULT_OPTS='--height 40% --reverse --border --ansi'
export FZF_DEFAULT_COMMAND='fd --type file --follow  --color=always --exclude .git'
export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"

export KEYTIMEOUT=1
export TERMINAL_DARK=1
# [[ $TMUX = "" ]] && export TERM="xterm-kitty"
[[ $TMUX != "" ]] && export TERM="screen-256color"
[[ $TMUX != "" ]] && export TERM="screen-256color"
export CLICOLOR=1
export EDITOR=nvim
export _Z_DATA="$HOME/.z-data"
export NVIM_PYTHON_LOG_FILE=/tmp/log
export NVIM_PYTHON_LOG_LEVEL=ERROR
export ZLE_RPROMPT_INDENT=0
export BULLETTRAIN_TIME_SHOW=false
export BULLETTRAIN_STATUS_SHOW=false
export BULLETTRAIN_PROMPT_ADD_NEWLINE=false
export DISABLE_AUTO_TITLE=true
export EVENT_NOKQUEUE=1
export VSCODE_TSJS=1

# Tell zsh where it can find the history file.
# This is the default as suggested by the zsh wizard.
export HISTFILE=~/.z_history
# The maximum number of history entries to keep.
export SAVEHIST=100000
# The maximum number of history entries to keep alive in one session,
# typically the same as SAVEHIST.
export HISTSIZE=100000

