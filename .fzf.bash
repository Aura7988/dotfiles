# ~/.fzf.bash

FZF_PREVIEW_OPTS='--preview-window right:64%:wrap:hidden --preview'

sf() { greenclip print | fzf -e | xargs -r -0 greenclip print; }

rv() {
	local RG="rg --column --line-number --no-heading --color=always --smart-case"
	fzf --ansi --color "hl:-1:#6B98DE,hl+:-1:#6B98DE:reverse" \
		--bind "start:reload($RG ${*:-''})+unbind(change,ctrl-r)" \
		--bind "change:reload(sleep 0.1; $RG {q} || true)" \
		--bind "ctrl-r:unbind(change,ctrl-r)+change-prompt(Fzf> )+enable-search+clear-query+rebind(ctrl-g)" \
		--bind "ctrl-g:unbind(ctrl-g)+change-prompt(Ripgrep> )+disable-search+reload($RG {q} || true)+rebind(change,ctrl-r)" \
		--bind "ctrl-o:execute(nvim {1} +{2} < /dev/tty > /dev/tty)" \
		--bind 'enter:become(nvim {1} +{2})' \
		--prompt 'Fzf> ' \
		--delimiter : \
		--header '╱ CTRL-G (Ripgrep mode) ╱ CTRL-R (Fzf mode) ╱' \
		--preview 'bat --style=header-filename --color=always {1} --highlight-line {2}' \
		--preview-window 'up,30%,wrap,border-sharp,+{2}+1/3,~1'
}

d() {
	[[ ! -d "$1" || ! -d "$2" ]] && return
	diff -raq "$@" |
	sed -nr 's,^Only in (.*): (.*)$,S: \1/\2,p; s,^Files (.*) and (.*) differ$,D: \1 \2,p' |
	fzf -m --prompt 'Diff> ' \
		--bind "ctrl-o:execute(nvim -d {2} {3} < /dev/tty > /dev/tty)" \
		$FZF_PREVIEW_OPTS 'bat -n --color=always {2}' |
	cut -d' ' -f2-
}

_fzf_kill() {
	ps -fu $UID | fzf -m --header-lines=1 --preview 'echo {}' --preview-window up:3:wrap --bind 'enter:become(kill -9 {+2} &> /dev/null)'
}

_fzf_cd() {
	d=$(fd -td | fzf $FZF_PREVIEW_OPTS 'tree -C {}') && printf 'cd -- %q' "$d"
}

_fzf_history() {
	h=$(history | sed 's/^ *[0-9]* *//' | fzf +s --tac) && echo -n "$h"
}

_fzf_select() {
	fzf -m --prompt 'All> ' --header '╱ CTRL-G: Directories ╱ CTRL-R: Files ╱' \
		--bind 'ctrl-g:change-prompt(Directories> )+reload(fd -td)' \
		--bind 'ctrl-r:change-prompt(Files> )+reload(fd -tf)' \
		$FZF_PREVIEW_OPTS '(bat -n --color=always {} || tree -C {}) 2> /dev/null' |
	while read -r i; do printf '%q ' "$i"; done
}

_git_commits() {
	git rev-parse HEAD &> /dev/null || return
	git l --color=always |
	fzf -m +s --ansi --prompt 'Commits> ' \
		--preview-window 'up,30%,wrap,border-sharp' \
		--preview 'grep -o "[a-f0-9]\{7,\}" <<< {} | head -1 | xargs git show --color=always' |
	sed -r 's/.* ([a-f0-9]{7,}) - .*/\1/'
}

bind '"\ea": redraw-current-line'
bind '"\ej": " \C-b\C-k \C-u`_fzf_cd`\e\C-e\ea\C-m\C-y\C-h\e \C-y\ey\C-x\C-x\C-d"'
bind '"\C-q": " \C-b\C-k \C-u`_fzf_kill`\e\C-e\ea\C-y\C-h\e \C-y\ey\C-x\C-x\C-d"'
bind '"\C-s": " \C-b\C-k \C-u`_fzf_select`\e\C-e\ea\C-y\C-h\e \C-y\ey\C-x\C-x\C-d"'
bind '"\C-r": "\C-a\C-k`_fzf_history`\e\C-e\ea"'
bind '"\C-g": "`_git_commits`\e\C-e\ea"'
