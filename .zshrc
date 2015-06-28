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

# [[ $- != *i* ]] && return
# if [[ -z "$TMUX" ]] ;then
#     ID="`tmux ls 2>/dev/null | grep -vm1 attached | cut -d: -f1`" # get the id of a deattached session
#     if [[ -z "$ID" ]] ;then # if not available create a new one
#         tmux new-session
#     else
#         tmux attach-session -t "$ID" # if available attach to it
#     fi
#     # reset # fix vim wired bug after exiting from tmux
# fi

# Source Prezto.
if [ -s "${ZDOTDIR:-$HOME}/.zprezto/init.zsh" ]; then
  source "${ZDOTDIR:-$HOME}/.zprezto/init.zsh"
fi

# Customize to your needs...
export VISUAL="vim"
export EDITOR="vim"


# aliases
alias vp="vim ~/.zshrc"
alias reload='clear; source ~/.zshrc'
# alias history='history -i'
if [ -f ~/.sh_aliases ]; then
    . ~/.sh_aliases
fi

# z from brew
if `command -v brew >/dev/null 2>&1`; then
    . `brew --prefix`/etc/profile.d/z.sh
fi

# nice git prompt(taken and modified from http://briancarper.net/blog/570/git-info-in-your-zsh-prompt)
autoload -Uz vcs_info
zstyle ':vcs_info:*' stagedstr '%F{green}●'
zstyle ':vcs_info:*' unstagedstr '%F{yellow}●'
zstyle ':vcs_info:*' check-for-changes true
zstyle ':vcs_info:(sv[nk]|bzr):*' branchformat '%b%F{1}:%F{11}%r'
zstyle ':vcs_info:*' enable git svn
precmd () {
    if [[ -z $(git ls-files --other --exclude-standard 2> /dev/null) ]] {
        zstyle ':vcs_info:*' formats '[%F{blue}%b%c%u%f] '
    } else {
        zstyle ':vcs_info:*' formats '[%F{blue}%b%c%u%f%F{red}●%f] '
    }
    vcs_info
}
setopt prompt_subst
# PROMPT='%B%F{green}%c%f%b %B%F%f%b'
PROMPT='%B%F{green}%c%f%b ${vcs_info_msg_0_}'

# update prompt if start from vim
VIM_PROMPT_PATTERN="(vim)"
VIM_PROMPT_COLOR="red"
if [ -n "$VIM" ]; then
    export PROMPT="$PROMPT%B%F{$VIM_PROMPT_COLOR}$VIM_PROMPT_PATTERN%f%b "
fi

# source k
# (lazy load)
k() {
    if [ -f ~/Scripts/shell_utils/k.sh ]; then
        source ~/Scripts/shell_utils/k.sh
    fi
    k
}

# use vi mode
bindkey -v
# Use vim cli mode
bindkey '^P' up-history
bindkey '^N' down-history
# ctrl-r starts searching history backward
bindkey '^r' history-incremental-search-backward
# no delay on esc
export KEYTIMEOUT=1
# mode indicator at right prompt
function zle-line-init zle-keymap-select {
    RPS1="${${KEYMAP/vicmd/N}/(main|viins)/I}"
    RPS2=$RPS1
    zle reset-prompt
}
zle -N zle-line-init
zle -N zle-keymap-select
# source opp for better vim
# if [ -f ~/Scripts/shell_utils/opp.zsh/opp.zsh ]; then
#     source ~/Scripts/shell_utils/opp.zsh/opp.zsh
#     source ~/Scripts/shell_utils/opp.zsh/opp/*.zsh
# fi
if `command -v hh >/dev/null 2>&1`; then
    export HISTFILE=~/.zsh_history   # ensure history file visibility
    export HH_CONFIG=hicolor
    # export HH_CONFIG=hicolor,rawhistory
    bindkey -s "^r" "\eqhh\n"      # bind hh to Ctrl-r (for Vi mode check doc)
fi

# docker
if `command -v boot2docker > /dev/null 2>&1`; then
    export DOCKER_HOST=tcp://192.168.59.103:2376
    export DOCKER_CERT_PATH=$HOME/.boot2docker/certs/boot2docker-vm
    export DOCKER_TLS_VERIFY=1
fi
