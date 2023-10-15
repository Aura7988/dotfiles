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
		--bind "ctrl-o:execute(nvim {1} +{2} > /dev/tty)" \
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
		--bind "ctrl-o:execute(nvim -d {2} {3} > /dev/tty)" \
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

_fzf_git_branches() {
	git rev-parse HEAD &> /dev/null || return
	git branch -a --sort=-committerdate --sort=-HEAD --color=always \
		--format=$'%(HEAD) %(color:yellow)%(refname:short) %(color:green)(%(committerdate:relative))\t%(color:blue)%(subject)%(color:reset)' |
	column -ts$'\t' |
	fzf -m --ansi --color "hl:-1:#6B98DE,hl+:-1:#6B98DE:reverse" \
		--tiebreak begin --no-hscroll --prompt 'Branches> ' \
		--bind 'ctrl-o:execute:nvim <(sed s/^..// <<< {} | cut -d" " -f1 | xargs git diff) > /dev/tty' \
		--preview-window 'up,35%,wrap,border-sharp' \
		--preview 'git l --oneline --color=always $(sed s/^..// <<< {} | cut -d" " -f1)' |
	sed 's/^..//' | cut -d' ' -f1
}

_fzf_git_each_ref() {
	git rev-parse HEAD &> /dev/null || return
	git for-each-ref --sort=-creatordate --sort=-HEAD --color=always --format=$'%(refname) %(color:green)(%(creatordate:relative))\t%(color:blue)%(subject)%(color:reset)' |
	sed 's#^refs/remotes/#\x1b[95mremote-branch\t\x1b[33m#; s#^refs/heads/#\x1b[92mbranch\t\x1b[33m#; s#^refs/tags/#\x1b[96mtag\t\x1b[33m#; s#refs/stash#\x1b[91mstash\t\x1b[33mrefs/stash#' |
	column -ts$'\t' |
	fzf -m --ansi --color "hl:-1:#6B98DE,hl+:-1:#6B98DE:reverse" \
		--nth 2,2.. --tiebreak begin --no-hscroll --prompt 'Every ref> ' \
		--bind 'ctrl-o:execute:nvim <(git show {2}) > /dev/tty' \
		--preview-window 'up,35%,wrap,border-sharp' \
		--preview 'git l --oneline --color=always {2}' |
	awk '{print $2}'
}

_fzf_git_files() {
	git rev-parse HEAD &> /dev/null || return
	(git -c color.status=always status --short --no-branch
	git ls-files | grep -vxFf <(git status -s | grep '^[^?]' | cut -c4-; echo :) | sed 's/^/   /') |
	fzf --prompt 'Files> ' -m --ansi --nth 2..,.. \
		--bind 'ctrl-o:execute(nvim {-1} > /dev/tty)' \
		--preview-window 'right,75%,wrap,border-sharp' \
		--preview 'git diff --no-ext-diff --color=always -- {-1} | sed 1,4d; bat --color=always {-1}' |
	cut -c4- |
	sed 's/.* -> //'
}

_fzf_git_hashes() {
	git rev-parse HEAD &> /dev/null || return
	git l --color=always |
	fzf -m +s --prompt 'Hashes> ' \
		--bind 'ctrl-o:execute(nvim <(grep -o "[a-f0-9]\{7,\}" <<< {} | xargs git show) > /dev/tty)' \
		--bind 'ctrl-l:execute(nvim <(grep -o "[a-f0-9]\{7,\}" <<< {} | xargs git diff) > /dev/tty)' \
		--ansi --color "hl:-1:#6B98DE,hl+:-1:#6B98DE:reverse" \
		--preview-window 'up,35%,wrap,border-sharp' \
		--preview 'grep -o "[a-f0-9]\{7,\}" <<< {} | xargs git show --color=always' |
	sed -r 's/.* ([a-f0-9]{7,}) - .*/\1/'
}

_fzf_git_reflogs() {
	git rev-parse HEAD &> /dev/null || return
	git reflog --color=always --format="%C(blue)%gD %C(yellow)%h%C(auto)%d %gs" |
	fzf --prompt 'Reflogs> ' --ansi --color "hl:-1:#6B98DE,hl+:-1:#6B98DE:reverse" \
		--preview 'git show --color=always {1}' |
	awk '{print $1}'
}

_fzf_git_stashes() {
	git rev-parse HEAD &> /dev/null || return
	git stash list |
	fzf -d: --prompt 'Stashes> ' \
		--bind 'ctrl-o:execute(nvim <(git show {1}) > /dev/tty)' \
		--bind 'ctrl-x:execute-silent(git stash drop {1})+reload(git stash list)' \
		--preview-window 'up,50%,wrap,border-sharp' --preview 'git show --color=always {1}' |
	cut -d: -f1
}

_fzf_git_tags() {
	git rev-parse HEAD &> /dev/null || return
	git tag --sort -version:refname |
	fzf -m --prompt 'Tags> ' --bind 'ctrl-o:execute(nvim <(git diff {}) > /dev/tty)' \
		--preview-window 'right,75%,wrap,border-sharp' --preview 'git show --color=always {}'
}

_fzf_git_ups() {
	git rev-parse HEAD &> /dev/null || return
	git remote -v | awk '{print $1 "\t" $2}' | uniq |
	fzf --prompt 'Upstream> ' --tac \
		--preview-window right,70% \
		--preview 'git l --oneline --color=always {1}/"$(git rev-parse --abbrev-ref HEAD)"' |
	cut -d$'\t' -f1
}

bind '"\ea": redraw-current-line'
bind '"\ej": " \C-b\C-k \C-u`_fzf_cd`\e\C-e\ea\C-m\C-y\C-h\e \C-y\ey\C-x\C-x\C-d"'
bind '"\C-q": " \C-b\C-k \C-u`_fzf_kill`\e\C-e\ea\C-y\C-h\e \C-y\ey\C-x\C-x\C-d"'
bind '"\C-s": " \C-b\C-k \C-u`_fzf_select`\e\C-e\ea\C-y\C-h\e \C-y\ey\C-x\C-x\C-d"'
bind '"\C-r": "\C-a\C-k`_fzf_history`\e\C-e\ea"'

for o in branches each_ref files hashes reflogs stashes tags ups; do
	bind '"\C-g'${o:0:1}'": " \C-b\C-k \C-u`_fzf_git_'$o'`\e\C-e\ea\C-y\C-h\e \C-y\ey\C-x\C-x\C-d"'
done
