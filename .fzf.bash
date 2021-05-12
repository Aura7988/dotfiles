[[ ! $- =~ i ]] && return

s(){ f=$(rg --color always "$@" | fzf --ansi -m -d: $FZF_PREVIEW_OPTS 'let s={2}-3; [ $s -lt 0 ] && s=1; let e={2}+3; bat --color=always -nr $s:$e -H {2} {1}' | cut -d: -f1); [[ -n $f ]] && vi -- $f; }

d(){ diff -raq "$@" | fzf -m --bind "ctrl-o:execute(vi {4} -c 'vert diffs {2}' < /dev/tty > /dev/tty)" | sed -nE 's,^Only in (.*): (.*)$,\1/\2,p; s,^Files (.*) and (.*) differ$,\1 \2,p' | sed 's,//,/,'; }

_fzf_cd(){ d=$(fd -td | fzf $FZF_PREVIEW_OPTS 'tree -C {}') && printf 'cd %q' "$d"; }

_fzf_history(){ h=$(history | sed 's/^ *[0-9]* *//' | fzf +s --tac) && echo -n "$h"; }

_fzf_select(){ fzf -m $FZF_PREVIEW_OPTS '(bat -n --color=always {} || tree -C {}) 2> /dev/null' | while read -r i; do printf '%q ' "$i"; done; }

_fzf_complete_kill() {
	local selected=$(command ps -ef | sed 1d | fzf -m -q "${COMP_WORDS[COMP_CWORD]}" --preview 'echo {}' --preview-window up:3:wrap | awk '{print $2}' | tr '\n' ' ')
	printf '\e[5n'
	if [ -n "$selected" ]; then
		COMPREPLY=("$selected")
		return 0
	fi
}

bind '"\ea": redraw-current-line'
bind '"\C-g": "`_fzf_select`\e\C-e\ea"'
bind '"\C-r": "\C-a\C-k`_fzf_history`\e\C-e\ea"'
bind '"\C-j": "\C-e\C-u`_fzf_cd`\e\C-e\ea\C-m"'
complete -F _fzf_complete_kill -o nospace -o default -o bashdefault kill
