#!/bin/bash

set -e
cd ~
! hash git 2>/dev/null && sudo apt-get install -y git
git init
git remote add origin "https://github.com/dohsimpson/dotfiles"
git fetch --all
git reset --hard origin/master

vim +PlugInstall +qall > /dev/null

reset

mv ~/.git ~/.git_dotfile
