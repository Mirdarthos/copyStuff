#! /usr/bin/bash

# See README.md for what this is about. I'm not going to duplicate it.

if [ ! -f "$HOME/.config/copyStuff.conf" ];
then
    printf "Configuration file not found. Please create a configuration file.\n"
    return 1
fi

cps() {
    # If arguments are given, prepare some of the functionality
    if [[ $# -gt 0 ]];
    then
        while [[ $# -gt 0 ]]; do
            case $1 in
                --help|-h)
                    CONF_EXISTS=❌
                    CONF_EXISTS_BOOL=0
                    if [ -f "$HOME/.config/copyStuff.conf" ];
                    then
                        CONF_EXISTS=✅
                        CONF_EXISTS_BOOL=1
                    fi
                    if [ "${CONF_EXISTS_BOOL}" -eq "1" ];
                    then
                        printf "%c Configuration file found at $HOME/.config/copyStuff.conf. \n" "${CONF_EXISTS}"
                    elif [ "${CONF_EXISTS_BOOL}" -eq "0" ];
                    then
                        printf "%s Configuration file not found at $HOME/.config/copyStuff.conf \n" "${CONF_EXISTS}"
                        return 4
                    fi
                return 0
                ;;
                *)
                    break
                ;;
            esac
        done
    fi
    
    COPYCMD="awk '/^${1}=\"/{flag=1} flag; /.*\"$/{flag=0}\'  $HOME/.config/copyStuff.conf | sed -e 's/${1}=\"//g' -e 's/\"//g'"
    TOCOPY=$(eval "${COPYCMD}")

    if [[ -n ${TOCOPY+x} ]];
    then
        if [ "${XDG_SESSION_TYPE}" = "wayland" ];
        then
            if wl-copy "${TOCOPY}";
            then
                if notify-send --icon=checkmark --app-name="copyStuff" "Successfully copied content" "defined for <b><code>${1}</code></b>." --expire-time=2000;
                then
                    return 0
                else
                    return 4
                fi
            fi
        else
            if xclip -selection clipboard <<< "${TOCOPY}";
            then
                if notify-send --icon=checkmark --app-name="copyStuff" "Successfully copied content" "defined for <b><code>${1}</code></b>." --expire-time=2000;
                then
                    return 0
                else
                    return 4
                fi
            fi
        fi
    fi
}

# Check if the function exists (bash specific)
if declare -f "${1}" > /dev/null
then
    # call arguments verbatim
    "${@}"
fi
