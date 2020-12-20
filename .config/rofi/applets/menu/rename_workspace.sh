#!/usr/bin/env bash
style="$($HOME/.config/rofi/applets/menu/style.sh)"

dir="$HOME/.config/rofi/applets/menu/configs/$style"
rofi_command="rofi -theme $dir/rename_workspace.rasi"

options="\n\n\n"

choice="$(echo -e "$options" | $rofi_command -p "Icons" -dmenu -selected-row 0)"

if [ ! -z $choice ]; then
    i3-msg 'rename workspace to "'$("$HOME/.config/i3/get_workspace_number.sh")': '$choice'"'
fi
