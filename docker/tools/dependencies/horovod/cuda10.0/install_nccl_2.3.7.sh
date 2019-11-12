#!/bin/bash -xe


yellow="\033[0;33m"
red="\033[0;31m"
nocolor="\033[0m"

function command_exists() {
    command -v "$@" 1> /dev/null 2>&1
}

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
if ! [[ "$(id -u)" -eq "0" ]]; then
    error_msg "Execute script with root privilege.(yum install)"
    exit 1
fi

(
nccl_version=2.3.7
cuda_version=10.0

cd /tmp
wget http://mtdependency.navercorp.com/static/packages/nccl-repo-rhel7-${nccl_version}-ga-cuda${cuda_version}-1-1.x86_64.rpm
rpm -i nccl-repo-rhel7-${nccl_version}-ga-cuda${cuda_version}-1-1.x86_64.rpm

yum install -y \
  libnccl-${nccl_version}-2+cuda${cuda_version} \
  libnccl-devel-${nccl_version}-2+cuda${cuda_version} \
  libnccl-static-${nccl_version}-2+cuda${cuda_version}

rm -f nccl-repo-rhel7-${nccl_version}-ga-cuda${cuda_version}-1-1.x86_64.rpm
)
