# ~/.fzf.bash

export FZF_PREVIEW_OPTS='--preview-window right:75%:wrap:hidden --preview'
export FZF_COLOR='--color hl:-1:#6B98DE,hl+:-1:#6B98DE:reverse'

sf() { greenclip print | fzf -e | xargs -r -0 greenclip print; }

rv() {
	local RG='rg --column --line-number --with-filename --no-heading --color=always --smart-case'
	$RG "${@:-""}" |
	fzf -m --ansi $FZF_COLOR --delimiter : --prompt 'Fzf> ' \
		--header '╱ CTRL-G: Switch between Fzf/Ripgrep mode ╱' \
		--bind "start:unbind(change)" \
		--bind "change:reload(sleep 0.1; $RG {q} || true)" \
		--bind "ctrl-g:transform:[[ \$FZF_PROMPT =~ Fzf ]] &&
			echo 'change-prompt(Ripgrep> )+disable-search+reload($RG \{q} || :)+rebind(change)' ||
			echo 'change-prompt(Fzf> )+enable-search+clear-query+unbind(change)'" \
		--bind "ctrl-o:execute:nvim {1} +{2}" \
		--bind 'enter:become(nvim -q {+f})' \
		--preview 'bat --style=header-filename --color=always {1} --highlight-line {2}' \
		--preview-window 'up,30%,wrap,border-sharp,+{2}+1/3,~1'
}

dr() {
	[[ ! -d "$1" || ! -d "$2" ]] && return
	diff -raq "$@" |
	sed -nr 's,^Only in (.*): (.*)$,S: \1/\2,p; s,^Files (.*) and (.*) differ$,D: \1 \2,p' |
	fzf -m --prompt 'Diff> ' \
		--bind "ctrl-o:execute:nvim -d {2} {3}" \
		$FZF_PREVIEW_OPTS 'bat -n --color=always {2}' |
	cut -d' ' -f2-
}

_fzf_kill() {
	ps -fu $UID |
	fzf -m --header-lines=1 --preview 'echo {}' --preview-window up:3:wrap \
		--bind 'enter:become(echo {+2}),alt-enter:become(kill -9 {+2} &> /dev/null)'
}

_fzf_cd() {
	fd -HE .git -td | fzf $FZF_PREVIEW_OPTS 'tree -C {}' --bind 'enter:become:printf "cd -- %q" {}'
}

_fzf_history() {
	history | sed 's/^ *[0-9]* *//' | fzf +s --tac --bind 'enter:become:echo -n {}'
}

_fzf_select() {
	fd -HE .git -tf |
	fzf -m --prompt 'Files> ' --header '╱ CTRL-G: Switch between Files/Directories ╱' \
		--bind 'ctrl-g:transform:[[ $FZF_PROMPT =~ Files ]] &&
			echo "change-prompt(Directories> )+reload(fd -H -td)" ||
			echo "change-prompt(Files> )+reload(fd -HE .git -tf)"' \
		--bind 'ctrl-o:execute:nvim {}' \
		$FZF_PREVIEW_OPTS '[[ $FZF_PROMPT =~ Files ]] && bat -p --color=always {} || tree -C {}' |
	while read -r i; do printf '%q ' "$i"; done
}

_fbr() {
	git branch "$@" --sort=-committerdate --sort=-HEAD --color --format=$'%(HEAD) %(color:yellow)%(refname:short) %(color:green)(%(committerdate:relative))\t%(color:blue)%(subject)%(color:reset)' | column -ts$'\t'
}
export -f _fbr

