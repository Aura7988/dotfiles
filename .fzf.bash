# ~/.fzf.bash

sf() { greenclip print | fzf -e | xargs -r -0 greenclip print; }

rv() {
	local RG="rg --column --line-number --no-heading --color=always --smart-case "
	local QUERY="${*:-}"
	IFS=: read -ra selected < <(
	FZF_DEFAULT_COMMAND="$RG $(printf %q "$QUERY")" \
		fzf --ansi \
		--color "hl:-1:underline,hl+:-1:underline:reverse" \
		--disabled --query "$QUERY" \
		--bind "change:reload:sleep 0.1; $RG {q} || true" \
		--bind "ctrl-r:unbind(change,ctrl-r)+change-prompt(Fzf> )+enable-search+clear-query+rebind(ctrl-g)" \
		--bind "ctrl-g:unbind(ctrl-g)+change-prompt(Ripgrep> )+disable-search+reload($RG {q} || true)+rebind(change,ctrl-r)" \
		--bind "ctrl-n:preview-page-down,ctrl-p:preview-page-up,ctrl-/:toggle-preview" \
		--bind "ctrl-o:execute(nvim {1} < /dev/tty > /dev/tty)" \
		--prompt 'Ripgrep> ' \
		--delimiter : \
		--header '╱ CTRL-G (Ripgrep mode) ╱ CTRL-R (Fzf mode) ╱' \
		--preview 'bat --style=header-filename --color=always {1} --highlight-line {2}' \
		--preview-window 'up,30%,wrap,border-sharp,+{2}+1/3,~1'
	)
	[ -n "${selected[0]}" ] && vi "${selected[0]}" "+${selected[1]}"
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

fk() {
	local ps="ps -ef"; [ "$UID" -ne 0 ] && ps="ps -f -u $UID"
	local pid=$($ps | fzf --header-lines=1 -m --preview 'echo {}' --preview-window up:3:wrap | awk '{print $2}')
	[ -n "$pid" ] && echo $pid | xargs kill -${1:-9}
}

_fzf_cd() {
	d=$(fd -td | fzf $FZF_PREVIEW_OPTS 'tree -C {}') && printf 'cd %q' "$d"
}

_fzf_history() {
	h=$(history | sed 's/^ *[0-9]* *//' | fzf +s --tac) && echo -n "$h"
}

_fzf_select() {
	fzf -m --prompt 'All> ' \
		--header 'CTRL-G: Directories / CTRL-R: Files' \
		--bind 'ctrl-g:change-prompt(Directories> )+reload(fd -td)' \
		--bind 'ctrl-r:change-prompt(Files> )+reload(fd -tf)' \
		$FZF_PREVIEW_OPTS '(bat -n --color=always {} || tree -C {}) 2> /dev/null' |
	while read -r i; do printf '%q ' "$i"; done
}

_git_commits() {
	git rev-parse HEAD &> /dev/null || return
	git l --color=always |
	fzf -m +s --ansi --prompt 'Commits> ' \
		--bind "ctrl-n:preview-page-down,ctrl-p:preview-page-up,ctrl-/:toggle-preview" \
		--preview-window 'up,30%,wrap,border-sharp' \
		--preview 'grep -o "[a-f0-9]\{7,\}" <<< {} | head -1 | xargs git show --color=always' |
	sed -r 's/.* ([a-f0-9]{7,}) - .*/\1/'
}

bind '"\ea": redraw-current-line'
bind '"\C-g": "`_fzf_select`\e\C-e\ea"'
bind '"\C-r": "\C-a\C-k`_fzf_history`\e\C-e\ea"'
bind '"\C-j": "\C-e\C-u`_fzf_cd`\e\C-e\ea\C-m"'
bind '"\C-s": "`_git_commits`\e\C-e\ea"'
