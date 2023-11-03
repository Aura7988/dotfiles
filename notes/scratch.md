# WSL

## Xming

http://www.straightrunning.com/XmingNotes/

## Tools

sudo apt install cmake tree xsel universal-ctags
sudo apt install pkg-config autotools-dev automake
sudo apt install libdbus-1-dev libssl-dev bison flex
sudo apt install libglib2.0-dev

## rust

https://www.rust-lang.org/learn/get-started
	wget https://sh.rustup.rs

https://github.com/rust-lang/rust-analyzer
	cargo xtask install --server
	rustup component add rust-src rust-analyzer

## C++

sudo apt install build-essential
sudo apt install gdb

https://github.com/llvm/llvm-project

https://github.com/rui314/mold

## greenclip

https://github.com/erebe/greenclip
	wget https://github.com/erebe/greenclip/releases/download/v4.2/greenclip

## fzf

https://github.com/junegunn/fzf

## bat

https://github.com/sharkdp/bat
	sudo apt install ./bat-musl_0.23.0_amd64.deb

## fd

https://github.com/sharkdp/fd
	sudo apt install ./fd-musl_8.7.0_amd64.deb

## rg

https://github.com/BurntSushi/ripgrep
	sudo apt install ./ripgrep_13.0.0_amd64.deb

## nnn

https://github.com/jarun/nnn
	make O_NERD=1 or download nerd_static

## scc

https://github.com/boyter/scc

## jq

https://github.com/jqlang/jq

## patchelf

https://github.com/NixOS/patchelf

## lua

sudo apt install lua5.4

https://github.com/skywind3000/z.lua

## Python3

sudo apt install python3 python3-pip

pip3 config set global.index-url https://pypi.tuna.tsinghua.edu.cn/simple

pip3 completion --bash >> ~/.profile

pip3 list --outdated | awk 'NR > 2 {print $1}' | xargs -L1 pip3 install --upgrade

## node

https://nodejs.org/en/download

## neovim

https://github.com/neovim/neovim
	pip3 install --user --upgrade pynvim
	npm install -g neovim

https://github.com/neoclide/coc.nvim
	CocInstall coc-explorer coc-json coc-tsserver coc-snippets coc-clangd coc-rust-analyzer
	https://github.com/neoclide/coc.nvim/issues/118
	cd ~/.config/coc/extensions && npm i coc-explorer coc-json coc-tsserver coc-snippets coc-clangd coc-rust-analyzer

## nerd-fonts

https://github.com/ryanoasis/nerd-fonts/tree/master/patched-fonts/Hack
	curl -OL https://github.com/ryanoasis/nerd-fonts/releases/latest/download/Hack.tar.xz

## dotfiles

https://github.com/Aura7988/dotfiles

