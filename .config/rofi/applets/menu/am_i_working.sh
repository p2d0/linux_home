#!/usr/bin/env bash
SCRIPT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )"
text="$1"

confirm_exit() {
	rofi -dmenu\
		-i\
		-no-fixed-num-lines\
		-p "$text"\
		-theme $HOME/.config/rofi/applets/styles/message.rasi
}

available_answers_message() {
	rofi -theme "$HOME/.config/rofi/applets/styles/message.rasi" -e "Available Options  -  yes / y / no / n"
}


ans=$(confirm_exit &)

if [[ $ans == "no" || $ans == "NO" || $ans == "n" || $ans == "N" ]]; then
	kill -9 -1
	if [[ "$DESKTOP_SESSION" == "Openbox" ]]; then
		openbox --exit
	elif [[ "$DESKTOP_SESSION" == "bspwm" ]]; then
		bspc quit
	elif [[ "$DESKTOP_SESSION" == "i3" ]]; then
		i3-msg exit
	fi
elif [[ $ans == "yes" || $ans == "YES" || $ans == "y" || $ans == "Y" ]]; then
	exit 0
else
	available_answers_message
    $SCRIPT_DIR/am_i_working.sh
fi
