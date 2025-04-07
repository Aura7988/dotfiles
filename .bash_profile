# ~/.bash_profile

[[ -f ~/.bashrc ]] && . ~/.bashrc

export LANG=en_US.UTF-8
export BAT_THEME=GitHub
export C_INCLUDE_PATH=$HOME/.local/include
export CPLUS_INCLUDE_PATH=$HOME/.local/include
export LIBRARY_PATH=$HOME/.local/lib
export LD_LIBRARY_PATH=$HOME/.local/lib
export PATH=$HOME/.cargo/bin:$HOME/.local/bin:$PATH:$HOME/.local/go/bin
export EDITOR=nvim
export MANPAGER='nvim +Man!'
# export MANPATH=$HOME/.local/share/man:$MANPATH
