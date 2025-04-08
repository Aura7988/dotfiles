# ~/.fzf.bash

sf() { greenclip print | fzf -e | xargs -r -0 greenclip print; }

rv() {
	local RG='rg --column --line-number --with-filename --no-heading --color=always --smart-case'
	$RG "${@:-""}" |
	fzf -m --ansi --delimiter : --prompt 'Fzf> ' \
		--header '╱ CTRL-G: Switch between Fzf/Ripgrep mode ╱' \
		--bind "start:unbind(change)" \
		--bind "change:reload(sleep 0.1; $RG {q} || true)" \
		--bind "ctrl-g:transform:[[ \$FZF_PROMPT =~ Fzf ]] &&
			echo 'change-prompt(Ripgrep> )+disable-search+reload($RG \{q} || :)+rebind(change)' ||
			echo 'change-prompt(Fzf> )+enable-search+clear-query+unbind(change)'" \
		--bind "ctrl-o:execute:nvim {1} +{2}" \
		--bind 'enter:become(nvim -q {+f})' \
		--preview 'bat --style=header-filename --color=always {1} --highlight-line {2}' \
		--preview-window 'up,30%,+{2}+1/3,~1'
}

dr() {
	[[ ! -d "$1" || ! -d "$2" ]] && return
	diff -raq "$@" |
	sed -nr 's,^Only in (.*): (.*)$,S: \1/\2,p; s,^Files (.*) and (.*) differ$,D: \1 \2,p' |
	fzf -m --prompt 'Diff> ' \
		--bind "ctrl-o:execute:nvim -d {2} {3}" \
		--preview 'bat -n --color=always {2}' |
	cut -d' ' -f2-
}

_fzf_kill() {
	ps -fu $UID |
	fzf -m --header-lines=1 --preview 'echo {}' --preview-window up,3 \
		--bind 'enter:become(echo {+2}),alt-enter:become(kill -9 {+2} &> /dev/null)'
}

_fzf_cd() {
	fd -HE .git -td | fzf --preview 'tree -C {}' --bind 'enter:become:printf "cd -- %q" {}'
}

_fzf_history() {
	history | sed 's/^ *[0-9]* *//' | fzf +s --tac --bind 'enter:become:echo -n {}' --preview 'echo {}' --preview-window up,3
}

_fzf_select() {
	fd -HE .git -tf |
	fzf -m --prompt 'Files> ' --header '╱ CTRL-G: Switch between Files/Directories ╱' \
		--bind 'ctrl-g:transform:[[ $FZF_PROMPT =~ Files ]] &&
			echo "change-prompt(Directories> )+reload(fd -HE .git -td)" ||
			echo "change-prompt(Files> )+reload(fd -HE .git -tf)"' \
		--bind 'ctrl-o:execute:nvim {}' \
		--preview '[[ $FZF_PROMPT =~ Files ]] && bat -p --color=always {} || tree -C {}' |
	while read -r i; do printf '%q ' "$i"; done
}

_fbr() {
	git branch "$@" --sort=-committerdate --sort=-HEAD --color --format=$'%(HEAD) %(color:yellow)%(refname:short) %(color:green)(%(committerdate:relative))\t%(color:blue)%(subject)%(color:reset)' | column -ts$'\t' | sed 's/^..//'
}
export -f _fbr

_fzf_git_branches() {
	git rev-parse HEAD &> /dev/null || return
	_fbr |
	fzf -m --tiebreak begin --no-hscroll --ansi --prompt 'Branches> ' \
		--header '╱ ALT-R: Toggle remote branches ╱' \
		--bind 'alt-r:transform:[[ $FZF_PROMPT =~ All ]] &&
			echo "change-prompt(Branches> )+reload(_fbr)" ||
			echo "change-prompt(AllBranches> )+reload(_fbr -a)"' \
		--bind 'ctrl-o:execute:nvim "+G diff {1}|on"' \
		--bind 'alt-h:become:_fzf_git_hashes {1}' \
		--bind 'enter:become:echo {+1}' \
		--preview 'git l --color {1}'
}

