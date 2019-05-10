[ -f ~/.bashrc ] && . ~/.bashrc

export GOPATH=$HOME/Go
export GOBIN=$GOPATH/bin
export PATH=$PATH:$GOBIN:/usr/local/sbin:$HOME/.cargo/bin
export EDITOR=vim
export BROWSER=w3m
export GOOGLER_COLORS=bjdxxy
#export FZF_TMUX=1
#export FZF_COMPLETION_TRIGGER=',,'
#export FZF_CTRL_T_COMMAND='fd --hidden --exclude .git'
#export FZF_ALT_C_COMMAND="$FZF_CTRL_T_COMMAND --type d"
export FZF_DEFAULT_COMMAND='fd --hidden --exclude .git --type f'
export FZF_DEFAULT_OPTS='--reverse --inline-info -0'
export FZF_PREVIEW_OPTS='--bind ctrl-n:preview-page-down,ctrl-p:preview-page-up --preview-window right:72%:wrap --preview'
export HISTSIZE=1600
export HISTIGNORE='pwd:cd'
export HISTCONTROL=ignoredups
