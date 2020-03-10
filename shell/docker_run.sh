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

function err_msg() {
    echo -e "${red}[ERROR] ${1-}${nocolor}"
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
    err_msg "Usage:
$0 --nginx-conf-path tools/nginx/develop/nginx.conf
$0 --nginx-conf-path tools/nginx/stage/nginx.conf --port 3000
$0 --nginx-conf-path tools/nginx/prod/nginx.conf --port 80
"
}


# Main
while true; do
    if [[ $# -eq 0 ]]; then
        break
    fi

    case $1 in
        --nginx-conf-path)
            shift

            case $1 in (-*|"") usage; exit 1; esac
            nginx_conf_path="$1"
            shift; continue
            ;;
        --port)
            shift

            case $1 in (-*|"") usage; exit 1; esac
            port="$1"
            shift; continue
            ;;
    esac
    shift
done

if [[ -z ${nginx_conf_path} ]]; then
    usage
    exit 1
fi

if [[ "tools/nginx/develop/nginx.conf" != "$nginx_conf_path" ]] && [[ -z ${port} ]]; then
    info_msg "Using default port=[${port}]..."
    port=80
fi
info_msg "nginx_conf_path=[${nginx_conf_path}], port=[${port}]"

(
cd_into_script_path
cd ../..

tools/docker/docker_build.sh --nginx-conf-path "$nginx_conf_path"

docker_args="run -it"
if [[ "tools/nginx/develop/nginx.conf" == "$nginx_conf_path" ]]; then
    docker_args="$docker_args --net=host"
else
    docker_args="$docker_args -p ${port}:80"
fi
docker_args="${docker_args} --rm --name musicanote_annotation_web musicanote_annotation_web"
info_msg "[$ docker $docker_args]..."
docker ${docker_args}
)
