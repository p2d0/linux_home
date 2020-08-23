#!/usr/bin/env bash
if ! command -v yay &> /dev/null
then
    pacman -S --needed base-devel
    mkdir build
    cd build
    git clone https://aur.archlinux.org/yay.git
    cd yay
    makepkg -si
fi

# Install packages

packages(){
    yay -Sy dmenu spotify telegram-desktop ttf-font-awesome bumblebee-status feh redshift emacs  \
        i3lock guake gnome-terminal gnome-disk-utility picom polkit-gnome flameshot pasystray pulseaudio \
        pulseaudio-bluetooth albert breeze breeze-gtk panther-launcher-git fcitx fcitx-mozc fcitx-qt5 \
        i3-gaps lightdm-webkit2-greeter lightdm-webkit-theme-sequoia-git dunst python-pywal i3lock-color \
        qt5ct lxappearance gimp discord docker docker-compose
}

#Install zsh
zsh(){
    if [ command -v zsh &> /dev/null ]
    then
        yay -Sy zsh
        chsh -s /bin/zsh
        sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
    fi
}

#Add gpg key
gpg(){
    if ! cat /etc/pacman.d/gnupg/gpg.conf | grep hkp://keys.gnupg
    then
        sudo sh -c "echo 'keyserver hkp://keys.gnupg.net' >> /etc/pacman.d/gnupg/gpg.conf"
    fi
}

set_home_dir(){
    read -p "User home directory name:" name
    home_dir="/home/$name"
    if [ ! -d "/home/$name" ]
    then
        mkdir home_dir
    fi
}

# Install lightdm webkit greeter
webkit2-greeter-setup(){
    if ! cat /etc/lightdm/lightdm.conf | grep lightdm-webkit2-greeter
    then
        sudo sed -i '/^\[Seat:/a greeter-session = lightdm-webkit2-greeter' /etc/lightdm/lightdm.conf
    fi
}

# Install Webkit greeter theme
webkit-theme(){
    if ! cat /etc/lightdm/lightdm-webkit2-greeter.conf | grep sequoia
    then
        sudo sed -i 's/webkit_theme\s=.*/webkit_theme = sequoia/g' /etc/lightdm/lightdm-webkit2-greeter.conf # TODO doesnt work
    fi
}

#Install DOOM Emacs
doom_setup(){
    if [ ! -d "$home_dir/.doom.d" ]
    then
        git clone --depth 1 https://github.com/hlissner/doom-emacs $home_dir/.emacs.d
        git clone https://github.com/Patriot720/.doom.d $home_dir/.doom.d
        $home_dir/.emacs.d/bin/doom install
    fi
}

case $1 in
    "-h" | "help" | "")
        echo "Arguments:\ninstall\nwebkit-theme\npackages\n";;
    webkit-theme)
        webkit-theme;;
    packages)
        packages;;
    install)
        packages
        gpg
        set_home_dir
        webkit2-greeter-setup
        webkit-theme
        doom_setup
        ;;
esac
