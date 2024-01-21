# livova-arch-installer

# ***THIS SCRIPT IS UNDER DEVOLPMENT, AND MAY NOT WORK AT TIME OF WRITING***


# readme
this is my personal arch-install script, meant to speed up future installs of linux on any machine i may use. 
some assumptions:
	you are in a  installed arch linux environment
	you have: `base-devel git micro`

this script makes use of the following dot -file repos:
[dots-hyprland](https://github.com/end-4/dots-hyprland)
[dotfiles-gnm](https://github.com/GabrielTenma/dotfiles-gnm)
[qtile-dot](https://github.com/antoniosarosi/dotfiles/tree/master/.config/qtile)
[livova-dots](https://github.com/neutronplsr/livova-dotfiles)


## base running installs:
`paru`: AUR helper built in rust
`os-prober`: package to find bootable partitions for grub
`wget`: file getting from network
`linux-tools-meta`: general useful tools for an install
`dust`: disk usage analyzer built from rust
`reflector`: utility to keep mirrors updated and fast
`tlp`: battery life/power saving helper for mobile installs such as laptops
`bzip2, gzip, lrzip, lz4, lzip, lzop, xz, zstd, p7zip, zip, unzip, unrar, unarchiver, xarchiver`: compression and extraction utilities
`less`: shows bits of files, similar to cat
`blueman`: bluetooth handling
`pipewire`: audio service
`firefox`: web browser
## useage and arguments
arguments are to be formatted like the following:
`./livova-installer.sh [arg1] [arg2] [arg3]` without the `[]` included. 
you can include as many optional packages as you'd like, but only a single window/desktop manager. 
"dot-files" i recommend can be installed with the flag `--pretty` 
my personal dot-files can be used with the flag `--livovaStyle` 

### window/desktop managers:
  - gnome: installs gnome (x11)
  - qtile: installs qtile (x11)
  - hyprland: installs hyprland (wayland)
  - (eventually) cosmic (wayland)
   
### optional packages:
  - nvidia: installs nvidia-dkms
  - code: installs vs code, python, pip, pyenv
  - space: installs stellarium, astropy, and other misc. python things
  - gaming: installs steam, lutris, wine, qbit
  - useful: installs mullvadvpn, pcloud, discord, obsidian, second firefox client
  - 













