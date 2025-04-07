# ~/.bash_profile

export LANG=en_US.UTF-8
export BAT_THEME=GitHub
[[ -v SSH_AUTH_SOCK ]] && PATH=/opt/homebrew/bin:$PATH || {
export C_INCLUDE_PATH=$HOME/.local/include
export CPLUS_INCLUDE_PATH=$HOME/.local/include
export LIBRARY_PATH=$HOME/.local/lib
export LD_LIBRARY_PATH=$HOME/.local/lib
}
export PATH=$HOME/.local/bin:$HOME/.cargo/bin:$PATH
export EDITOR=nvim
export MANPAGER='nvim +Man!'
# export MANPATH=$HOME/.local/share/man:$MANPATH

[[ -f ~/.bashrc ]] && . ~/.bashrc
