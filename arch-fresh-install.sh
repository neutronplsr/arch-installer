#! /usr/bin/bash

#if needed, uncomment this for gnome:
#pacman -Sy gnome
#systemctl enable --now gdm


#general just good programs to have
sudo pacman -Syy
sudo pacman -S firefox
sudo pacman -S libreoffice
sudo pacman -S blueman
sudo pacman -S gnome-terminal
sudo pacman -S os-prober
sudo pacman -S git


#aur helper of choice
pacman -S --needed git base-devel && git clone https://aur.archlinux.org/yay.git && cd yay && makepkg -si
yay

#install gnome things that are good to have
yay gnome-bluetooth
yay gnome-tweaks
yay update-grub

#install programs that are helpful
yay obsidian
yay syncthing
yay mullvad vpn
yay code oss
yay chrome
yay spotify
yay anaconda
yay steam
yay stellarium

#customization
yay -S catppuccin-gtk-theme-mocha
curl -L https://raw.githubusercontent.com/catppuccin/gnome-terminal/v0.2.0/install.py | python3 -

#systemctl deamons
sudo systemctl enable --now mullvad-daemon
sudo systemctl enable --now bluetooth.service
