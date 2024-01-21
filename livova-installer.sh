#! /usr/bin/bash

# some assumptions:
#   you have: installed arch linux 
#   you have: linux linux-firmware linux-firmware-whence base base-devel networkmanager git
#   you have: some network connection
#   you have: sudo privleges


#inputs in the form <desktop-env> <custom-config (cattpucin)>
#make sure user gave enough arguments
if [ -z "$1" ]
  then
    echo "not enough arguments provided, please format as  \"livova-installer.sh <desktop-env> <custom-config>\" (this last is optional, has default value of null) exiting..."
    exit 0   
fi

#setup things
echo "running setup..."
mkdir ~/repos/
sudo pacman -Syy  --noconfirm 

#install aur helper
echo "installing paru..."
git clone https://aur.archlinux.org/paru.git ~/repos/
cd ~/repos/paru 
makepkg -si --noconfirm 
cd ~

#install base case programs
echo "installing base programs"
paru -S --needed  os-prober  wget  linux-tools-meta dust reflector tlp bzip2 gzip lrzip lz4 lzip lzop xz zstd p7zip zip unzip unrar unarchiver xarchiver  less blueman pipewire pipewire-pulse pipewire-alsa firefox 

sudo systemctl start bluetooth
sudo systemctl enable pipewire.service



wm1="gnome"
wm2="qtile"
wm3="gnome-way"
wm4="qtile-way"
wm5="hyprland"
wm6="hyprland-nvidia"

wm_check=0

single_wm_check() {
  found=0 
  for args in "$@"; do
    case "$args" in 
            "$wm1" | "$wm2" | "$wm3" | "$wm4" | "$wm5" | "$wm6")
                ((found++))
                ;;
        esac
    done

    if [ "$found" -gt 1 ]; then
        echo "too many window/desktop arguments passed. please only provide one. the script will finish as if you passed no winodw manager arugments."
        wm_check=1
    fi
}

single_wm_check "$@"



echo "please reboot for best results!"