#
# Executes commands at the start of an interactive session.
#
# Authors:
#   Sorin Ionescu <sorin.ionescu@gmail.com>
#

# set $MAC to 1 if on my mac
if [ `uname -s` = 'Darwin' ]; then
    export MAC=1
fi

# set PATH
if ! [ -z "$MAC" ]; then
    # PATH="$PATH:/Users/enting/.gem/ruby/2.0.0/bin"":/Users/enting/.cabal/bin"
    PATH="$PATH:/Users/enting/.gem/ruby/2.0.0/bin:/Users/enting/.cabal/bin:/Users/enting/.local/bin"
    # use GNU utils by default
    # PATH="/usr/local/opt/coreutils/libexec/gnubin:$PATH"
    PATH="/usr/local/opt/gnu-sed/libexec/gnubin:$PATH"
    # PATH="/usr/local/opt/gnu-tar/libexec/gnubin:$PATH"
fi

[[ $- != *i* ]] && return
if [[ -z "$MAC" ]] && [[ -z "$TMUX" ]] ;then
    ID="`tmux ls 2>/dev/null | grep -vm1 attached | cut -d: -f1`" # get the id of a deattached session
    if [[ -z "$ID" ]] ;then # if not available create a new one
        tmux new-session
    else
        tmux attach-session -t "$ID" # if available attach to it
    fi
    # reset # fix vim wired bug after exiting from tmux
fi

# show running tmux sessions
if [[ `tmux list-sessions 2>/dev/null | wc -l` -ne 0 ]] && [[ -z "$TMUX" ]]; then
    echo "`tmux list-sessions 2>/dev/null | wc -l` tmux sessions running"
fi

# Source Prezto.
if [ -s "${ZDOTDIR:-$HOME}/.zprezto/init.zsh" ]; then
  source "${ZDOTDIR:-$HOME}/.zprezto/init.zsh"
fi

# Customize to your needs...
export VISUAL="vim"
export EDITOR="vim"


# aliases
alias reload='clear; source ~/.zshrc'
# alias history='history -i'
if [ -f ~/.sh_aliases ]; then
    . ~/.sh_aliases
fi
if [ -n "$MAC" ]; then
    . ~/.sh_aliases_private
fi

# completion
if [ -f ~/.zsh_complrc ]; then
    . ~/.zsh_complrc
fi

# nice git prompt(taken and modified from http://briancarper.net/blog/570/git-info-in-your-zsh-prompt)
autoload -Uz vcs_info
zstyle ':vcs_info:*' stagedstr '%F{green}●%f'
zstyle ':vcs_info:*' unstagedstr '%F{yellow}●%f'
zstyle ':vcs_info:*' check-for-changes true
zstyle ':vcs_info:(hg*|git*):*' get-revision true
zstyle ':vcs_info:*' enable git hg svn
zstyle ':vcs_info:(sv[nk]|bzr):*' branchformat '%b%F{1}:%F{11}%r'
# zstyle ':vcs_info:*' formats '[%F{blue}%b%f%u%c]'
zstyle ':vcs_info:*' actionformats '[%F{blue}%b%f%c%u] '
zstyle ':vcs_info:hg*:*' branchformat '%b|%r'
zstyle ':vcs_info:hg*:*' hgrevformat '%r'
precmd () {
    if [[ -z $(git ls-files --other --exclude-standard 2> /dev/null) ]] {
        zstyle ':vcs_info:*' formats '[%F{blue}%b%f%c%u] '
    } else {
        zstyle ':vcs_info:*' formats '[%F{blue}%b%f%c%u%F{red}●%f] '
    }
    vcs_info
}
setopt prompt_subst
PROMPT_HOSTNAME="%m"
! [ -z $MAC ] && PROMPT_HOSTNAME="✪" || PROMPT_HOSTNAME="$"
# PROMPT='%F{blue}$PROMPT_HOSTNAME %f%B%F{green}%c%f%b ${vcs_info_msg_0_}'
PROMPT='%(?.%F{blue}${1:-$PROMPT_HOSTNAME}%f.%F{red}${1:-$PROMPT_HOSTNAME}%f) %f%B%F{blue}%c%f%b ${vcs_info_msg_0_}'

# # update prompt if start from vim
# VIM_PROMPT_PATTERN="(vim)"
# VIM_PROMPT_COLOR="red"
# if [ -n "$VIM" ]; then
#     export PROMPT="$PROMPT%B%F{$VIM_PROMPT_COLOR}$VIM_PROMPT_PATTERN%f%b "
# fi

