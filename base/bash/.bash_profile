# bash login shells. Bash skips ~/.profile when this file exists, so read it here (it also sources ~/.bashrc
# for interactive shells).

# zsh was chosen (~/.config/dotfiles-shell, written by quick-install.sh) but the login shell couldn't be changed
# (no chsh/root): hand the top-level interactive login over to zsh. DOTFILES_NO_ZSH=1 bash -l stays in bash.
if [ -z "${DOTFILES_NO_ZSH:-}" ] && [ -z "${ZSH_VERSION:-}" ] && [[ $- == *i* ]] && [ "${SHLVL:-1}" -le 1 ] \
	&& [ "$(cat ~/.config/dotfiles-shell 2>/dev/null)" = zsh ] && command -v zsh >/dev/null; then
	exec zsh -l
fi

export TERMINAL_DARK=1
[ -f ~/.profile ] && . ~/.profile
[ -f ~/.postbash_profile ] && . ~/.postbash_profile

# conda (miniforge / anaconda), when installed
for _conda in "$HOME/miniforge3" "$HOME/anaconda3"; do
	if [ -x "$_conda/bin/conda" ]; then
		__conda_setup="$("$_conda/bin/conda" 'shell.bash' 'hook' 2>/dev/null)" && eval "$__conda_setup" \
			|| { [ -f "$_conda/etc/profile.d/conda.sh" ] && . "$_conda/etc/profile.d/conda.sh"; }
		unset __conda_setup
		break
	fi
done
unset _conda

#THIS MUST BE AT THE END OF THE FILE FOR SDKMAN TO WORK!!!
export SDKMAN_DIR="$HOME/.sdkman"
[[ -s "$HOME/.sdkman/bin/sdkman-init.sh" ]] && source "$HOME/.sdkman/bin/sdkman-init.sh"
