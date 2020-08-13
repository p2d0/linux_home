#!/usr/bin/env bash
choice=$(echo -e '\nexit' | dmenu -i -p 'New name for this workspace:' || exit 1);
echo $choice;
i3-msg $choice;
