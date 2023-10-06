# ~/.bash_profile

[ -f ~/.bashrc ] && . ~/.bashrc

export BAT_THEME=GitHub
export C_INCLUDE_PATH=$HOME/.local/include
export CPLUS_INCLUDE_PATH=$HOME/.local/include
export LIBRARY_PATH=$HOME/.local/lib
export LD_LIBRARY_PATH=$HOME/.local/lib
export PATH=$HOME/.cargo/bin:$HOME/.local/bin:$PATH
export EDITOR=nvim
export MANPAGER='nvim +Man!'
# export MANPATH=$HOME/.local/share/man:$MANPATH
export FZF_DEFAULT_COMMAND='fd --hidden --exclude .git'
export FZF_DEFAULT_OPTS='--bind ctrl-s:toggle-sort,alt-a:toggle-all,ctrl-n:preview-page-down,ctrl-p:preview-page-up,ctrl-/:toggle-preview --cycle --reverse --inline-info --tabstop 2 -0'

# for wsl2
# export DISPLAY=$(grep nameserver /etc/resolv.conf | awk '{print $2}'):0.0
# export DISPLAY=$(route.exe print | grep 0.0.0.0 | head -1 | awk '{print $4}'):0.0
