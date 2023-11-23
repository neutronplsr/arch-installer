#! /usr/bin/bash

# THIS SCRIPT ASSUMES THE FOLLOWING:
#   INSTALLED PACKAGES: linux linux-firmware linux-firmware-whence base base-devel networkmanager
#   SUDO PRIVLEGES FOR RUNNING USER


#inputs in the form <desktop-env> <custom-config (cattpucin)>
#make sure user gave enough arguments
if [ -z "$1" ] || [ -z "$2" ];
  then
    echo "not enough arguments provided, please format as  \"livova-installer.sh <desktop-env> <custom-config>\" (this last is optional, has default value) exiting..."
    exit 0   
fi

sudo pacman -Syy  --noconfirm 

#install general good utilities
pacman -S --needed  --noconfirm os-prober git wget linux-tools-meta gdu reflector tlp bzip2 gzip lrzip lz4 lzip lzop xz zstd p7zip zip unzip unrar unarchiver xarchiver base-deval blueman nano pipewire blueman
sudo systemctl start bluetooth
sudo systemctl enable pipewire.service

#install aur helper
git clone https://aur.archlinux.org/yay.git 
cd yay 
makepkg -si --noconfirm 
yay

cd ..

#install wanted desktop enviorment
if [ "$1" == "gnome" ];
  then
    echo "gnome install running..."
    sudo pacman -S --needed  --noconfirm  gnome gnome-tweaks gnome-terminal gnome-bluetooth gnome-tweaks
    sudo systemctl enable gdm
  else
    echo "desktop env provided not found. will contiune as if you don't need one"
fi

#install generally good programs
yay  -Sy --needed  --noconfirm firefox libreoffice  obsidian syncthing mullvad-vpn  code oss chrome spotify anaconda steam  stellarium bitwarden  thunderbird lutris betterdiscordctl openasar discord update-gnome
sudo systemctl enable mullvad-daemon


#livova special customization

if  [ "livova" == "$2" ];
    then 
    yay -S --noconfirm --needed catppuccin-gtk-theme-mocha
    sudo curl -L https://raw.githubusercontent.com/catppuccin/gnome-terminal/v0.2.0/install.py | python3 -
    sudo mkdr ~/.local/share/fonts
    sudo unzip FiraMono.zip
    sudo mv FiraFona* ~/.local/share/fonts
    sudo cp -r syncthing-start.desktop /usr/share/applications/
fi

echo "Please reboot for best results."