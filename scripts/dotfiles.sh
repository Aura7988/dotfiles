#!/bin/bash -e

alias .f='git --git-dir=$HOME/.files/ --work-tree=$HOME'
git init --bare ~/.files
.f config status.showUntrackedFiles no
.f a .bash_profile .bashrc .commit-template .fzf.bash .gitconfig .prompt.sh .tmux.conf .npmrc
z nvim
.f a *.vim coc-settings.json
.f cm 'init'

# Installing on a New System
git clone --bare git@github.com:Aura7988/dotfiles.git .files
.f checkout
if [[ $? -ne 0 ]]; then
	echo "Moving existing dotfiles to ~/.dotfiles-backup";
	mkdir -p .dotfiles-backup
	config checkout 2>&1 | egrep "\s+\." | awk {'print $1'} | xargs -I{} mv {} .dotfiles-backup/{}
	.f checkout
fi
.f config --local status.showUntrackedFiles no
