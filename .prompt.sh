# This shell prompt config file was created by promptline.vim

function __promptline_cwd {
	local max=$(($COLUMNS * 3 / 5))
	local cwd="${PWD/#$HOME/\~}"
	[[ ${#cwd} -le $max ]] && { ps1="${1}$cwd${2}"; return; }
	local sub="${cwd: -max}"
	cwd="${sub#*/}"
	[[ "$cwd" == "$sub" ]] && ps1="${1}∞${2}" || ps1="${1}⋯/$cwd${2}"
}

function jobsnum {
	local num=`jobs -p | wc -l`
	[[ $num -gt 0 ]] || return 1
	ps1="$ps1${1}${num}${2}"
}

function git_branch {
	local sha=`git rev-parse --short HEAD 2> /dev/null`
	[ $sha ] || return 1
	local branch=`git symbolic-ref --short -q HEAD || git describe --tags --exact-match HEAD 2> /dev/null`
	[[ -n "$branch" && ${#branch} -le 17 ]] || branch=$sha
	ps1="$ps1${1} ${branch}${2}"
}

function __promptline {
	local sep=''
	local space=" "
	local reset='\[\e[0m\]'
	local reset_bg='\[\e[49m\]'
	local c_fg='\[\e[38;5;250m\]'
	local c_bg='\[\e[48;5;240m\]'
	local c_sep_fg='\[\e[38;5;240m\]'
	local warn_fg='\[\e[38;5;231m\]'
	local warn_bg='\[\e[48;5;52m\]'
	local warn_sep_fg='\[\e[38;5;52m\]'
	local y_fg='\[\e[38;5;250m\]'
	local y_bg='\[\e[48;5;236m\]'
	local y_sep_fg='\[\e[38;5;236m\]'
	local ps1 slice_prefix slice_empty_prefix slice_suffix is_prompt_empty=1

	slice_prefix="${c_bg}${sep}${c_fg}${c_bg}${space}"
	slice_suffix="$space${c_sep_fg}"
	slice_empty_prefix="${c_fg}${c_bg}${space}"
	[ $is_prompt_empty -eq 1 ] && slice_prefix="$slice_empty_prefix"
	__promptline_cwd "$slice_prefix" "$slice_suffix" && is_prompt_empty=0

	slice_prefix="${y_bg}${sep}${y_fg}${y_bg}${space}"
	slice_suffix="$space${y_sep_fg}"
	slice_empty_prefix="${y_fg}${y_bg}${space}"
	[ $is_prompt_empty -eq 1 ] && slice_prefix="$slice_empty_prefix"
	git_branch "$slice_prefix" "$slice_suffix" && is_prompt_empty=0

	slice_prefix="${warn_bg}${sep}${warn_fg}${warn_bg}${space}"
	slice_suffix="$space${warn_sep_fg}"
	slice_empty_prefix="${warn_fg}${warn_bg}${space}"
	[ $is_prompt_empty -eq 1 ] && slice_prefix="$slice_empty_prefix"
	jobsnum "$slice_prefix" "$slice_suffix" && is_prompt_empty=0

	PS1="$ps1${reset_bg}${sep}$reset$space"
}

[[ "$PROMPT_COMMAND" != *__promptline* ]] && PROMPT_COMMAND='__promptline;'$'\n'"$PROMPT_COMMAND"
