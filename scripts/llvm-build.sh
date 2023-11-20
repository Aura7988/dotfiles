#!/bin/bash -e

# cmake -S llvm -B build -DCMAKE_INSTALL_PREFIX=$HOME/ts -DCMAKE_BUILD_TYPE=Release -DLLVM_ENABLE_PROJECTS="clang;clang-tools-extra;flang;libc;libclc;lld;lldb;mlir;openmp;polly;pstl" -DLLVM_ENABLE_RUNTIMES="libcxx;libcxxabi;libunwind;compiler-rt"

echo "CONFIGURING ..."
cmake -S llvm -B build -DCMAKE_INSTALL_PREFIX=$HOME/.local -DCMAKE_BUILD_TYPE=Release -DLLVM_ENABLE_PROJECTS="clang;clang-tools-extra;lld;lldb;openmp" -DLLVM_ENABLE_RUNTIMES="compiler-rt;libcxx;libcxxabi;libunwind" -DCMAKE_EXPORT_COMPILE_COMMANDS=1
# cmake -G "Ninja" -S llvm -B build -DCMAKE_C_COMPILER=$HOME/.local/bin/clang -DCMAKE_CXX_COMPILER=$HOME/.local/bin/clang++ -DLLVM_USE_LINKER=lld -DCMAKE_INSTALL_PREFIX=$HOME/.local -DCMAKE_BUILD_TYPE=Release -DLLVM_ENABLE_PROJECTS="clang;clang-tools-extra;lld;lldb;openmp" -DLLVM_ENABLE_RUNTIMES="compiler-rt;libcxx;libcxxabi;libunwind" -DCMAKE_EXPORT_COMPILE_COMMANDS=1
cp build/compile_commands.json .

echo "BUILDING ..."
cmake --build build --parallel 55

echo "INSTALLING ..."
cmake --install build
