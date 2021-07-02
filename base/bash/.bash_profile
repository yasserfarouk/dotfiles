export _Z_DATA="$HOME/.z-data"
[ -f ~/.bashrc ] && source ~/.bashrc


export PATH="$HOME/.cargo/bin:$PATH"
export PATH="$HOME/.linuxbrew/sbin:$PATH"
export TERMINAL_DARK=1
# [[ $TMUX = "" ]] && export TERM="xterm-kitty"
[[ $TMUX = "" ]] && export TERM="tmux-kitty"
[[ $TMUX != "" ]] && export TERM="screen-256color"
