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

function usage() {
    info_msg "Usage:
$0 --local-tag mttrain --push-tag registry.navercorp.com/mtengine/mttrain
$0 --local-tag mttrain:master-x1x1x1x1 --push-tag registry.navercorp.com/mtengine/mttrain:master-x1x1x1x1
$0 --local-tag mttrain:cuda10.0 --push-tag registry.navercorp.com/mtengine/mttrain:cuda10.0_latest
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
        --local-tag)
            shift

            case $1 in (-*|"") usage; exit 1; esac
            local_tag="$1"
            shift; continue
            ;;
        # Not required
        --push-tag)
            shift

            case $1 in (-*|"") usage; exit 1; esac
            push_tag="$1"
            shift; continue
            ;;
    esac
    shift
done

if [[ -z ${local_tag} ]] || [[ -z ${push_tag} ]]; then
    usage
    exit 1
fi


info_msg "local_tag=[${local_tag}], push_tag=[${push_tag}]"

set +x
docker tag ${local_tag} ${push_tag}
docker push ${push_tag}

info_msg "[$0] executed...done"
