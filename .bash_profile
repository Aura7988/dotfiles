# ~/.bash_profile

[ -f ~/.bashrc ] && . ~/.bashrc

export BAT_THEME=GitHub
export C_INCLUDE_PATH=$HOME/.local/include
export CPLUS_INCLUDE_PATH=$HOME/.local/include
export LIBRARY_PATH=$HOME/.local/lib
export LD_LIBRARY_PATH=$HOME/.local/lib
export PATH=$HOME/.cargo/bin:$HOME/.local/bin:$PATH:$HOME/.local/go/bin
export EDITOR=nvim
export MANPAGER='nvim +Man!'
# export MANPATH=$HOME/.local/share/man:$MANPATH
export FZF_DEFAULT_COMMAND='fd --hidden --exclude .git'
export FZF_DEFAULT_OPTS='--bind ctrl-/:toggle-preview,ctrl-l:clear-selection,ctrl-c:toggle-sort,ctrl-n:page-down,ctrl-p:page-up,ctrl-q:jump,alt-a:toggle-all,alt-j:preview-page-down,alt-k:preview-page-up,alt-w:toggle-preview-wrap --cycle --reverse --inline-info --tabstop 2 -0 --marker •'

# for wsl2
# export DISPLAY=$(grep nameserver /etc/resolv.conf | awk '{print $2}'):0.0
# export DISPLAY=$(route.exe print | grep 0.0.0.0 | head -1 | awk '{print $4}'):0.0
