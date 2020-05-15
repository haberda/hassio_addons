#!/usr/bin/env bash
#===============================================================================
#          FILE: emby.sh
#
#         USAGE: ./emby.sh
#
#   DESCRIPTION: Entrypoint for emby docker container
#
#       OPTIONS: ---
#  REQUIREMENTS: ---
#          BUGS: ---
#         NOTES: ---
#        AUTHOR: David Personette (dperson@gmail.com),
#  ORGANIZATION:
#       CREATED: 09/28/2014 12:11
#      REVISION: 1.0
#===============================================================================

set -o nounset                              # Treat unset variables as an error

### timezone: Set the timezone for the container
# Arguments:
#   timezone) for example EST5EDT
# Return: the correct zoneinfo file will be symlinked into place
timezone() { local timezone="${1:-EST5EDT}"
    [[ -e /usr/share/zoneinfo/$timezone ]] || {
        echo "ERROR: invalid timezone specified: $timezone" >&2
        return
    }

    if [[ -w /etc/timezone && $(cat /etc/timezone) != $timezone ]]; then
        echo "$timezone" >/etc/timezone
        ln -sf /usr/share/zoneinfo/$timezone /etc/localtime
        dpkg-reconfigure -f noninteractive tzdata >/dev/null 2>&1
    fi
}

### usage: Help
# Arguments:
#   none)
# Return: Help text
usage() { local RC="${1:-0}"
    echo "Usage: ${0##*/} [-opt] [command]
Options (fields in '[]' are optional, '<>' are required):
    -h          This help
    -t \"\"       Configure timezone
                possible arg: \"[timezone]\" - zoneinfo timezone for container

The 'command' (if provided and valid) will be run instead of emby
" >&2
    exit $RC
}

while getopts ":ht:" opt; do
    case "$opt" in
        h) usage ;;
        t) timezone "$OPTARG" ;;
        "?") echo "Unknown option: -$OPTARG"; usage 1 ;;
        ":") echo "No argument value for option: -$OPTARG"; usage 2 ;;
    esac
done
shift $(( OPTIND - 1 ))

[[ "${TZ:-""}" ]] && timezone "$TZ"
[[ "${USERID:-""}" =~ ^[0-9]+$ ]] && usermod -u $USERID -o emby
[[ "${GROUPID:-""}" =~ ^[0-9]+$ ]] && groupmod -g $GROUPID -o emby

if [[ $# -ge 1 && -x $(which $1 2>&-) ]]; then
    exec "$@"
elif [[ $# -ge 1 ]]; then
    echo "ERROR: command not found: $1"
    exit 13
elif ps -ef | egrep -v grep | grep -q start_pms; then
    echo "Service already running, please restart container to apply changes"
else
    export HOME_PATH=/usr/lib/emby-server PROGRAMDATA=/share/.config/emby
    chown emby. -Rh $PROGRAMDATA $HOME_PATH 2>&1 | grep -iv 'Read-only' || :
    su -l emby -s /bin/bash -c "export HOME_PATH=$HOME_PATH \
                PROGRAMDATA=$PROGRAMDATA LANG=C.UTF-8 LANGUAGE=C.UTF-8 \
                LC_ALL=C.UTF-8 MONO_THREADS_PER_CPU=100 \
                MONO_GC_PARAMS=nursery-size=64m; cd $HOME_PATH;
                exec mono-sgen $HOME_PATH/system/EmbyServer.exe \
                -programdata $PROGRAMDATA -ffmpeg $(which ffmpeg) \
                -ffprobe $(which ffprobe)"
fi
