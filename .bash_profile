# ~/.bash_profile

export LANG=en_US.UTF-8
export BAT_THEME=GitHub
# export C_INCLUDE_PATH=$HOME/.local/include
# export CPLUS_INCLUDE_PATH=$HOME/.local/include
# export LIBRARY_PATH=$HOME/.local/lib
# export LD_LIBRARY_PATH=$HOME/.local/lib
[[ -d /opt/homebrew ]] && HOMEBREW_PREFIX=/opt/homebrew || { [[ -d /home/linuxbrew/.linuxbrew ]] && HOMEBREW_PREFIX=/home/linuxbrew/.linuxbrew; }
[[ -v HOMEBREW_PREFIX ]] && { PATH=$HOMEBREW_PREFIX/bin:$HOMEBREW_PREFIX/sbin:$PATH; MANPATH=$HOMEBREW_PREFIX/share/man:$MANPATH; }
export MANPATH=$HOME/.local/share/man:$MANPATH
export PATH=$HOME/.local/bin:$HOME/.cargo/bin:$PATH
export EDITOR=nvim
export MANPAGER='nvim +Man!'
export FZF_DEFAULT_COMMAND='fd --hidden --exclude .git'
export FZF_DEFAULT_OPTS='--bind ctrl-/:toggle-preview,ctrl-l:clear-multi,ctrl-c:toggle-sort,ctrl-n:half-page-down+offset-middle,ctrl-p:half-page-up+offset-middle,ctrl-q:jump,alt-a:toggle-all,alt-j:preview-page-down,alt-k:preview-page-up,alt-w:toggle-preview-wrap,alt-r:toggle-raw --cycle --reverse --info inline --no-separator --header-border line --tabstop 2 -0 --marker • --color light,fg+:dim,hl:#6B98DE:reverse,hl+:#6B98DE:reverse --preview-window border-left,right,75%,wrap,hidden'

. ~/.bashrc
. ~/.orbstack/shell/init.bash 2>/dev/null || :
