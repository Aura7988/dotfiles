# don't put duplicate lines or lines starting with space in the history.
# See bash(1) for more options
HISTCONTROL=ignoreboth:erasedups
HISTIGNORE='pwd:cd'
HISTSIZE=1000
HISTFILESIZE=9000

# append to the history file, don't overwrite it
shopt -s histappend

# check the window size after each command and, if necessary,
# update the values of LINES and COLUMNS.
shopt -s checkwinsize

# If set, the pattern "**" used in a pathname expansion context will
# match all files and zero or more directories and subdirectories.
# shopt -s globstar

# enable ^O
# stty discard undef

. /usr/local/etc/profile.d/bash_completion.sh
. ~/.prompt.sh
eval "$(lua ~/github/z.lua/z.lua --init bash enhanced once fzf)"
eval "$(dircolors -b)"

alias vi='nvim'
alias gd='git difftool'
alias ls='ls --color=auto'
alias la='ls -A'
alias ll='ls -lh --time-style=long-iso'
alias grep='grep --color=auto'
alias g++='g++ -Wall -std=c++14'
alias gcc='gcc -Wall -std=c11'
alias ...='cd ../..'
alias ..='cd ../'
alias -- -='cd -'
alias b='z -b'
alias hp='http_proxy=http://127.0.0.1:1087 https_proxy=http://127.0.0.1:1087'
alias tt='http_proxy=socks5://127.0.0.1:9150 https_proxy=socks5://127.0.0.1:9150'
alias rg='rg -SnHg !.git/* --hidden'
alias fd='fd --hidden --exclude .git'
alias .f='git --git-dir=$HOME/.files/ --work-tree=$HOME'
alias bu='brew cu -yaq; brew upgrade; brew cleanup'
alias y='pbcopy'
alias p='pbpaste'
alias git='LANG=en_US.UTF-8 git'
alias bison='/usr/local/opt/bison/bin/bison'
alias flex='/usr/local/opt/flex/bin/flex'

FLEXIL="-I/usr/local/opt/flex/include -L/usr/local/opt/flex/lib -lfl"

ww(){ curl wttr.in/${1:-Nanjing}; }

. ~/.fzf.bash
