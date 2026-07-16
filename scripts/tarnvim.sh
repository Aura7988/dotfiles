#!/bin/bash -e

cd ~/softwares
curl -OL https://github.com/neovim/neovim/releases/download/nightly/nvim-linux-x86_64.tar.gz
cp nvim-linux-x86_64.tar.gz /mnt/d/Users/ahong/Downloads

cd ~/.config/
tar -zcf nv.tgz coc nvim
mv nv.tgz /mnt/d/Users/ahong/Downloads
echo 'done'
