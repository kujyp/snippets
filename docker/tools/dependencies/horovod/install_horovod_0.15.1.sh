#!/bin/bash -e


yellow="\033[0;33m"
red="\033[0;31m"
nocolor="\033[0m"

function error_msg() {
    echo -e "${red}[ERROR] ${1-}${nocolor}"
}


# Main
if [[ -z "$(pip freeze 2>/dev/null | grep tensorflow)" ]]; then
    error_msg "Install tensorflow first"
    exit 1
fi

set +x
HOROVOD_GPU_ALLREDUCE=NCCL pip install horovod==0.15.1
