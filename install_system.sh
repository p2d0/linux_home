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
yay -Sy dmenu spotify telegram-desktop ttf-font-awesome bumblebee-status feh redshift emacs  \
    i3lock guake gnome-terminal gnome-disk-utility picom polkit-gnome flameshot pasystray pulseaudio \
    pulseaudio-bluetooth albert breeze breeze-gtk panther-launcher-git

#Install zsh
if [ command -v zsh &> /dev/null ]
then
    yay -Sy zsh
    chsh -s /bin/zsh
    sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
fi

#Add gpg key
if ! cat /etc/pacman.d/gnupg/gpg.conf | grep hkp://keys.gnupg
then
    sudo sh -c "echo 'keyserver hkp://keys.gnupg.net' >> /etc/pacman.d/gnupg/gpg.conf"
fi

read -p "User home directory name:" name
home_dir="/home/$name"
if [ ! -d "/home/$name" ]
then
   mkdir home_dir
fi

if [ ! -d "$home_dir/.doom.d" ]
then
    git clone --depth 1 https://github.com/hlissner/doom-emacs $home_dir/.emacs.d
    git clone https://github.com/Patriot720/.doom.d $home_dir/.doom.d
    $home_dir/.emacs.d/bin/doom install
fi

# Set qt & gtk theme
