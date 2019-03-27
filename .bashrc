#. /usr/local/lib/python2.7/site-packages/powerline/bindings/bash/powerline.sh
. /usr/local/share/bash-completion/bash_completion
. ~/.shell_prompt.sh
. /usr/local/etc/profile.d/z.sh

stty discard undef # enable ^O

alias gd='git difftool'
alias ls='ls --color=auto'
alias la='ls -A'
alias ll='ls -lh --time-style=long-iso'
alias grep='grep --color=auto'
alias egrep='egrep --color=auto'
alias fgrep='fgrep --color=auto'
alias g++='g++ -Wall --std=c++11'
alias gcc='gcc -Wall --std=c11'
alias ...='cd ../..'
alias ..='cd ../'
alias -- -='cd -'
alias iftop='sudo iftop'
alias mtr='sudo mtr'
alias hp='http_proxy=http://127.0.0.1:1087 https_proxy=http://127.0.0.1:1087'
alias gg='hp googler -n5'
alias @d='gg -n2 define'
alias @s='gg -w stackoverflow.com'
alias @v='gg -w vim.wikia.com'
alias @m='gg -w man7.org'
alias @q='gg -w quora.com'
alias @z='gg -w zhihu.com'
alias @r='gg -w reddit.com'
alias @we='gg -w en.wikipedia.org'
alias @wz='gg -w zh.wikipedia.org'
alias @n='gg -N --url-handler ~/Bash/reader.sh'
alias rg='rg --smart-case --hidden'
alias t='ydcv'
alias brew='hp brew'
alias vi='hp vi'
alias git='hp git'
alias go='hp go'
alias .f='git --git-dir=$HOME/.files/ --work-tree=$HOME'

ss(){ f=$(rg -n $@ | fzf +m | cut -d: --output-delimiter=' +' -f1-2); [[ -n $f ]] && vi $f; }
ww(){ curl wttr.in/${1:-南京}; }
zz(){ cd "$(z 2>&1 | fzf +s --tac | sed 's/[^/]*//')"; }
v(){ f=$(fzf -m); [[ -n $f ]] && vi -- $f; }
fzf_cd(){ d="$(fd -HE.git -td | fzf)" && echo -n "cd $d"; }
fzf_history() { h=$(history | fzf +s --tac --bind=ctrl-r:toggle-sort | sed 's/^ *[0-9]* *//') && echo -n $h; }
fzf_select() { fd -HE.git | fzf -m | while read -r p; do echo -n ' '$p; done; }
bind '"\ea": redraw-current-line'
bind '"\C-g": "`fzf_select`\e\C-e\ea"'
bind '"\C-r": "\C-a\C-k`fzf_history`\e\C-e\ea \C-h"'
bind '"\C-j": "\C-e\C-u`fzf_cd`\e\C-e\ea\C-m"'
