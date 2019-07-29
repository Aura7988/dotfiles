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
stty discard undef

. /usr/local/share/bash-completion/bash_completion
. ~/.shell_prompt.sh
eval "$(lua ~/github/z.lua/z.lua --init bash enhanced once fzf)"

alias gd='git difftool'
alias ls='ls --color=auto'
alias la='ls -A'
alias ll='ls -lh --time-style=long-iso'
alias grep='grep --color=auto'
alias g++='g++ -Wall --std=c++11'
alias gcc='gcc -Wall --std=c11'
alias ...='cd ../..'
alias ..='cd ../'
alias -- -='cd -'
alias hp='http_proxy=http://127.0.0.1:1087 https_proxy=http://127.0.0.1:1087'
alias rg='rg -SnHg !.git/* --hidden'
alias fd='fd --hidden --exclude .git'
alias go='hp go'
alias .f='git --git-dir=$HOME/.files/ --work-tree=$HOME'
alias bu='brew cu -yaq && brew upgrade && (cd ~/Library/Caches/Homebrew/; rm downloads/*; fd -tl -x rm {})'
alias y='pbcopy'

# s(){ f=$(rg -n $@ | fzf +m -d: $FZF_PREVIEW_OPTS 'let e={2}+5 && bat -n --color=always --line-range :$e {1} | tac | head | tac' | cut -d: --output-delimiter=' +' -f1-2); [[ -n $f ]] && vi $f; }
s(){ f=$(rg --color always $@ | fzf --ansi -m -d: $FZF_PREVIEW_OPTS 'let s={2}-3 && let e={2}+5 && bat -n --color=always --line-range $s:$e {1}' | cut -d: -f1); [[ -n $f ]] && vi -- $f; }
ww(){ curl wttr.in/${1:-南京}; }
zz(){ d=$(z -s | fzf +s --tac) && echo $d && cd "$d"; }
v(){ f=$(fzf -m $FZF_PREVIEW_OPTS 'bat -n --color=always {} | head -300'); [[ -n $f ]] && vi -- $f; }
fzf_cd(){ d=$(fd -td | fzf $FZF_PREVIEW_OPTS 'tree -C {} | head -300') && echo -n "cd '$d'"; }
fzf_history() { h=$(history | fzf +s --tac | sed 's/^ *[0-9]* *//') && echo -n $h; }
fzf_select() { i=$(fd | fzf -m) && echo -n $i; }
_fzf_complete_kill() {
	local selected
	selected=$(command ps -ef | sed 1d | fzf -m -q "${COMP_WORDS[COMP_CWORD]}" --preview 'echo {}' --preview-window up:3:wrap | awk '{print $2}' | tr '\n' ' ')
	printf '\e[5n'
	if [ -n "$selected" ]; then
		COMPREPLY=("$selected")
		return 0
	fi
}

bind '"\ea": redraw-current-line'
bind '"\C-g": "`fzf_select`\e\C-e\ea"'
bind '"\C-r": "\C-a\C-k`fzf_history`\e\C-e\ea"'
bind '"\C-j": "\C-e\C-u`fzf_cd`\e\C-e\ea\C-m"'
complete -F _fzf_complete_kill -o nospace -o default -o bashdefault kill
