export PATH="$HOME/.cargo/bin:$PATH"
export TERMINAL_DARK=1
[ -f ~/.postbash_profile ] && source ~/.postbash_profile

# >>> conda initialize >>>
# !! Contents within this block are managed by 'conda init' !!
__conda_setup="$('/Users/yasser/miniforge3/bin/conda' 'shell.bash' 'hook' 2> /dev/null)"
if [ $? -eq 0 ]; then
    eval "$__conda_setup"
else
    if [ -f "/Users/yasser/miniforge3/etc/profile.d/conda.sh" ]; then
        . "/Users/yasser/miniforge3/etc/profile.d/conda.sh"
    else
        export PATH="/Users/yasser/miniforge3/bin:$PATH"
    fi
fi
unset __conda_setup
# <<< conda initialize <<<


export PATH="$HOME/.poetry/bin:$PATH"
