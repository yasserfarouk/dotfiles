export PATH="$HOME/.cargo/bin:$PATH"
[ -f ~/.postprofile ] && source ~/.postprofile
export PYENV_ROOT="$HOME/.pyenv"
export PATH="$PYENV_ROOT/bin:$PATH"
if command -v pyenv >/dev/null; then
eval "$(pyenv init --path)"
fi
if [ -n "$PS1" -a -n "$BASH_VERSION" ]; then source ~/.bashrc; fi

export PATH="$HOME/.poetry/bin:$PATH"
