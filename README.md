# livova-arch-installer

this is my personal arch-install script, meant to speed up future installs of linux on any machine i may use 

some assumptions:\
	- you are in a  installed arch linux environment\
	- you have: `base base-devel git linux linux-firmware linux-firmware-whence micro networkmanager `\
 	- you have: some network connection \
	- you have: sudo privleges

this script makes use of the following dot-file repos:\
[dots-hyprland](https://github.com/end-4/dots-hyprland) \
[dotfiles-gnm](https://github.com/GabrielTenma/dotfiles-gnm) \
[qtile-dot](https://github.com/antoniosarosi/dotfiles/tree/master/.config/qtile) \
[livova-dots](https://github.com/neutronplsr/livova-dotfiles)


## base running installs:
`blueman`: bluetooth handling\
`bzip2, gzip, lrzip,lzip,lzop, lz4, p7zip, unarchiver, unrar, unzip, xarchiver, xz, zip, zstd`: compression and extraction utilities\
`dust`: disk usage analyzer built from rust\
`firefox`: web browser
`less`: shows bits of files, similar to cat\
`linux-headers`: linux dynamic kernel modules package\
`linux-tools-meta`: general useful tools for an install\
`os-prober`: package to find bootable partitions for grub\
`paru`: AUR helper built in rust\
`pipewire, pipewire-alsa, pipewire-pulse`: audio service\
`reflector`: utility to keep mirrors updated and fast\
`tlp`: battery life/power saving helper for mobile installs such as laptops\
`wget`: file getting from network\


## useage and arguments
arguments are to be formatted like the following:

`./livova-installer.sh [arg1] [arg2] [arg3]...` without the `[]` included.

you can include as many optional packages as you'd like, but only a sin2gle window/desktop manager.

use "dot-files" i recommend with the flag  `--pretty` \
use "dot-files" that i use with the flag `--livovaStyle` 

### window/desktop managers:
These lists are not exaushtive as to what the script installs, as there are many dependancies invovled in these enviorments.
#### X11:
  - `gnome`: installs `gnome` 
  - `qtile`: installs `qtile`and `lightdm-gtk-greeter`
  
#### wayland:
  - (eventually) `cosmic`
  - `gnome-way`: installs `gnome`
  - `hyprland`: installs `hyprland` and `sddm`
  - `hyprland-nvidia`: installs `hyprland`, `sddm`, and nesscary addiotnal nvidia packages/config
  	- ***YOU MUST USE THIS FOR HYPRLAND WITH NVIDIA CARDS***
  - `qtile-way`: installs `qtile` and `sddm`
  
   
### optional packages:
  - `all`: installs all optional packages
  - `code`: installs `code pyenv python python-pipx rust`
  - `gaming`: installs `lutris protonup-qt qbittorrent-git steam xpadneo-dkms`
  - `nvidia`: installs `nvidia-dkms`
  - `space`: installs `ds9 python-astropy31 stellarium`
  	- ***THIS WILL ALSO INSTALL THE `code` PACKAGE AUTOMATICUALLY***
  - `useful`: installs `betterdiscordctl discord firefox-beta-bin mullvad-vpn obsidian-bin openasar-git pcloud-drive`
