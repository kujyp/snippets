#!/usr/bin/env bash

usage() {
    err_msg "Usage:
$0 --port 8000 --container-name static-server --static-folder \$PWD
$0 --port 8000 --container-name static-server-pytest --static-folder /data
"
}

### Main
info_msg "[${BASH_SOURCE[0]}] executed."

if ! command_exists docker; then
    err_msg "Install docker first.\n\
[MacOS] $ brew cask install docker\n\
[Linux] $ curl -fsSL https://get.docker.com | sh"
    exit 1
fi

while true; do
    if [[ $# -eq 0 ]]; then
        break
    fi

    case $1 in
        --static-folder)
            shift

            case $1 in (-*|"") usage; exit 1; esac
            static_folder="$1"
            shift; continue
            ;;
        --port)
            shift

            case $1 in (-*|"") usage; exit 1; esac
            port="$1"
            shift; continue
            ;;
        --container-name)
            shift

            case $1 in (-*|"") usage; exit 1; esac
            container_name="$1"
            shift; continue
            ;;
    esac
    shift
done

if [[ -z ${static_folder} ]] || [[ -z ${port} ]] || [[ -z ${container_name} ]]; then
    usage
    exit 1
fi

info_msg "static_folder=[${static_folder}], port=[${port}], container_name=[${container_name}]"
(
cd_into_script_path

./build_docker.sh
args="run --rm --name ${container_name} -p ${port}:8000 -v ${static_folder}:/data mt_static_dependency"
)
info_msg "[${BASH_SOURCE[0]}] Done."
