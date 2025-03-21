#!/bin/bash

cd ~/softwares

# oldfile=nvim$(date +%Y%m%d%H%M%S).tgz
oldfile=oldnvim.tgz

trap "mv $oldfile nvim-linux64.tar.gz; exit 1" SIGINT

mv nvim-linux64.tar.gz $oldfile
curl -OL https://github.com/neovim/neovim/releases/download/nightly/nvim-linux64.tar.gz || { mv $oldfile nvim-linux64.tar.gz; exit 1; }

oldmd5=`md5sum $oldfile | cut -c-32`
newmd5=`md5sum nvim-linux64.tar.gz | cut -c-32`

# echo $oldmd5
# echo $newmd5
if [[ "$oldmd5" != "$newmd5" ]]; then
	# fuser ~/.local/bin/nvim &> /dev/null && echo 'nvim busy' && exit
	# pgrep nvim && echo 'nvim busy' && exit
	tar -xf nvim-linux64.tar.gz
	cd nvim-linux64
	# patchelf --set-rpath ~/.local/glibc236/lib bin/nvim
	# patchelf --set-interpreter ~/.local/glibc236/lib/ld-linux-x86-64.so.2 bin/nvim
	rm -rf ~/.local/share/nvim ~/.local/lib/nvim
	until cp -r * ~/.local; do
		echo 'nvim busy'
		sleep 1
	done
	rm -rf ../nvim-linux64
	echo 'new version installed'
fi
