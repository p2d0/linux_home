#!/usr/bin/env bash

is_off(){
    status=$(wg show 2>&1);
    if [ -z  "$status" ]; then
        return 0;
    fi
    return 1;
}

show_status(){
    if is_off; then
        echo " OFF"
    else
        echo " ON"
    fi
}

wg-toggle(){
    if is_off; then
        wgcf update
        wg-quick up ~/.config/polybar/wgcf-profile.conf
    else
        wg-quick down ~/.config/polybar/wgcf-profile.conf
    fi
}

case "$1" in
    --status)
        show_status
        ;;
    *)
        wg-toggle
        ;;
esac
