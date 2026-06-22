#!/bin/bash
set -ex

test -f $PREFIX/include/cutensor.h
test -f $PREFIX/include/cutensorMg.h
test -f $PREFIX/include/cutensor/types.h
test -f $PREFIX/lib/libcutensor.so
test -f $PREFIX/lib/libcutensorMg.so

${GCC} test_load_elf.c -std=c99 -Werror -ldl -o test_load_elf
# need to load the stub for CUDA 12 and 13
export CUDA_STUB="$PREFIX/lib/stubs/libcuda.so"

LD_PRELOAD="$CUDA_STUB" ./test_load_elf $PREFIX/lib/libcutensor.so
LD_PRELOAD="$CUDA_STUB" ./test_load_elf $PREFIX/lib/libcutensorMg.so

NVCC_FLAGS=""

cd sample_linux/cuTENSOR/
nvcc $NVCC_FLAGS --std=c++17 -I$PREFIX/include -L$PREFIX/lib -lcutensor -lcudart contraction.cu -o contraction
nvcc $NVCC_FLAGS --std=c++17 -I$PREFIX/include -L$PREFIX/lib -lcutensor -lcudart reduction.cu -o reduction
cd ../cuTENSORMg/
nvcc $NVCC_FLAGS --std=c++17 -I$PREFIX/include -L$PREFIX/lib -lcutensorMg -lcutensor -lcudart contraction_multi_gpu.cu -o contraction_multi_gpu
