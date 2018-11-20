#!/bin/bash

cd ~
! hash git 2>/dev/null && sudo apt-get install -y git
git init
git remote add origin "https://github.com/dohsimpson/dotfiles"
git fetch --all
git reset --hard origin/master

mv ~/.git ~/.git_dotfile

~/.tmux/plugins/tpm/bin/install_plugins
vim +PlugInstall +qall > /dev/null < /dev/null

reset
