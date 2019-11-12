#!/bin/bash


yellow="\033[0;33m"
red="\033[0;31m"
nocolor="\033[0m"

function info_msg() {
    echo -e "${yellow}[INFO] ${1-}${nocolor}"
}

function error_msg() {
    echo -e "${red}[ERROR] ${1-}${nocolor}"
}

function warning_msg() {
    echo -e "${red}[WARNING] ${1-}${nocolor}"
}


# Main
info_msg "[$0] executed."

info_msg "[$ python mttrain/main.py --help]..."
python mttrain/main.py --help 2>/dev/null
echo ""
info_msg "Usages:
docker run -it \\
    -v <SAVE_PATH_ON_HOST>:<SAVE_PATH_ON_DOCKER> \\
    -v <CORPUS_PATH_ON_HOST>:<CORPUS_PATH_ON_DOCKER> \\
    -v <CONFIG_PATH_ON_HOST>:<CONFIG_PATH_ON_DOCKER> \\
    registry.navercorp.com/mtengine/mttrain:<TAG> \\
        python mttrain/main.py <MTTRAIN_PARAMETERS>
"
