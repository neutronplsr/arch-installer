#! /usr/bin/bash

#if needed, uncomment this for gnome:
#pacman -Sy gnome
#systemctl enable --now gdm


#general just good programs to have
sudo pacman -Syy --needed firefox libreoffice blueman gnome-terminal os-prober git


#aur helper of choice
pacman -S --needed base-devel && git clone https://aur.archlinux.org/yay.git && cd yay && makepkg -si
yay

#install gnome things that are good to have
yay -Sy -needed gnome-bluetooth gnome-tweaks update-grub

#install programs that are helpful
yay -Sy --needed obsidian syncthing mullvad-vpn  code oss chrome spotify anaconda steam  stellarium bitwarden  thunderbird lutris betterdiscordctl openasar discord

#customization
yay -S catppuccin-gtk-theme-mocha
curl -L https://raw.githubusercontent.com/catppuccin/gnome-terminal/v0.2.0/install.py | python3 -
mkdr ~/.local/share/fonts
unzip FiraMono.zip
sudo mv FiraFona* ~/.local/share/fonts
sudo cp -r syncthing-start.desktop /usr/share/applications/

#systemctl deamons
sudo systemctl enable --now mullvad-daemon
sudo systemctl enable --now bluetooth.service
sudo systemctl enable --now syncthing(this isnt right)

