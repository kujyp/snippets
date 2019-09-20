#!/bin/bash

#official document
#https://xcat-docs.readthedocs.io/en/stable/advanced/gpu/nvidia/verify_cuda_install.html
#Verify CUDA Installation

nvcc --version | grep "Cuda compilation" | awk '{ print $6 }'
#> V10.0.130
nvcc --version | grep "Cuda compilation" | awk '{ print $6 }' | tr -d [:alpha:]
#> 10.0.130

CUDA_VERSION_MAJOR=8
CUDA_VERSION_MINOR=0
CUDA_VERSION_PATCH=61
CUDA_VERSION=${CUDA_VERSION_MAJOR}.${CUDA_VERSION_MINOR}.${CUDA_VERSION_PATCH}

echo $CUDA_VERSION | cut -d '.' -f1 # == 8
echo $CUDA_VERSION | cut -d '.' -f2 # == 0
echo $CUDA_VERSION | cut -d '.' -f3 # == 61
echo $CUDA_VERSION | cut -d '.' -f 1,2 # == 8.0
echo $CUDA_VERSION | cut -d '.' -f 1,2,3 # ==== 8.0.61

cat /usr/local/cuda-9.0/include/cudnn.h | grep "#define CUDNN_MAJOR" -A 2 | awk '{ print $3 }' | xargs | tr ' ' '.'
cat /usr/local/cuda/include/cudnn.h | grep "#define CUDNN_MAJOR" -A 2 | awk '{ print $3 }' | xargs | tr ' ' '.'
#> 7.3.1

#Refs: https://stackoverflow.com/a/36978616
#How to verify CuDNN installation?

#https://stackoverflow.com/a/9730706
#How to get the cuda version?


# Check nccl installation
#locate nccl| grep "libnccl.so"
