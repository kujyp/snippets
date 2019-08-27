yellow="\033[0;33m"
red="\033[0;31m"
nocolor="\033[0m"

function info_msg() {
    echo -e "${yellow}[INFO] $@${nocolor}"
}

function err_msg() {
    echo -e "${red}[ERROR] $@${nocolor}" >&2
}

info_msg "[${BASH_SOURCE[0]}] ..."
info_msg "[${BASH_SOURCE[0]}] done."

get_script_path() {
    local _src="${BASH_SOURCE[0]}"
    while [[ -h "${_src}" ]]; do
        local _dir="$(cd -P "$( dirname "${_src}" )" && pwd)"
        local _src="$(readlink "${_src}")"
        if [[ "${_src}" != /* ]]; then _src="$_dir/$_src"; fi
    done
    echo $(cd -P "$(dirname "$_src")" && pwd)
}

cd_into_script_path() {
    local script_path=$(get_script_path)
    cd ${script_path}
}

command_exists() {
    command -v "$@" > /dev/null 2>&1
}

