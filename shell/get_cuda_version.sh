#!/bin/bash

#official document
#https://xcat-docs.readthedocs.io/en/stable/advanced/gpu/nvidia/verify_cuda_install.html
#Verify CUDA Installation

nvcc --version | grep "Cuda compilation" | awk '{ print $6 }'
#> V10.0.130
nvcc --version | grep "Cuda compilation" | awk '{ print $6 }' | tr -d [:alpha:]
#> 10.0.130

cat /usr/local/cuda-9.0/include/cudnn.h | grep "#define CUDNN_MAJOR" -A 2 | awk '{ print $3 }' | xargs | tr ' ' '.'
cat /usr/local/cuda/include/cudnn.h | grep "#define CUDNN_MAJOR" -A 2 | awk '{ print $3 }' | xargs | tr ' ' '.'
#> 7.3.1

#Refs: https://stackoverflow.com/a/36978616
#How to verify CuDNN installation?

#https://stackoverflow.com/a/9730706
#How to get the cuda version?
