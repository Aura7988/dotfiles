#
# This shell prompt config file was created by promptline.vim
#

function __promptline_cwd {
	local dir_limit="3"
	local truncation="⋯"
	local first_char
	local part_count=0
	local formatted_cwd=""
	local dir_sep="  "
	local tilde="~"

	local cwd="${PWD/#$HOME/$tilde}"

	# get first char of the path, i.e. tilde or slash
	[[ -n ${ZSH_VERSION-} ]] && first_char=$cwd[1,1] || first_char=${cwd::1}

	# remove leading tilde
	cwd="${cwd#\~}"

	while [[ "$cwd" == */* && "$cwd" != "/" ]]; do
		# pop off last part of cwd
		local part="${cwd##*/}"
		cwd="${cwd%/*}"

		formatted_cwd="$dir_sep$part$formatted_cwd"
		part_count=$((part_count+1))

		[[ $part_count -eq $dir_limit ]] && first_char="$truncation" && break
	done

	printf "%s" "$first_char$formatted_cwd"
}

function jobsnum {
	local num=`jobs -p | wc -l`
	[[ $num -gt 0 ]] || return 1
	echo -n "${num}"
}

function git_branch {
	local branch=`git symbolic-ref --short -q HEAD 2> /dev/null`
	[ $branch ] || return 1
	echo -n " ${branch}"
}

function __promptline_ps1 {
	local slice_prefix slice_empty_prefix slice_suffix is_prompt_empty=1

	# section "c" header
	slice_prefix="${c_bg}${sep}${c_fg}${c_bg}${space}"
	slice_suffix="$space${c_sep_fg}"
	slice_empty_prefix="${c_fg}${c_bg}${space}"
	[ $is_prompt_empty -eq 1 ] && slice_prefix="$slice_empty_prefix"
	# section "c" slices
	__promptline_wrapper "$(__promptline_cwd)" "$slice_prefix" "$slice_suffix" && is_prompt_empty=0

	# section "y" header
	slice_prefix="${y_bg}${sep}${y_fg}${y_bg}${space}"
	slice_suffix="$space${y_sep_fg}"
	slice_empty_prefix="${y_fg}${y_bg}${space}"
	[ $is_prompt_empty -eq 1 ] && slice_prefix="$slice_empty_prefix"
	# section "y" slices
	__promptline_wrapper "$(git_branch)" "$slice_prefix" "$slice_suffix" && is_prompt_empty=0

	# section "jobsnum" header
	slice_prefix="${warn_bg}${sep}${warn_fg}${warn_bg}${space}"
	slice_suffix="$space${warn_sep_fg}"
	slice_empty_prefix="${warn_fg}${warn_bg}${space}"
	[ $is_prompt_empty -eq 1 ] && slice_prefix="$slice_empty_prefix"
	# section "jobsnum" slices
	__promptline_wrapper "$(jobsnum)" "$slice_prefix" "$slice_suffix" && is_prompt_empty=0

	# close sections
	echo -n "${reset_bg}${sep}$reset$space"
}

function __promptline_wrapper {
	# wrap the text in $1 with $2 and $3, only if $1 is not empty
	# $2 and $3 typically contain non-content-text, like color escape codes and separators

	[[ -n "$1" ]] || return 1
	echo -n "${2}${1}${3}"
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
	PS1="$(__promptline_ps1)"
}

# PS1="\[\033[01;35m\]\w\[\033[01;32m\]\$(git-branch)\[\033[01;31m\]\$(jobsnum)\[\033[01;33m\] » \[\033[00m\]"
# PS1="\[\e[1;35m\]\w\[\e[1;33m\]\$(git-branch)\[\e[1;32m\] » \[\e[m\]"
# PS1="\[\e[38;5;250m\]\[\e[48;5;240m\] \w \[\e[38;5;240m\]\[\e[48;5;236m\]\[\e[38;5;250m\]\$(git-branch)\[\e[m\]"

if [[ ! "$PROMPT_COMMAND" == *__promptline* ]]; then
    PROMPT_COMMAND='__promptline;'$'\n'"$PROMPT_COMMAND"
fi
