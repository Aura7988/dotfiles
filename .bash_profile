[ -f ~/.bashrc ] && . ~/.bashrc

export GOPATH=$HOME/Go
export PATH=$HOME/.cargo/bin:$GOPATH/bin:/usr/local/sbin:$PATH
export EDITOR=nvim
export MANPAGER="nvim -c 'set ft=man' -"
export FZF_DEFAULT_COMMAND='fd --hidden --exclude .git'
export FZF_DEFAULT_OPTS='--bind ctrl-s:toggle-sort,alt-a:select-all,alt-c:deselect-all --cycle --reverse --inline-info --tabstop 2 -0'
export FZF_PREVIEW_OPTS='--bind ctrl-n:preview-page-down,ctrl-p:preview-page-up,ctrl-/:toggle-preview --preview-window right:64%:wrap:hidden --preview'
# export HOMEBREW_BOTTLE_DOMAIN='https://mirrors.ustc.edu.cn/homebrew-bottles'
