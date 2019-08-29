#!/usr/bin/env bash

CUDA_VERSION_MAJOR=8
CUDA_VERSION_MINOR=0
CUDA_VERSION_PATCH=61
CUDA_VERSION=${CUDA_VERSION_MAJOR}.${CUDA_VERSION_MINOR}.${CUDA_VERSION_PATCH}

echo $CUDA_VERSION | cut -d '.' -f1 # == 8
echo $CUDA_VERSION | cut -d '.' -f2 # == 0
echo $CUDA_VERSION | cut -d '.' -f3 # == 61
echo $CUDA_VERSION | cut -d '.' -f 1,2 # == 8.0
echo $CUDA_VERSION | cut -d '.' -f 1,2,3 # ==== 8.0.61