_fzf_git_branches() {
	git rev-parse HEAD &> /dev/null || return
	_fbr |
	fzf -m --tiebreak begin --no-hscroll --ansi $FZF_COLOR --prompt 'Branches> ' \
		--header '╱ ALT-R: Toggle remote branches ╱' \
		--bind 'alt-r:transform:[[ $FZF_PROMPT =~ All ]] &&
			echo "change-prompt(Branches> )+reload(_fbr)" ||
			echo "change-prompt(AllBranches> )+reload(_fbr -a)"' \
		--bind 'ctrl-o:execute:nvim <(sed s/^..// <<< {} | cut -d" " -f1 | xargs git diff)' \
		$FZF_PREVIEW_OPTS 'git l --color $(sed s/^..// <<< {} | cut -d" " -f1)' |
	sed 's/^..//' | cut -d' ' -f1
}

_fzf_git_each_ref() {
	git rev-parse HEAD &> /dev/null || return
	git for-each-ref --sort=-creatordate --sort=-HEAD --color --format=$'%(refname) %(color:green)(%(creatordate:relative))\t%(color:blue)%(subject)%(color:reset)' |
	sed 's#^refs/remotes/#\x1b[95mremote-branch\t\x1b[33m#; s#^refs/heads/#\x1b[92mbranch\t\x1b[33m#; s#^refs/tags/#\x1b[96mtag\t\x1b[33m#; s#refs/stash#\x1b[91mstash\t\x1b[33mrefs/stash#' |
	column -ts$'\t' |
	fzf -m --ansi $FZF_COLOR \
		--nth 2,2.. --tiebreak begin --no-hscroll --prompt 'Every ref> ' \
		--bind 'ctrl-o:execute:nvim <(git show {2})' \
		--preview-window 'up,35%,wrap,border-sharp' \
		--preview 'git l --color {2}' |
	awk '{print $2}'
}

_fzf_git_files() {
	git rev-parse HEAD &> /dev/null || return
	(git status -s | sed -r 's/^(..)./[31m\1[m\t/'
	git ls-files | grep -vxFf <(git status -s | grep '^[^?]' | cut -c4-; echo :) | sed 's/^/  \t/') |
	fzf --prompt 'GFiles> ' -m --ansi -d "\t" --tabstop=1 \
		--bind 'ctrl-o:execute:eval nvim {2}' \
		--bind 'alt-h:become(eval _fzf_git_hashes -- {+2})' \
		--bind 'enter:become(echo {+2})' \
		$FZF_PREVIEW_OPTS 'eval git diff --no-ext-diff --color -- {2} | sed 1,4d; eval bat --style=header --color=always {2}'
}

_fzf_git_hashes() {
	git rev-parse HEAD &> /dev/null || return
	git l --color "$@" |
	fzf -m +s --prompt 'Hashes> ' --ansi $FZF_COLOR \
		--bind 'ctrl-o:execute:nvim <(grep -Eo "[a-f0-9]{7,}" <<< {} | xargs -Ih git diff h~ h)' \
		$FZF_PREVIEW_OPTS 'grep -Eo "[a-f0-9]{7,}" <<< {} | xargs git show --color --stat' |
	sed -r 's/.* ([a-f0-9]{7,}) - .*/\1/'
}
export -f _fzf_git_hashes

_fzf_git_reflogs() {
	git rev-parse HEAD &> /dev/null || return
	git reflog --color --format="%C(blue)%gD %C(yellow)%h%C(auto)%d %gs" |
	fzf --prompt 'Reflogs> ' --ansi $FZF_COLOR --preview 'git show --color {1}' |
	awk '{print $1}'
}

_fzf_git_stashes() {
	git rev-parse HEAD &> /dev/null || return
	git stash list |
	fzf -d: --prompt 'Stashes> ' \
		--header '╱ CTRL-X: Drop selected stash entry ╱' \
		--bind 'ctrl-o:execute:nvim <(git show {1})' \
		--bind 'ctrl-x:execute-silent(git stash drop {1})+reload(git stash list)' \
		--preview-window 'up,50%,wrap,border-sharp' --preview 'git show --color {1}' |
	cut -d: -f1
}

_fzf_git_tags() {
	git rev-parse HEAD &> /dev/null || return
	git tag --sort -version:refname |
	fzf -m --prompt 'Tags> ' \
		--bind 'ctrl-o:execute:nvim <(git diff `git describe --always --abbrev=0 --tags {}~` {})' \
		$FZF_PREVIEW_OPTS 'git diff --color --stat `git describe --always --abbrev=0 --tags {}~` {}'
}

_fzf_git_ups() {
	git rev-parse HEAD &> /dev/null || return
	git remote -v | awk '{print $1 "\t" $2}' | uniq |
	fzf --prompt 'Upstream> ' --tac \
		$FZF_PREVIEW_OPTS 'git l --color {1}/"$(git rev-parse --abbrev-ref HEAD)"' |
	cut -d$'\t' -f1
}

bind '"\ea": redraw-current-line'
bind '"\ej": " \C-b\C-k \C-u`_fzf_cd`\e\C-e\ea\C-m\C-y\C-h\e \C-y\ey\C-x\C-x\C-d"'
bind '"\C-q": " \C-b\C-k \C-u`_fzf_kill`\e\C-e\ea\C-a\C-y\C-h\C-e\e \C-y\ey\C-x\C-x\C-d"'
bind '"\C-s": " \C-b\C-k \C-u`_fzf_select`\e\C-e\ea\C-a\C-y\C-h\C-e\e \C-y\ey\C-x\C-x\C-d"'
bind '"\C-r": "\C-a\C-k`_fzf_history`\e\C-e\ea"'

for o in branches each_ref files hashes reflogs stashes tags ups; do
	bind '"\C-g'${o:0:1}'": " \C-b\C-k \C-u`_fzf_git_'$o'`\e\C-e\ea\C-a\C-y\C-h\C-e\e \C-y\ey\C-x\C-x\C-d"'
done
