#!/usr/bin/env zsh

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
        wg-generate
        wg-start
    else
        wg-stop
    fi
}

case "$1" in
    --status)
        if pgrep -u $UID -x wgcf > /dev/null; then
            echo "Starting..."
        else
            show_status
        fi
        ;;
    *)
        wg-toggle
        ;;
esac
