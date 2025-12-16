#!/usr/bin/env bash
set -e

check-glibc lib/*.so*

mkdir -p $PREFIX/include
mv include/* $PREFIX/include/
mkdir -p $PREFIX/lib
mv lib/*.so* $PREFIX/lib/

# Build samples to verify the installation
cd $SRC_DIR/sample_linux/cuTENSOR/
error_log=$(nvcc $NVCC_FLAGS --std=c++17 -I$PREFIX/include -L$PREFIX/lib -lcutensor -lcudart contraction.cu -o contraction 2>&1)
echo $error_log
error_log=$(nvcc $NVCC_FLAGS --std=c++17 -I$PREFIX/include -L$PREFIX/lib -lcutensor -lcudart reduction.cu -o reduction 2>&1)
echo $error_log
cd $SRC_DIR/sample_linux/cuTENSORMg/
error_log=$(nvcc $NVCC_FLAGS --std=c++17 -I$PREFIX/include -L$PREFIX/lib -lcutensorMg -lcutensor -lcudart contraction_multi_gpu.cu -o contraction_multi_gpu 2>&1)
echo $error_log
