#!/bin/bash -e

cd ~/.config/
tar -zcf nv.tgz coc nvim
mv nv.tgz /mnt/d/Users/ahong/Downloads
cp ~/softwares/nvim-linux64.tar.gz /mnt/d/Users/ahong/Downloads
echo 'done'
