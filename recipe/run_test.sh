#!/bin/bash
set -ex

test -f $PREFIX/include/cutensor.h
test -f $PREFIX/include/cutensorMg.h
test -f $PREFIX/include/cutensor/types.h
test -f $PREFIX/include/cutensorMp.h
test -f $PREFIX/include/cutensorMp/types.h
test -f $PREFIX/lib/libcutensor.so
test -f $PREFIX/lib/libcutensorMg.so
test -f $PREFIX/lib/libcutensorMp.so
# Anaconda: the redist ships static archives too; only the shared libraries are packaged
test ! -f $PREFIX/lib/libcutensor_static.a
test ! -f $PREFIX/lib/libcutensorMg_static.a
test ! -f $PREFIX/lib/libcutensorMp_static.a

${GCC} test_load_elf.c -std=c99 -Werror -ldl -o test_load_elf
# need to load the stub for CUDA 12 and 13
export CUDA_STUB="$PREFIX/lib/stubs/libcuda.so"

LD_PRELOAD="$CUDA_STUB" ./test_load_elf $PREFIX/lib/libcutensor.so
LD_PRELOAD="$CUDA_STUB" ./test_load_elf $PREFIX/lib/libcutensorMg.so
LD_PRELOAD="$CUDA_STUB" ./test_load_elf $PREFIX/lib/libcutensorMp.so

NVCC_FLAGS=""

# Anaconda: samples come from the recipe source (pinned git_rev) instead of a test-time git clone
cd sample_linux/cuTENSOR/
nvcc $NVCC_FLAGS --std=c++17 -I$PREFIX/include -L$PREFIX/lib -lcutensor -lcudart contraction.cu -o contraction
nvcc $NVCC_FLAGS --std=c++17 -I$PREFIX/include -L$PREFIX/lib -lcutensor -lcudart reduction.cu -o reduction
cd ../cuTENSORMg/
nvcc $NVCC_FLAGS --std=c++17 -I$PREFIX/include -L$PREFIX/lib -lcutensorMg -lcutensor -lcudart contraction_multi_gpu.cu -o contraction_multi_gpu
cd ../cuTENSORMp/
nvcc $NVCC_FLAGS --std=c++17 -I$PREFIX/include cutensorMp_contraction.cu -L$PREFIX/lib -lcutensorMp -lcutensor -lnccl -lmpi -lcudart -o cutensorMp_contraction
