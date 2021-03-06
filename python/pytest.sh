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



if ! command_exists pytest; then
    error_msg "Install pytest first.
pip install -r requirements-test.txt"
    exit 1
fi

PYTHONPATH='.' pytest -vs tests --junitxml test-reports/pytest_junit.xml
