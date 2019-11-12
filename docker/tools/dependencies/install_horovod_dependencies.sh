#!/bin/bash -e

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

function get_script_path() {
    local _src="${BASH_SOURCE[0]}"
    while [[ -h "${_src}" ]]; do
        local _dir="$(cd -P "$( dirname "${_src}" )" && pwd)"
        local _src="$(readlink "${_src}")"
        if [[ "${_src}" != /* ]]; then _src="$_dir/$_src"; fi
    done
    echo $(cd -P "$(dirname "$_src")" && pwd)
}

function cd_into_script_path() {
    local script_path=$(get_script_path)
    cd ${script_path}
}


function echo_cuda_version() {
    nvcc --version | grep "Cuda compilation" | awk '{ print $6 }' | tr -d [:alpha:] | cut -d '.' -f 1,2
}

function echo_nccl_version() {
    local nccl_h_path=$(echo_nccl_h_path)
    if [[ -z ${nccl_h_path} ]]; then
        return
    fi

    cat ${nccl_h_path} | grep "#define NCCL_MAJOR" -A 2 | awk '{ print $3 }' | xargs | tr ' ' '.'
}

function echo_nccl_h_path() {
    find /usr -name 'nccl.h' | head -n1
}

function echo_openmpi_version() {
    find /usr -name 'nccl.h' | head -n1
}


function install_nccl() {
    local cuda_version=$(echo_cuda_version)
    if [[ -z "${cuda_version}" ]]; then
        error_msg "Detecting cuda version failed. [$ nvcc --version] command should work"
        exit 1
    fi

    (
    cd_into_script_path
    info_msg "Install nccl [2.3.7] for cuda [${cuda_version}]..."
    if [[ ! -f horovod/cuda${cuda_version}/install_nccl_2.3.7.sh ]]; then
        error_msg "Unsupported cuda_version. [${cuda_version}]"
        exit 1
    fi

    horovod/cuda${cuda_version}/install_nccl_2.3.7.sh
    )
}

function install_openmpi() {
    info_msg "Install openmpi [3.0.0]..."
    (
    cd_into_script_path
    horovod/install_openmpi_3.0.0.sh
    )
}

function install_horovod() {
    info_msg "Install horovod [0.15.1]..."
    (
    cd_into_script_path
    horovod/install_horovod_0.15.1.sh
    )
}

function install_mpi4py() {
    info_msg "Install mpi4py [3.0.2]..."
    (
    cd_into_script_path
    horovod/install_mpi4py_3.0.2.sh
    )
}

function prompt_yn() {
    if [[ -z "${1-}" ]] || [[ -z "${2-}" ]] || [[ -z "${3-}" ]] \
            || [[ ! -z "${2#[ynYN]}" ]] || [[ ! -z "${3#[ynYN]}" ]]; then
        error_msg "Call [prompt_yn] with right arguments.
Usage:
prompt_yn <QUESTION> <DEFAULT_ANSWER> <FORCE_DEFAULT_FLAG>
prompt_yn 'Continue with root' y y
prompt_yn 'Continue with root?' y n
"
        exit 1
    fi

    local _question=${1-}
    local _default_answer=${2-}
    local _force_default_flag=${3-}

    local trimmed_question=${_question%\?}
    local full_question
    if [[ "${_default_answer}" != "${_default_answer#[yY]}" ]]; then
        full_question="${trimmed_question} (Y/n)?"
    else
        full_question="${trimmed_question} (y/N)?"
    fi

    if [[ ${_force_default_flag} == "y" ]]; then
        echo "${full_question} ${_default_answer}"
        return
    fi

    echo -n "${full_question} "
    read answer

    if [[ "$answer" != "${answer#[yY]}" ]]; then
        true
        return
    else
        false
        return
    fi
}

function usage() {
    info_msg "Usage:
$0
$0 --yes
$0 -y
"
}


# Main
info_msg "[$0] executed..."
usage

yes_flag=n
while true; do
    if [[ $# -eq 0 ]]; then
        break
    fi

    case $1 in
        --yes)
            yes_flag=y
            shift; continue
            ;;
        -y)
            yes_flag=y
            shift; continue
            ;;
    esac
    shift
done

# Check
if [[ "$(id -u)" -eq "0" ]]; then
    info_msg "Root privilege detected."
else
    info_msg "Non-root privilege detected."
fi

nccl_version=$(echo_nccl_version)
if [[ -z "${nccl_version}" ]]; then
    info_msg "[x] Installed nccl not detected."
else
    info_msg "[o] Installed nccl detected. [${nccl_version}] - [$(echo_nccl_h_path)]"
fi

if ! command_exists mpiexec; then
    info_msg "[x] Installed openmpi not detected. [$ command -v mpiexec]"
else
    info_msg "[o] Installed openmpi detected. [$(command -v mpiexec)]"
fi

if ! command_exists pip || [[ -z "$(pip freeze 2>/dev/null | grep horovod)" ]]; then
    info_msg "[x] Installed horovod not detected. [$ pip freeze | grep horovod]"
else
    info_msg "[o] Installed horovod detected."
fi

if ! command_exists pip || [[ -z "$(pip freeze 2>/dev/null | grep mpi4py)" ]]; then
    info_msg "[x] Installed mpi4py not detected. [$ pip freeze | grep mpi4py]"
else
    info_msg "[o] Installed mpi4py detected."
fi

if ! command_exists pip; then
    warning_msg "This scripts requires [pip]."
fi
if [[ -z "$(pip freeze 2>/dev/null | grep tensorflow)" ]]; then
    warning_msg "This script requires [tensorflow]. Install tensorflow manually."
fi

# nccl
if [[ -z "${nccl_version}" ]]; then
    if ! [[ "$(id -u)" -eq "0" ]]; then
        error_msg "Run with root privilege to install nccl."
        exit 1
    fi

    install_nccl
fi

# openmpi
if ! command_exists mpiexec; then
    if [[ "$(id -u)" -eq "0" ]]; then
        if ! prompt_yn "Continue with root?" y ${yes_flag}; then
            error_msg "Re-try with non-root user."
            exit 1
        fi
    fi

    install_openmpi
fi

# horovod, mpi4py
if ! command_exists pip; then
    error_msg "Install pip first."
    exit 1
fi

if [[ -z "$(pip freeze 2>/dev/null | grep horovod)" ]] || [[ -z "$(pip freeze 2>/dev/null | grep mpi4py)" ]]; then
    if ! prompt_yn "Continue with pip [$(command -v pip)]?" y ${yes_flag}; then
        error_msg "Re-try with another python environment.
Python environment example:
python3 -m venv venv_py3; source venv_py3/bin/activate
"
        exit 1
    fi

    if [[ -z "$(pip freeze 2>/dev/null | grep horovod)" ]]; then
        install_horovod
    fi
    if [[ -z "$(pip freeze 2>/dev/null | grep mpi4py)" ]]; then
        install_mpi4py
    fi
fi

info_msg "[$0] executed... done."
