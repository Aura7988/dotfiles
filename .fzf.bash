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
	diff -x .git -x .cache -raq "$@" |
	awk -v old="${1%/}" -v new="${2%/}" '
		BEGIN {lo = length(old); ln = length(new)}
		{
			if (match($0, /^Files (.*) and .* differ$/, fa)) {
				print "M\t" substr(fa[1], lo + 2)
				next
			}
			match($0, /^Only in (.*): (.*)$/, oa)
			file = substr(oa[1], length(oa[1]), 1) == "/" ? oa[1] oa[2] : oa[1] "/" oa[2]
			if (lo > ln) {
				dir = substr(file, 1, lo)
				if (dir != old) dir = substr(file, 1, ln)
			} else {
				dir = substr(file, 1, ln)
				if (dir != new) dir = substr(file, 1, lo)
			}
			if (dir == new)
				print "\033[32mA\033[m\t" substr(file, ln + 2)
			else
				print "\033[31mD\033[m\t" substr(file, lo + 2)
		}' |
	fzf --prompt 'Diff> ' -m --ansi -d "\t" \
		--preview 'diff -Nu '"$(printf '{%q,%q}/{2}' "$1" "$2")" \
		--bind 'ctrl-o:execute:nvim -d '"$(printf '{%q,%q}/{2}' "$1" "$2")" \
		--bind 'enter:become:nvim {+f}'
}

