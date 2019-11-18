#!/usr/bin/env bash

# q: linux get home path
# Get home directory by username
# Ref: https://superuser.com/a/484280
eval echo ~
#> /home/irteam/users/jaeyoung
eval echo ~$USER
#> /home1/irteam

eval echo ~$(whoami)
# -> docker centos 이미지에서 root 계정으로 시도했더니 $USER 가 비어있었음.
# $(whoami) 로 대체
# https://unix.stackexchange.com/a/76356
# -> login 을 해야 USER 란이 채워지는듯함.

