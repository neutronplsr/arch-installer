#! /usr/bin/bash

#general just good programs to have
pacman -Syy --needed  --noconfirm firefox libreoffice blueman gnome-terminal os-prober git wget linux-tools-meta gdu reflector tlp bzip2 gzip lrzip lz4 lzip lzop xz zstd p7zip zip unzip unrar unarchiver xarchiver base-devel


#aur helper of choice
git clone https://aur.archlinux.org/yay.git 
cd yay 
-u nobody makepkg -si
yay

#install gnome things that are good to have
yay -Sy -needed   --noconfirm gnome-bluetooth gnome-tweaks update-grub

#install programs that are helpful
yay -Sy --needed  --noconfirm obsidian syncthing mullvad-vpn  code oss chrome spotify anaconda steam  stellarium bitwarden  thunderbird lutris betterdiscordctl openasar discord

#customization
yay -S catppuccin-gtk-theme-mocha
curl -L https://raw.githubusercontent.com/catppuccin/gnome-terminal/v0.2.0/install.py | python3 -
mkdr ~/.local/share/fonts
unzip FiraMono.zip
mv FiraFona* ~/.local/share/fonts
cp -r syncthing-start.desktop /usr/share/applications/

#systemctl deamons
systemctl enable mullvad-daemon
systemctl enable bluetooth.service


if [ -z $1 ];
  then
    break
  elif [ "$1" == "gnome" ];
  then
    pacman -Syy --needed gnome
    systemctl enable gdm
fi


reboot 
