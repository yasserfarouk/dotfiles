#!/bin/zsh
# Write new entries to the history incrementally instead of on
# shell exit.
setopt INC_APPEND_HISTORY
# Let multiple instances of ZSH share the same active history. This doesn't
# include bang expansions (!!, !$, etc...) which will still use the
# local history.
setopt SHARE_HISTORY
# Stores start and elapsed time for each command in the history file.
# Disable this for compatibility with other shells.
setopt EXTENDED_HISTORY
# Don't save duplicate history entries.
setopt HIST_SAVE_NO_DUPS
# Ignore unecessary whitespace (this is handled properly even with
# quoting).
setopt HIST_REDUCE_BLANKS
# Don't save function definitions to the history file.
setopt HIST_NO_FUNCTIONS
# Don't store calls to `history` or `fc`.
setopt HIST_NO_STORE
# Disable that awful, annoying beep when you hit the edges of the history
# file.
setopt NO_HIST_BEEP

fpath=($HOME/.ysupport/zsh-completions $fpath)
# compinit moved to .zshrc to avoid multiple calls
zmodload -i zsh/complist

# Disable zsh autocorrect
zstyle ':completion:*' menu select
zstyle ':completion:*' matcher-list 'm:{a-zA-Z}={A-Za-z}'
setopt completeinword
# Normally the default, but bugs out in some versions of zsh + tmux and
# needs to be set explicitly. Allows you to search your history using
# ctrl-r.
bindkey '^R' history-incremental-search-backward

autoload -U up-line-or-beginning-search
autoload -U down-line-or-beginning-search

zle -N up-line-or-beginning-search
zle -N down-line-or-beginning-search
zle -N zle-keymap-select
bindkey "^[[A" up-line-or-beginning-search # Up
bindkey "^[[B" down-line-or-beginning-search # Down

# Beginning search with arrow keys
bindkey "^[oA" up-line-or-beginning-search
bindkey "^[oB" down-line-or-beginning-search
bindkey "^[0A" up-line-or-beginning-search
bindkey "^[0B" down-line-or-beginning-search

# Better searching in command mode
bindkey -M vicmd '?' history-incremental-search-backward
bindkey -M vicmd '/' history-incremental-search-forward

# Beginning search with arrow keys
bindkey "^[OA" up-line-or-beginning-search
bindkey "^[OB" down-line-or-beginning-search
bindkey -M vicmd "k" up-line-or-beginning-search
bindkey -M vicmd "j" down-line-or-beginning-search
# `v` is already mapped to visual mode, so we need to use a different key to
# open Vim
bindkey -M vicmd "^V" edit-command-line

# Updates editor information when the keymap changes.
function zle-keymap-select() {
  zle reset-prompt
  zle -R
}

function vi_mode_prompt_info() {
  echo "${${KEYMAP/vicmd/[% NORMAL]%}/(main|viins)/[% INSERT]%}"
}

# # define right prompt, regardless of whether the theme defined it
# RPS1='$(vi_mode_prompt_info)'
# RPS2=$RPS1

# Vi mode
bindkey -e

# prevents .zshrc from sourcing this file again
export ZSHENVCALLED=1
