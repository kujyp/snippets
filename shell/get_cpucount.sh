#!/usr/bin/env bash

# Ref: https://www.ostechnix.com/find-number-cpu-cores-commandline-linux/
nproc
lscpu | grep "^CPU(s)" | awk '{ print $2 }'
grep -c processor /proc/cpuinfo # == cat /proc/cpuinfo | grep processor | wc -l
getconf _NPROCESSORS_ONLN

# 회사 장비에서는 4개의 결과가 모두 같았음.
# docker container 내부에서 테스트해보면 좋을듯.
