#!/bin/bash -e

alias .f='git --git-dir=$HOME/.files/ --work-tree=$HOME'
git init --bare ~/.files
.f config status.showUntrackedFiles no
.f a .bash_profile .bashrc .commit-template .fzf.bash .gitconfig .prompt.sh .tmux.conf .npmrc
z nvim
.f a *.vim coc-settings.json
.f cm 'init'
