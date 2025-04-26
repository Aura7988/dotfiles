# ~/.bashrc

[[ $- != *i* ]] && return

HISTCONTROL=ignoreboth:erasedups
HISTIGNORE='pwd:cd'
HISTSIZE=3000
HISTFILESIZE=9000

shopt -s histappend
shopt -s checkwinsize
# shopt -s globstar
# shopt -s expand_aliases

stty -ixon
stty -ixoff
# stty discard undef

. ~/.prompt.sh
. ~/.fzf.bash
eval "$(lua ~/github/z.lua/z.lua --init bash enhanced once fzf)"
eval "$(dircolors -b)"
# make less more friendly for non-text input files, see lesspipe(1)
[[ -x /usr/bin/lesspipe ]] && eval "$(SHELL=/bin/sh lesspipe)"

if [[ -v SSH_AUTH_SOCK ]]; then
	. /opt/homebrew/share/bash-completion/bash_completion || :
	alias y='pbcopy'
	alias p='pbpaste'
elif [[ -v TERMUX_VERSION ]]; then
	. /data/data/com.termux/files/usr/share/bash-completion/bash_completion || :
	alias y='termux-clipboard-set'
	alias p='termux-clipboard-get'
else
	. /usr/share/bash-completion/bash_completion || :
	alias y='xsel -bi'
	alias p='xsel -bo'
fi

alias vi='nvim'
alias vl='nvim -u ~/.config/nvim/large.vim'
alias gd='git dd'
alias gs='git status'
alias gl='git l'
alias ls='ls --color=auto'
alias la='ls -A'
alias ll='ls -lh --time-style=long-iso'
alias grep='grep --color=auto'
alias g++='g++ -Wall -std=c++17'
alias gcc='gcc -Wall -std=c11'
alias ...='cd ../..'
alias ..='cd ../'
alias -- -='cd -'
alias b='z -b'
alias hh='http_proxy=http://127.0.0.1:32080 https_proxy=http://127.0.0.1:32080 '
alias rg='rg -SnHg !.git/* --hidden'
alias fd='fd --hidden --exclude .git'
alias .f='git --git-dir=$HOME/.files/ --work-tree=$HOME'
[[ -v WSL_DISTRO_NAME ]] && {
	alias wy='clip.exe'
	alias wp='powershell.exe -Command "Get-Clipboard -Raw"'
	# export DISPLAY=$(grep nameserver /etc/resolv.conf | awk '{print $2}'):0.0
	# export DISPLAY=$(route.exe print | grep 0.0.0.0 | head -1 | awk '{print $4}'):0.0
}

trap '
	history -a
	. ~/.bash_logout || :
	trap - EXIT
	exit
' EXIT

