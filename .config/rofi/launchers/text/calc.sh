#!/usr/bin/env bash


theme="style_1"

dir="$HOME/.config/rofi/launchers/text"
styles=($(ls -p --hide="colors.rasi" $dir/styles))
color="${styles[$(( $RANDOM % 10 ))]}"

rofi -no-lazy-grab -show calc \
-modi calc \
-theme $dir/"$theme"
