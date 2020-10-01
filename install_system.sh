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

home_dir=/home/$USER

install_packages(){
    yay -Sy dmenu spotify telegram-desktop ttf-font-awesome bumblebee-status feh redshift emacs  \
        i3lock guake gnome-terminal gnome-disk-utility picom polkit-gnome flameshot pasystray pulseaudio \
        pulseaudio-bluetooth albert breeze breeze-gtk panther-launcher-git fcitx fcitx-mozc fcitx-qt5 \
        i3-gaps lightdm-webkit2-greeter lightdm-webkit-theme-sequoia-git dunst python-pywal i3lock-color \
        qt5ct lxappearance gimp discord docker docker-compose fira-code xorg-server firefox ttf-droid-min \
        xorg-xinput noto-fonts ntfs-3g openssh
}

install_zsh(){
    if [ command -v zsh &> /dev/null ]
    then
        yay -Sy zsh
        chsh -s /bin/zsh
        sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
    fi
}


add_gpg_key(){
    if ! cat /etc/pacman.d/gnupg/gpg.conf | grep hkp://keys.gnupg
    then
        sudo sh -c "echo 'keyserver hkp://keys.gnupg.net' >> /etc/pacman.d/gnupg/gpg.conf"
	sudo cp /etc/pacman.d/gnupg/gpg.conf $home_dir/.gnupg/gpg.conf
    fi
}

install_lightdm_webkit_greeter(){
    if ! cat /etc/lightdm/lightdm.conf | grep lightdm-webkit2-greeter
    then
        sudo sed -i '/^\[Seat:/a greeter-session = lightdm-webkit2-greeter' /etc/lightdm/lightdm.conf
    fi
}

install_webkit_theme(){
    if ! cat /etc/lightdm/lightdm-webkit2-greeter.conf | grep sequoia
    then
        sudo sed -i 's/webkit_theme.*/webkit_theme = sequoia/g' /etc/lightdm/lightdm-webkit2-greeter.conf
    fi
}

install_doom_emacs(){
    if [ ! -d "$home_dir/.doom.d" ]
    then
        git clone --depth 1 https://github.com/hlissner/doom-emacs $home_dir/.emacs.d
        git clone https://github.com/Patriot720/.doom.d $home_dir/.doom.d
        $home_dir/.emacs.d/bin/doom install
    fi
}

docker_setup(){
    sudo systemctl enable docker.service
    sudo systemctl start docker.service
    sudo usermod -aG docker $USER
}

internet_fix(){
    pacman -Sy dhcpcd;
    sudo systemctl enable dhcpcd;
    sudo systemctl start dhcpcd;
}

add_multilib(){
    sudo sed -ie '92,93 s/^.//' /etc/pacman.conf
}

enable_caps_hjkl(){
    sudo cp $home_dir/altgr_vim /usr/share/X11/xkb/symbols/altgr_vim
    sudo sed -i '3 a include "altgr_vim(altgr-vim)"'  /usr/share/X11/xkb/symbols/us
}

case $1 in
    "-h" | "help" | "")
        echo -e "Arguments:\ninstall\nwebkit-theme\npackages\ninstall_zsh\ninternet_fix";;
    install_webkit_theme)
        install_webkit_theme;;
    install_packages)
        install_packages;;
    internet_fix)
        internet_fix;;
    install_zsh)
        install_zsh;;
    install)
        install_packages
        add_gpg_key
        install_zsh
        install_lightdm_webkit_greeter
        install_webkit_theme
        install_doom_emacs
        docker_setup
        add_multilib
        enable_caps_hjkl
        ;;
esac
