#!/usr/bin/env bash



function echo_os_distribution() {
    if [[ $(uname) == Darwin* ]]; then
        echo macos
        return
    elif [[ $(uname) == Linux* ]]; then
        if [[ -f /etc/lsb-release || -d /etc/lsb-release.d ]]; then
            distribution=$(lsb_release -i | cut -d: -f2 | sed s/'^\t'//)
        else
            distribution=$(. /etc/os-release; echo ${NAME} | cut -f1 -d ' ')
        fi
        echo "$(echo ${distribution} | tr '[:upper:]' '[:lower:]')"
        return
    else
        echo "Unexpected OS"
    fi
}
echo_os_distribution
# whitespace check
echo "[$(echo_os_distribution)]"



# 1.
awk -F= '/^NAME/{print $2}' /etc/os-release

# 2.
if [[ $(uname) == Darwin* ]]; then
    echo MacOS
elif [[ $(uname) == Linux* ]]; then
    echo Linux
fi

# 3.
# Ref: https://askubuntu.com/a/459425
UNAME=$(uname | tr "[:upper:]" "[:lower:]")
# If Linux, try to determine specific distribution
if [ "$UNAME" == "linux" ]; then
    # If available, use LSB to identify distribution
    if [[ -f /etc/lsb-release -o -d /etc/lsb-release.d ]]; then
        export DISTRO=$(lsb_release -i | cut -d: -f2 | sed s/'^\t'//)
    # Otherwise, use release info file
    else
        export DISTRO=$(ls -d /etc/[A-Za-z]*[_-][rv]e[lr]* | grep -v "lsb" | cut -d'/' -f3 | cut -d'-' -f1 | cut -d'_' -f1)
    fi
fi
# For everything else (or if above failed), just use generic identifier
[ "$DISTRO" == "" ] && export DISTRO=$UNAME
unset UNAME

## -> docker centos:7 에서 문제발생
# ls -d /etc/[A-Za-z]*[_-][rv]e[lr]*
# 에서부터 아래 리스트만큼 나옴.
#/etc/centos-release
#/etc/centos-release-upstream
#/etc/os-release
#/etc/redhat-release
#/etc/system-release
#/etc/system-release-cpe
## 결국 결과로 아래출력됨
#centos
#centos
#os
#redhat
#system
#system

# 4.
$(. /etc/os-release; echo $NAME)


# 5.
function get_android_home() {
    local uname_out=$(uname -s)
    local osname=""
    local default_android_home=""

    case "${uname_out}" in
        Linux*)     osname=Linux
                    default_android_home=${DEFAULT_LINUX_ANDROID_HOME}
                    ;;
        Darwin*)    osname=Mac
                    default_android_home=${DEFAULT_MAC_ANDROID_HOME}
                    ;;
        *)          err_msg "Unsupported OS. [${uname_out}]"
                    exit 1
                    ;;
    esac

    warn_msg "[${osname}] OS detected."

    local local_properties_sdk_dir=$(script_path=$(get_script_path); cd ${script_path}/..; cat local.properties 2>/dev/null | grep "sdk.dir" | cut -d '=' -f2)
    if [[ ! -z "${local_properties_sdk_dir}" ]]; then
        warn_msg "[local.properties] file detected. sdk.dir=[${local_properties_sdk_dir}]"
        echo ${local_properties_sdk_dir}
    elif [[ ! -z "${ANDROID_HOME}" ]]; then
        warn_msg "ANDROID_HOME environment variable detected."
        echo ${ANDROID_HOME}
    else
        warn_msg "ANDROID_HOME environment variable not detected. Use default path [${default_android_home}]"
        echo ${default_android_home}
    fi
}