# ww() { curl wttr.in/${1:-Nanjing}; }
ww() { last | grep still | awk '{print $1}' | sort | uniq -c; }
rr() { [ $# -ge 2 ] && bat -pr $2 --color never $1; }

vv() {
	local sp=~/.cache/nvim/server.pipe
	[[ ! -S $sp ]] && nvim --listen $sp "$@" && return
	[[ $# -eq 0 ]] && return
	local rs="--remote-send '<C-\><C-N>:-tab split|lcd $PWD|"
	case "$1" in
		-d)
			[[ $# -lt 3 ]] && { echo 'Wrong arguments'; return; }
			rs+="e $2|diffthis"
			for f in "${@:3}"; do rs+="|vs $f|diffthis"; done
			rs+="<CR>'"
			;;
		-q)
			[[ $# -ne 2 ]] && { echo 'Wrong arguments'; return; }
			rs+="lfile $2<CR>'"
			;;
		-b)
			[[ $# -lt 2 ]] && { echo 'Wrong arguments'; return; }
			rs+="set binary|drop ${@:2}<CR>'"
			;;
		+*)
			rs+="${1:1}<CR>'"
			;;
		-c | --cmd)
			[[ $# -ne 2 ]] && { echo 'Wrong arguments'; return; }
			rs+="$2<CR>'"
			;;
		*)
			rs+="drop $@<CR>'"
			;;
	esac
	eval nvim --server $sp $rs
}

bb() {
	local cxx_flags=
	local generator=Ninja
	local all=OFF
	local build_dir=build
	local build_type=Release
	local jobs=55
	local linker=-B$HOME/.local/libexec/mold
	local only=0
	local prof=OFF
	local regen=0
	local source_dir=~/xxx
	local third_dir=/3rd
	OPTIND=1
	while getopts ":F:Uab:dj:l:oprs:t:" opt; do
		case $opt in
			F)
				cxx_flags="$cxx_flags $OPTARG"
				;;
			U)
				generator='Unix Makefiles'
				;;
			a)
				all=ON
				;;
			b)
				build_dir=$OPTARG
				;;
			d)
				build_type=Debug
				;;
			j)
				jobs=$OPTARG
				;;
			l)
				[[ $OPTARG == 'ld' ]] && linker='' || linker="-fuse-ld=$OPTARG"
				;;
			o)
				only=1
				;;
			p)
				prof=ON
				;;
			r)
				regen=1
				;;
			s)
				source_dir=$OPTARG
				;;
			t)
				third_dir=$OPTARG
				;;
			:)
				echo "option requires an argument"
				return 1
				;;
			?)
				echo "unrecognized option"
				return 2
				;;
		esac
	done
	shift $(($OPTIND - 1))
	echo "extra args: $@"
	[[ -d "$source_dir" && -d "$third_dir" ]] || { echo "$source_dir or $third_dir is not directory" && return 3; }
	build_dir="$source_dir/$build_dir"
	if [[ $regen -eq 1 ]]; then
		rm -rf $build_dir
		echo "$generator,$all,$build_dir,$build_type,$jobs,$linker,$only,$prof,$regen,$source_dir,$third_dir"
		cmake -G "$generator" -DCMAKE_CXX_FLAGS="$linker$cxx_flags" -DXXX_ALL=$all -DCMAKE_EXPORT_COMPILE_COMMANDS=1 -DCMAKE_BUILD_TYPE=$build_type -DXXX_THIRD_PARTY=$third_dir -DXXX_PROFILER=$prof -S $source_dir -B $build_dir "$@"
		cp $build_dir/compile_commands.json $source_dir
		[[ $only -ne 0 ]] && return 0
	fi
	cmake --build $build_dir --parallel $jobs
# set_target_properties(xxx
#     PROPERTIES
#     ARCHIVE_OUTPUT_DIRECTORY "${PROJECT_SOURCE_DIR}/lib"
#     LIBRARY_OUTPUT_DIRECTORY "${PROJECT_SOURCE_DIR}/lib"
#     RUNTIME_OUTPUT_DIRECTORY "${PROJECT_SOURCE_DIR}/bin"
#     BUILD_WITH_INSTALL_RPATH TRUE
#     LINK_FLAGS               "-Wl,--disable-new-dtags"
#     INSTALL_RPATH            "\$ORIGIN/lib/xxx/lib:\$ORIGIN/lib"
# )
}

nb() {
	local cd=0
	local debug=0
	local inplace=0
	OPTIND=1
	while getopts ":cdi" opt; do
		case $opt in
			c)
				cd=1
				;;
			d)
				debug=1
				;;
			i)
				inplace=1
				;;
			:)
				echo "option requires an argument"
				return 1
				;;
			?)
				echo "unrecognized option"
				return 2
				;;
		esac
	done
	shift $(($OPTIND - 1))
	# echo "remaining args: $@"
	local topdir=/stable-build
	local target=${topdir}/date-${1}/`(($debug))&&echo 'debug'||echo 'release'`/bin
	[[ ! -d $target ]] && ls $topdir && return
	[[ $cd -eq 1 ]] && cd $target && return
	(($inplace)) && { $target/xxx || return $?; } || { cd $target && ./xxx; }
	# if [[ $inplace -eq 0 ]]; then
	# 	cd $target; ./xxx
	# else
	# 	$target/xxx
	# fi
}
