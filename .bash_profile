[ -f ~/.bashrc ] && . ~/.bashrc

export GOPATH=$HOME/Go
export GOBIN=$GOPATH/bin
export PATH=$PATH:$GOBIN:/usr/local/sbin:$HOME/.cargo/bin
export EDITOR=vim
export BROWSER=w3m
export GOOGLER_COLORS=bjdxxy
export FZF_DEFAULT_COMMAND='fd --hidden --exclude .git --type f'
export FZF_DEFAULT_OPTS='--bind ctrl-s:toggle-sort,alt-a:select-all,alt-c:deselect-all --cycle --reverse --inline-info --tabstop 2 -0'
export FZF_PREVIEW_OPTS='--bind ctrl-n:preview-page-down,ctrl-p:preview-page-up,ctrl-r:toggle-preview --preview-window right:72%:wrap:hidden --preview'
