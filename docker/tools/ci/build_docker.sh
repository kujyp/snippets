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

function usage() {
    info_msg "Usage:
$0 --tag mttrain
$0 --tag mttrain:master-x1x1x1x1
$0 --tag mttrain --dockerfile Dockerfile.cuda10.0
"
}


# Main
info_msg "[$0] executed..."

while true; do
    if [[ $# -eq 0 ]]; then
        break
    fi

    case $1 in
        # Required
        --tag)
            shift

            case $1 in (-*|"") usage; exit 1; esac
            tag="$1"
            shift; continue
            ;;
        # Not required
        --dockerfile)
            shift

            case $1 in (-*|"") usage; exit 1; esac
            dockerfile="$1"
            shift; continue
            ;;
        # Not required
        --tensorflow-version)
            shift

            case $1 in (-*|"") usage; exit 1; esac
            tensorflow_version="$1"
            shift; continue
            ;;
    esac
    shift
done

if [[ -z ${tag} ]]; then
    usage
    exit 1
fi

info_msg "tag=[${tag}], dockerfile=[${dockerfile}], tensorflow_version=[${tensorflow_version}]"

(
cd_into_script_path
cd ../..

build_args="-t ${tag}"
if ! [[ -z "${dockerfile}" ]]; then
    build_args="${build_args} -f ${dockerfile}"
fi

if ! [[ -z "${tensorflow_version}" ]]; then
    build_args="${build_args} --build-arg TENSORFLOW_VERSION=${tensorflow_version}"
fi

build_args="${build_args} ."

info_msg "[$ docker build ${build_args}]"
docker build ${build_args}
)

info_msg "[$0] executed...done"
