#!/usr/bin/env bash

# doesn't work
#echo -e "abcdefg\b"
#bs=$(tput kbs)
#echo -e "abcdef${bs}"

yellow="\033[0;33m"
red="\033[0;31m"
nocolor="\033[0m"


info_msg() {
    echo -e "${yellow}[INFO] $@${nocolor}"
}

err_msg() {
    echo -e "${red}[ERROR] $@${nocolor}" >&2
}

info_msg "docker ${args}"
docker ${args}
