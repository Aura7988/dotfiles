[ -f ~/.bashrc ] && . ~/.bashrc

export GOPATH=$HOME/Go
export GOBIN=$GOPATH/bin
export PATH=$PATH:$GOBIN:/usr/local/sbin
export EDITOR=vim
export BROWSER=w3m
export GOOGLER_COLORS=bjdxxy
#export FZF_TMUX=1
#export FZF_COMPLETION_TRIGGER=',,'
#export FZF_CTRL_T_COMMAND='fd --hidden --exclude .git'
#export FZF_ALT_C_COMMAND="$FZF_CTRL_T_COMMAND --type d"
export FZF_DEFAULT_COMMAND='fd --hidden --exclude .git --type f'
export FZF_DEFAULT_OPTS='--height 33% --reverse --inline-info -e -0'
export _Z_DATA=~/.zd
export HISTSIZE=1600
export HISTIGNORE='pwd:cd'
export HISTCONTROL=ignoredups
