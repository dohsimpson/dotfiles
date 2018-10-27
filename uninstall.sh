#!/bin/bash

cd ~
rm -rf ~/.tmux/plugins
rm -rf ~/.vim/plugged
mv ~/.git_dotfile ~/.git
git rm -rf .
rm -rf .git
