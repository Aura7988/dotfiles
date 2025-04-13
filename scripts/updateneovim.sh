#!/bin/bash -e

cd ~/softwares

# oldfile=nvim$(date +%Y%m%d%H%M%S).tgz
oldfile=oldnvim.tgz
[[ $# -eq 0 ]] && newfile=nvim-macos-arm64.tar.gz || newfile=nvim-linux-x86_64.tar.gz

trap "mv $oldfile $newfile; exit 1" SIGINT
[[ -f $newfile ]] && mv $newfile $oldfile
curl -OL https://github.com/neovim/neovim/releases/download/nightly/$newfile || { mv $oldfile $newfile; exit 1; }

oldmd5=`md5sum $oldfile | cut -c-32`
newmd5=`md5sum $newfile | cut -c-32`
[[ "$oldmd5" == "$newmd5" ]] && { echo 'no updates'; exit; }

# fuser ~/.local/bin/nvim &> /dev/null && echo 'nvim busy' && exit
# pgrep nvim && echo 'nvim busy' && exit
tar -xf $newfile
dir=${newfile%%.*}
# patchelf --set-rpath ~/.local/glibc236/lib bin/nvim
# patchelf --set-interpreter ~/.local/glibc236/lib/ld-linux-x86-64.so.2 bin/nvim
rm -rf ~/.local/share/nvim ~/.local/lib/nvim
until cp -r $dir/* ~/.local; do
	echo 'nvim busy'
	sleep 1
done
rm -rf $dir
echo 'new version installed'
