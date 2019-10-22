#!/bin/bash -e

yellow="\033[0;33m"
red="\033[0;31m"
nocolor="\033[0m"


function command_exists() {
    command -v "$@" 1> /dev/null 2>&1
}

function error_msg() {
    echo -e "${red}[ERROR] ${1-}${nocolor}"
}



if ! command_exists flake8; then
    error_msg "Install flake8 first.
pip install flake8==3.6.0"
    exit 1
fi

flake8 --exclude='venv*' --ignore=E501
