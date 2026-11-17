# Login environment for sh-compatible shells (bash reads it through ~/.bash_profile).
export PATH="$HOME/.local/bin:$PATH"
[ -d "$HOME/.poetry/bin" ] && export PATH="$HOME/.poetry/bin:$PATH"
[ -f "$HOME/.cargo/env" ] && . "$HOME/.cargo/env"
for _brew in /opt/homebrew/bin/brew "$HOME/.linuxbrew/bin/brew" /home/linuxbrew/.linuxbrew/bin/brew; do
	[ -x "$_brew" ] && { eval "$("$_brew" shellenv)"; break; }
done
unset _brew
[ -f ~/.postprofile ] && . ~/.postprofile
# interactive bash: the rc file (bash itself doesn't read ~/.bashrc in login shells)
if [ -n "$BASH_VERSION" ] && [ -n "$PS1" ] && [ -f ~/.bashrc ]; then . ~/.bashrc; fi
