# ~/.bash_profile

export LANG=en_US.UTF-8
export BAT_THEME=GitHub
[[ -v SSH_AUTH_SOCK ]] && { PATH=/opt/homebrew/bin:$PATH; MANPATH=/opt/homebrew/share/man:$MANPATH; } || {
export C_INCLUDE_PATH=$HOME/.local/include
export CPLUS_INCLUDE_PATH=$HOME/.local/include
export LIBRARY_PATH=$HOME/.local/lib
export LD_LIBRARY_PATH=$HOME/.local/lib
}
export PATH=$HOME/.local/bin:$HOME/.cargo/bin:$PATH
export EDITOR=nvim
export MANPAGER='nvim +Man!'
[[ -v MANPATH ]] && export MANPATH=$HOME/.local/share/man:$MANPATH || export MANPATH=$HOME/.local/share/man:
export FZF_DEFAULT_COMMAND='fd --hidden --exclude .git'
export FZF_DEFAULT_OPTS='--bind ctrl-/:toggle-preview,ctrl-l:clear-selection,ctrl-c:toggle-sort,ctrl-n:page-down,ctrl-p:page-up,ctrl-q:jump,alt-a:toggle-all,alt-j:preview-page-down,alt-k:preview-page-up,alt-w:toggle-preview-wrap --cycle --reverse --inline-info --tabstop 2 -0 --marker • --color light,hl:#6B98DE,hl+:#6B98DE:reverse --preview-window right,75%,wrap,hidden'

[[ -f ~/.bashrc ]] && . ~/.bashrc
