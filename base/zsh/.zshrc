#!/usr/bin/env zsh

# [[ $ZSHENVCALLED = "" ]] && source ~/.zshenv
source ~/.zshenv
source ~/.z/z.sh

autoload -U promptinit; promptinit
unset file
# zstyle ':completion:*:*:git:*' script $HOME/.ysupport/git-completion.bash

zle -N edit-command-line

source ~/antigen/antigen.zsh
antigen bundle git
antigen bundle pip
antigen bundle zsh-users/zsh-syntax-highlighting
antigen bundle zsh-users/zsh-autosuggestions
# case `uname` in
#   Darwin)
# 	antigen bundle marzocchi/zsh-notify
# 	zstyle ':notify:*' command-complete-timeout 5
# 	zstyle ':notify:*' error-icon "https://media3.giphy.com/media/10ECejNtM1GyRy/200_s.gif"
# 	zstyle ':notify:*' error-title "Fail"
# 	zstyle ':notify:*' success-icon "https://s-media-cache-ak0.pinimg.com/564x/b5/5a/18/b55a1805f5650495a74202279036ecd2.jpg"
# 	zstyle ':notify:*' success-title "Success"
#   ;;
#   Linux)
#     # commands for Linux go here
#   ;;
#   FreeBSD)
#     # commands for FreeBSD go here
#   ;;
# esac
antigen bundle mafredri/zsh-async
antigen bundle sindresorhus/pure
antigen apply


export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion



source ~/.aliases
eval "$(direnv hook zsh)"

# pyenv
if which pyenv > /dev/null; then eval "$(pyenv init -)"; fi
# eval "$(pyenv virtualenv-init -)"
if which pyenv > /dev/null; then eval "$(pyenv virtualenv-init -)"; fi

# added by broot
source /Users/yasser/Library/Preferences/org.dystroy.broot/launcher/bash/br


#===============================================================================
# icl - interactive command library
#===============================================================================

# f_run_icl(){
#     icl_OUTPUT=$(icl)
#     print -z $icl_OUTPUT
#     zle accept-line # no idea if this is the way it's done
# }
#
# zle -N w_run_icl f_run_icl # create a widget
# bindkey ^i w_run_icl
#
#===============================================================================
# END  icl - interactive command library END
#===============================================================================