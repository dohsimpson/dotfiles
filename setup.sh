#!/usr/bin/env sh

set -e
cd ~
! hash git 2>/dev/null && sudo apt-get install -y git
git init
git remote add origin "https://github.com/dohsimpson/dotfiles"
git pull "https://github.com/dohsimpson/dotfiles" master
