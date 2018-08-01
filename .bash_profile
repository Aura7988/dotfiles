[ -f ~/.bashrc ] && . ~/.bashrc
stty discard undef # enable ^O

#export MANPATH="/usr/local/opt/coreutils/libexec/gnuman:$MANPATH"
#export PATH="$(brew --prefix coreutils)/libexec/gnubin:$PATH"
#export http_proxy=http://127.0.0.1:7777
#export https_proxy=http://127.0.0.1:7777
#export ALL_PROXY=socks5://127.0.0.1:1086
export SHELL_SESSION_HISTORY=0
export GOPATH=$HOME/Go
export PATH=$PATH:$GOPATH/bin:/usr/local/sbin
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
export HISTIGNORE='vi:ls:la:ll:pwd:cd:fg'
export HISTCONTROL=ignoredups
