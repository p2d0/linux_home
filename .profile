#!/usr/bin/env bash
export QT_QPA_PLATFORMTHEME="qt5ct"
# Japanese input
export QT_IM_MODULE=fcitx
export XMODIFIERS=@im=fcitx
export GTK_IM_MODULE=fcitx
PATH="$HOME/.node_modules/bin:$PATH"
export npm_config_prefix=~/.node_modules
