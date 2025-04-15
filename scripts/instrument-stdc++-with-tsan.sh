#!/bin/bash -e

mkdir -p objdir && cd objdir
/path/of/gcc/configure --prefix=/path/to/install --disable-multilib --disable-bootstrap --enable-languages=c,c++ --enable-sanitize=thread
make -j99
cd x86_64-pc-linux-gnu/libstdc++-v3
make clean
make CXXFLAGS='-fsanitize=thread' LDFLAGS='-fsanitize=thread'
make install
