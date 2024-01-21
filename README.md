# livova-arch-installer

***THIS SCRIPT IS UNDER DEVOLPMENT, AND MAY NOT WORK AT TIME OF WRITING***

this is my personal arch-install script, meant to speed up future installs of linux on any machine i may use 

some assumptions:\
	- you are in a  installed arch linux environment\
	- you have: `base-devel git micro`\
 	- you have: some network connection, if wireless  `networkmanager`

this script makes use of the following dot-file repos:\
[dots-hyprland](https://github.com/end-4/dots-hyprland) \
[dotfiles-gnm](https://github.com/GabrielTenma/dotfiles-gnm) \
[qtile-dot](https://github.com/antoniosarosi/dotfiles/tree/master/.config/qtile) \
[livova-dots](https://github.com/neutronplsr/livova-dotfiles)


## base running installs:
`paru`: AUR helper built in rust\
`os-prober`: package to find bootable partitions for grub\
`wget`: file getting from network\
`linux-tools-meta`: general useful tools for an install\
`dust`: disk usage analyzer built from rust\
`reflector`: utility to keep mirrors updated and fast\
`tlp`: battery life/power saving helper for mobile installs such as laptops\
`bzip2, gzip, lrzip, lz4, lzip, lzop, xz, zstd, p7zip, zip, unzip, unrar, unarchiver, xarchiver`: compression and extraction utilities\
`less`: shows bits of files, similar to cat\
`blueman`: bluetooth handling\
`pipewire, pipewire-pulse, pipewire-alsa`: audio service\
`firefox`: web browser


## useage and arguments
arguments are to be formatted like the following:

`./livova-installer.sh [arg1] [arg2] [arg3]` without the `[]` included.

you can include as many optional packages as you'd like, but only a sin2gle window/desktop manager.

use "dot-files" i provide with the flag  `--pretty` \
use "dot-files" that i use with the flag `--livovaStyle` 

### window/desktop managers:
#### X11:
  - `gnome`: installs `gnome` 
  - `qtile`: installs `qtile`
  
#### wayland:
  - `gnome-way`: installs `gnome`
  - `qtile-way`: installs `qtile`
  - `hyprland`: installs `hyprland`
  - `hyprland-nvidia`: installs `hyprland` and nesscary addiotnal nvidia packages/config
  	- ***YOU MUST USE THIS OR HYPRLAND WONT WOKR WITH NVIDIA CARDS***
  - (eventually) `cosmic`
   
### optional packages:
  - `nvidia`: installs `nvidia-dkms`
  - `code`: installs `vs code, python, pip, pyenv`
  - `space`: installs `stellarium, astropy,` and other misc. python things ***THIS WILL ALSO INSTALL `code` AUTOMATICUALLY***
  - `gaming`: installs `steam, lutris, wine, qbit, xpadneo`
  - `useful`: installs `mullvadvpn, pcloud, discord, obsidian, second firefox client`
  - `all`: installs all optional packages

