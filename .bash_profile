[ -f ~/.bashrc ] && . ~/.bashrc

export BAT_THEME=GitHub
export GOPATH=$HOME/Go
export PATH=$HOME/.cargo/bin:$GOPATH/bin:/usr/local/sbin:$PATH
export EDITOR=nvim
export MANPAGER='nvim +Man!'
# export MANWIDTH=999
export FZF_DEFAULT_COMMAND='fd --hidden --exclude .git'
export FZF_DEFAULT_OPTS='--bind ctrl-s:toggle-sort,alt-a:toggle-all,ctrl-n:preview-page-down,ctrl-p:preview-page-up,ctrl-/:toggle-preview --cycle --reverse --inline-info --tabstop 2 -0'
export FZF_PREVIEW_OPTS='--preview-window right:64%:wrap:hidden --preview'
export RUSTUP_DIST_SERVER="https://rsproxy.cn"
export RUSTUP_UPDATE_ROOT="https://rsproxy.cn/rustup"
