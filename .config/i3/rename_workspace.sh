#!/usr/bin/env bash
DIR="$(cd "$(dirname "$0")" && pwd)"
choice=$(echo -e "Emacs\nBrowser\nDiscord\nRemoteDesktop\nFileManager\nRanger" | dmenu -i -p "New name for this workspace:" || exit 1)
i3-msg 'rename workspace to "'$("$DIR/get_workspace_number.sh")' : '$choice'"'
# WS=`python3 -c "import json; print(next(filter(lambda w: w['focused'], json.loads('$(i3-msg -t get_workspaces)')))['num'])"`; i3-input -F "rename workspace to $WS:%s" -P 'New name: '
