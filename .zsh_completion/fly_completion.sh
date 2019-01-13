#!/bin/bash

# Took From https://github.com/concourse/concourse/issues/1309
# Which in turn took from https://github.com/cloudfoundry/homebrew-tap/blob/master/cf-cli.rb

_fly_compl() {
    # All arguments except the first one
    args=("${COMP_WORDS[@]:1:$COMP_CWORD}")
    # Only split on newlines
    local IFS=$'\n'
    # Call completion (note that the first element of COMP_WORDS is
    # the executable itself)
    COMPREPLY=($(GO_FLAGS_COMPLETION=1 ${COMP_WORDS[0]} "${args[@]}"))
    return 0
}

complete -F _fly_compl fly