_fzf_git_each_ref() {
	git rev-parse HEAD &> /dev/null || return
	git for-each-ref --sort=-creatordate --sort=-HEAD --color --format=$'%(refname) %(color:green)(%(creatordate:relative))\t%(color:blue)%(subject)%(color:reset)' |
	sed 's#^refs/remotes/#\x1b[95mremote-branch\t\x1b[33m#; s#^refs/heads/#\x1b[92mbranch\t\x1b[33m#; s#^refs/tags/#\x1b[96mtag\t\x1b[33m#; s#refs/stash#\x1b[91mstash\t\x1b[33mrefs/stash#' |
	column -ts$'\t' |
	fzf -m --ansi --nth 2,2.. --tiebreak begin --no-hscroll --prompt 'Every ref> ' \
		--bind 'ctrl-o:execute:nvim <(git show {2})' \
		--preview 'git l --color {2}' |
	awk '{print $2}'
}

_fzf_git_files() {
	# git 对文件名包含特殊符号的行为看起来好像不一致：git status 会对包含空格的文件名加双引号，但 git ls-files 不加；两个命令对文件名中含有单引号都不加双引号。暂时不处理特殊符号的问题。
	git rev-parse HEAD &> /dev/null || return
	(git status -s | sed -r 's/^(..)./[31m\1[m\t/'
	git ls-files | grep -vxFf <(git status -s | grep '^[^?]' | cut -c4-; echo :) | sed 's/^/  \t/') |
	fzf --prompt 'GFiles> ' -m --ansi -d "\t" --tabstop=1 \
		--bind 'ctrl-o:execute:nvim {2}' \
		--bind 'alt-h:become(_fzf_git_hashes -- {+2})' \
		--bind 'enter:become(echo {+2})' \
		--preview 'git diff --no-ext-diff --color -- {2} | sed 1,4d; bat --style=header --color=always {2}'
}

_fzf_git_hashes() {
	git rev-parse HEAD &> /dev/null || return
	git l --color "$@" |
	fzf -m +s --prompt 'Hashes> ' --ansi \
		--bind 'ctrl-o:execute:nvim "+G show --dd "`grep -Eo "[a-f0-9]{7,}" <<< {} | head -1`"|on"' \
		--preview 'git show --color --stat `grep -Eo "[a-f0-9]{7,}" <<< {} | head -1`' |
	sed -r 's/.* ([a-f0-9]{7,}) - .*/\1/'
}
export -f _fzf_git_hashes

_fzf_git_reflogs() {
	git rev-parse HEAD &> /dev/null || return
	git reflog --color --format='%Cblue%gD %Cred%h%Creset %gs%Cgreen%d' |
	fzf --prompt 'Reflogs> ' --ansi --preview 'git show --color {1}' |
	awk '{print $1}'
}

_fzf_git_stashes() {
	git rev-parse HEAD &> /dev/null || return
	git stash list |
	fzf -d: --prompt 'Stashes> ' --header '╱ CTRL-X: Drop selected stash entry ╱' \
		--bind 'ctrl-o:execute:nvim "+G stash show -p {1}|on"' \
		--bind 'ctrl-x:execute-silent(git stash drop {1})+reload(git stash list)' \
		--preview-window 'up,25%' --preview 'git -c color.ui=always stash show {1}' |
	cut -d: -f1
}

_fzf_git_tags() {
	git rev-parse HEAD &> /dev/null || return
	git tag --sort -version:refname |
	fzf -m --prompt 'Tags> ' \
		--bind 'ctrl-o:execute:nvim "+G diff "`git describe --always --abbrev=0 --tags {}~`" {}|on"' \
		--preview 'git diff --color --stat `git describe --always --abbrev=0 --tags {}~` {}'
}

_fzf_git_ups() {
	git rev-parse HEAD &> /dev/null || return
	git remote -v | awk '{print $1 "\t" $2}' | uniq |
	fzf --prompt 'Upstream> ' --tac \
		--preview 'git l --color {1}/"$(git rev-parse --abbrev-ref HEAD)"' |
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