__fzf_kill() {
	local selected=$(
		ps -fu $UID |
		fzf -m --header-lines 1 --preview 'echo {}' --preview-window up,3 \
			--bind 'enter:become:echo {+2}' \
			--bind 'alt-enter:become:kill -9 {+2} &> /dev/null'
	)
	READLINE_LINE="${READLINE_LINE:0:$READLINE_POINT}$selected${READLINE_LINE:$READLINE_POINT}"
	READLINE_POINT=$((READLINE_POINT + ${#selected}))
}

__fzf_cd() {
	fd -HE .git -td |
	fzf --scheme path --preview 'tree -C -- {}' \
		--bind 'enter:become:printf "cd -- %q" {}' \
		--bind 'alt-enter:become:printf "cd %q" "$(unset CDPATH && cd -- {} && pwd)"'
}

__fzf_history() {
	local h; h=$(
		builtin fc -lnr -2147483648 |
		awk '{sub(/^\t /, ""); if (!a[$0]++) print}' |
		fzf --scheme history --query "$READLINE_LINE"
	) || return
	READLINE_LINE=$h; READLINE_POINT=0
}

__fzf_select() {
	local selected=$(
		fd -HE .git -tf |
		fzf -m --scheme path --prompt 'Files> ' --header '╱ CTRL-G: Switch between Files/Directories ╱' \
			--bind 'ctrl-g:transform:[[ $FZF_PROMPT =~ Files ]] &&
				echo "change-prompt(Directories> )+reload(fd -HE .git -td)" ||
				echo "change-prompt(Files> )+reload(fd -HE .git -tf)"' \
			--bind 'ctrl-o:execute:nvim {}' \
			--bind 'enter:become:printf " %q" {+}' \
			--preview '[[ $FZF_PROMPT =~ Files ]] && bat -p --color=always {} || tree -C -- {}'
	)
	READLINE_LINE="${READLINE_LINE:0:$READLINE_POINT}$selected${READLINE_LINE:$READLINE_POINT}"
	READLINE_POINT=$((READLINE_POINT + ${#selected}))
}

__fbr() {
	git branch "$@" --sort=-committerdate --sort=-HEAD --color --format=$'%(HEAD) %(color:yellow)%(refname:short) %(color:green)(%(committerdate:relative))\t%(color:blue)%(subject)%(color:reset)' | column -ts$'\t' | sed 's/^..//'
}
export -f __fbr

__fzf_git_branches() {
	git rev-parse HEAD &> /dev/null || return
	__fbr |
	fzf -m --tiebreak begin --no-hscroll --ansi --prompt 'Branches> ' \
		--header '╱ ALT-R: Toggle remote branches ╱' \
		--bind 'alt-r:transform:[[ $FZF_PROMPT =~ All ]] &&
			echo "change-prompt(Branches> )+reload(__fbr)" ||
			echo "change-prompt(AllBranches> )+reload(__fbr -a)"' \
		--bind 'ctrl-o:execute:nvim "+G diff {1}|on"' \
		--bind 'alt-h:become:__fzf_git_hashes {1}' \
		--bind 'enter:become:printf " %q" {+1}' \
		--preview 'git l --color {1}'
}

__fzf_git_each_ref() {
	git rev-parse HEAD &> /dev/null || return
	git for-each-ref --sort=-creatordate --sort=-HEAD --color --format=$'%(refname) %(color:green)(%(creatordate:relative))\t%(color:blue)%(subject)%(color:reset)' |
	sed 's#^refs/remotes/#\x1b[95mremote-branch\t\x1b[33m#; s#^refs/heads/#\x1b[92mbranch\t\x1b[33m#; s#^refs/tags/#\x1b[96mtag\t\x1b[33m#; s#refs/stash#\x1b[91mstash\t\x1b[33mrefs/stash#' |
	column -ts$'\t' |
	fzf -m --ansi --nth 2,2.. --tiebreak begin --no-hscroll --prompt 'Every ref> ' \
		--bind 'ctrl-o:execute:nvim <(git show {2})' \
		--preview 'git l --color {2}' |
	awk '{print $2}'
}

__fzf_git_files() {
	git rev-parse HEAD &> /dev/null || return
	(git status -zs | sed -zrn 's/^[^RC]([^RC]) /[31m\1[m\t/p'
	git ls-files -z | grep -zvxFf <(git status -zs | sed -zrn 's/^[^?]. (.*)/\1\n/p'; echo :) | sed -z 's/^/ \t/') |
	fzf --read0 --prompt 'GFiles> ' -m --ansi -d "\t" \
		--bind 'ctrl-o:execute:nvim {2}' \
		--bind 'alt-h:become:__fzf_git_hashes -- {+2}' \
		--bind 'enter:become:printf " %q" {+2}' \
		--preview 'git diff --no-ext-diff --color -- {2} | sed 1,4d; bat --style=header --color=always {2}'
}

__fzf_git_hashes() {
	git rev-parse HEAD &> /dev/null || return
	git l --color "$@" |
	fzf -m +s --prompt 'Hashes> ' --ansi \
		--bind 'ctrl-o:execute:nvim "+G show --dd "`grep -Eo "[a-f0-9]{7,}" {f} | head -1`"|on"' \
		--preview 'git show --color --stat `grep -Eo "[a-f0-9]{7,}" {f} | head -1`' |
	sed -r 's/.* ([a-f0-9]{7,}) - .*/\1/'
}
export -f __fzf_git_hashes

__fzf_git_reflogs() {
	git rev-parse HEAD &> /dev/null || return
	git reflog --color --format='%Cblue%gD %Cred%h%Creset %gs%Cgreen%d' |
	fzf --prompt 'Reflogs> ' --ansi --preview 'git show --color {1}' |
	awk '{print $1}'
}

__fzf_git_stashes() {
	git rev-parse HEAD &> /dev/null || return
	git stash list |
	fzf -d: --prompt 'Stashes> ' --header '╱ CTRL-X: Drop selected stash entry ╱' \
		--bind 'ctrl-o:execute:nvim "+G stash show -p {1}|on"' \
		--bind 'ctrl-x:execute-silent(git stash drop {1})+reload(git stash list)' \
		--preview-window 'up,25%' --preview 'git -c color.ui=always stash show {1}' |
	cut -d: -f1
}

__fzf_git_tags() {
	git rev-parse HEAD &> /dev/null || return
	git tag --sort -version:refname |
	fzf -m --prompt 'Tags> ' \
		--bind 'ctrl-o:execute:nvim "+G diff "`git describe --always --abbrev=0 --tags {}~`" {}|on"' \
		--preview 'git diff --color --stat `git describe --always --abbrev=0 --tags {}~` {}'
}

__fzf_git_ups() {
	git rev-parse HEAD &> /dev/null || return
	git remote -v | awk '{print $1 "\t" $2}' | uniq |
	fzf --prompt 'Upstream> ' --tac \
		--preview 'git l --color {1}/"$(git rev-parse --abbrev-ref HEAD)"' |
	cut -d$'\t' -f1
}

bind -m emacs-standard '"\ea": redraw-current-line'
bind -m emacs-standard '"\ej": " \C-b\C-k \C-u`__fzf_cd`\e\C-e\ea\C-m\C-y\C-h\e \C-y\ey\C-x\C-x\C-d\C-y\ey\C-_"'
bind -m emacs-standard -x '"\C-q": __fzf_kill'
bind -m emacs-standard -x '"\C-s": __fzf_select'
bind -m emacs-standard -x '"\C-r": __fzf_history'

for o in branches each_ref files hashes reflogs stashes tags ups; do
	bind -m emacs-standard '"\C-g'${o:0:1}'": " \C-b\C-k \C-u`__fzf_git_'$o'`\e\C-e\ea\C-a\C-y\C-h\C-e\e \C-y\ey\C-x\C-x\C-d\C-y\ey\C-_"'
done
