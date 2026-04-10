export PATH="$HOME/.cargo/bin:$PATH"
[ -f ~/.postprofile ] && source ~/.postprofile
# uv manages Python - add to PATH
export PATH="$HOME/.local/bin:$PATH"
if [ -n "$PS1" -a -n "$BASH_VERSION" ]; then source ~/.bashrc; fi

export PATH="$HOME/.poetry/bin:$PATH"
. "$HOME/.cargo/env"
eval $(/home/linuxbrew/.linuxbrew/bin/brew shellenv)
