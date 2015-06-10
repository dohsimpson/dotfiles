#
# Executes commands at the start of an interactive session.
#
# Authors:
#   Sorin Ionescu <sorin.ionescu@gmail.com>
#
[[ $- != *i* ]] && return
if [[ -z "$TMUX" ]] ;then
    ID="`tmux ls 2>/dev/null | grep -vm1 attached | cut -d: -f1`" # get the id of a deattached session
    if [[ -z "$ID" ]] ;then # if not available create a new one
        tmux new-session
    else
        tmux attach-session -t "$ID" # if available attach to it
    fi
    # reset # fix vim wired bug after exiting from tmux
fi

# Source Prezto.
if [[ -s "${ZDOTDIR:-$HOME}/.zprezto/init.zsh" ]]; then
  source "${ZDOTDIR:-$HOME}/.zprezto/init.zsh"
fi

# Customize to your needs...
export VISUAL="/usr/local/bin/vim"
export EDITOR="/usr/local/bin/vim"


# aliases
alias vp="vim ~/.zshrc"
alias reload='clear; source ~/.zshrc'
# alias history='history -i'
if [ -f ~/.sh_aliases ]; then
    . ~/.sh_aliases
fi

# z from brew
if [ $(which brew) ]; then
    . `brew --prefix`/etc/profile.d/z.sh
fi

# update prompt if start from vim
VIM_PROMPT_PATTERN="(vim)"
VIM_PROMPT_COLOR="red"
if [ -n "$VIM" ]; then
    export PROMPT="$PROMPT%B%F{$VIM_PROMPT_COLOR}$VIM_PROMPT_PATTERN%f%b "
fi

# source virtualenvwrapper
# source /usr/local/bin/virtualenvwrapper.sh