# use vi mode
bindkey -v
# Use vim cli mode
bindkey '^P' up-history
bindkey '^N' down-history
# ctrl-r starts searching history backward
bindkey '^r' history-incremental-search-backward
# no delay on esc
export KEYTIMEOUT=1

# use bash-style # comment
setopt interactivecomments

# mode indicator at right prompt
function zle-line-init zle-keymap-select {
    local NORMAL_PROMPT="%F{red}N%f"
    RPS1="${${KEYMAP/vicmd/$NORMAL_PROMPT}/(main|viins)/}"
    RPS2=$RPS1
    zle reset-prompt
}
zle -N zle-line-init
zle -N zle-keymap-select

# # change cursor shape by mode
# # source: https://emily.st/2013/05/03/zsh-vi-cursor/
# # source: https://gist.github.com/andyfowler/1195581
# zle-keymap-select () {
#   if [ ! -z $TMUX ]; then
#       case $KEYMAP in
#         vicmd) print -n -- "\EPtmux;\E\E]50;CursorShape=0\C-G\E\\";; # block cursor
#         viins|main) print -n -- "\EPtmux;\E\E]50;CursorShape=1\C-G\E\\";; # line cursor
#       esac
#   else
#       case $KEYMAP in
#           vicmd) print -n -- "\E]50;CursorShape=0\C-G";; # block cursor
#           viins|main) print -n -- "\E]50;CursorShape=1\C-G";; # line cursor
#       esac
#   fi
# }
# zle -N zle-keymap-select

# preserve last editing mode
accept-line() { prev_mode=$KEYMAP; zle .accept-line }
zle-line-init() { zle -K ${prev_mode:-viins} }
zle -N accept-line
zle -N zle-line-init

# export HISTFILE=~/.zsh_history   # ensure history file visibility
export HISTFILE=${HOME}/.history/`date "+%Y-%m"`   # ensure history file visibility
export HISTSIZE=100000

# source my mac specific
# z from brew
if `command -v brew >/dev/null 2>&1`; then
    . `brew --prefix`/etc/profile.d/z.sh
    export HOMEBREW_GITHUB_API_TOKEN=bfc33844f4d77154b6a2ab726549a1c6f0215eaf
fi
[ -f ~/.z ] || touch ~/.z  # fix first time z error
[ -f ~/.z.sh ] && source ~/.z.sh

# more key bindings
# bindkey -s '[D' 'pushd ..\n'
# bindkey -s '[C' 'popd\n'
# bindkey -s '[A' '^p\n'
# bindkey -s '^[[B' 'ls\n'
# 'v' opens editor in cmd mode is just annoying
bindkey -a 'v' vi-insert
bindkey -a 'V' edit-command-line
bindkey -a -s '|' 'dda fg\n'
# this fixes the annoying hit escape twice problem
# as a result: any keybinding starts with escape no longer works
# detail see: http://superuser.com/questions/516474/escape-not-idempotent-in-zshs-vi-emulation
bindkey -a '\e' vi-cmd-mode

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

# zsh autosuggestions (installed through homebrew)
# source /usr/local/share/zsh-autosuggestions/zsh-autosuggestions.zsh

# set up react-native android studio
if ! [ -z "$MAC" ]; then
  export ANDROID_HOME=${HOME}/Library/Android/sdk
  export PATH=${PATH}:${ANDROID_HOME}/tools
  export PATH=${PATH}:${ANDROID_HOME}/platform-tools
fi

# source work script
if ! [ -z "$MAC" ]; then
  source ~/.sh_work
fi

# docker
if ! [ -z "$MAC" ]; then
  export DOCKER_TLS_VERIFY="1"
  export DOCKER_HOST="tcp://192.168.64.5:2376"
  export DOCKER_CERT_PATH="/Users/enting/.docker/machine/machines/default"
  export DOCKER_MACHINE_NAME="default"
fi

# iTerm2
# if ! [ -z "$MAC" ]; then
#   test -e "${HOME}/.iterm2_shell_integration.zsh" && source "${HOME}/.iterm2_shell_integration.zsh"
# fi

# fuck
# eval $(thefuck --alias)

# kubernetes
if ! [ -z "$MAC" ]; then
  export KUBECONFIG=$HOME/.kube/config
fi

# histdb
if ! [ -z "$MAC" ]; then
  source $HOME/.history/zsh-histdb/sqlite-history.zsh
  # source /Users/enting/.history/zsh-histdb/histdb-interactive.zsh
  # bindkey '^r' _histdb-isearch
  autoload -Uz add-zsh-hook
  add-zsh-hook precmd histdb-update-outcome
fi

# flutter
PATH="/Users/enting/flutter/bin:$PATH"
