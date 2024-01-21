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
paru -S --needed --noconfirm  os-prober  wget  linux-tools-meta dust reflector tlp bzip2 gzip lrzip lz4 lzip lzop xz zstd p7zip zip unzip unrar unarchiver xarchiver  less blueman pipewire pipewire-pulse pipewire-alsa firefox linux-headers

sudo systemctl start bluetooth
sudo systemctl enable pipewire.service

#! /usr/bin/bash
##check user didnt mess up and provide too many WM/DE
wm1="gnome"
wm2="qtile"
wm3="gnome-way"
wm4="qtile-way"
wm5="hyprland"
wm6="hyprland-nvidia"

dot1="--pretty"
dot2="--livovaStyle"

wm_check=0
wmInst=""


prty=0
livvy=0

argChecker() {
  found=0 
  for args in "$@"; do
    case "$args" in 
            "$wm1" | "$wm2" | "$wm3" | "$wm4" | "$wm5" | "$wm6")
                ((found++))
                wmInst="$args"
                ;;
            "$dot1")
              prty=1
              ;;
            "$dot2")
              livvy=1
              ;; 
        esac
    done

    if [ "$found" -gt 1 ]; then
      echo "too many WE/DE arguments passed. please only provide one. the script will finish as if you passed no arugment of this kind."
      wm_check=1
    fi
    if [ "$livvy" == 1 ]  && [ "$prty" == 1 ]; then
      echo "too many dot file arguments passed. please only provide one in the future. the script will use recommended files."
    fi
}

argChecker "$@"

#install desired WM/DE
if [ "$wm_check" == 0 ]; then
    case "$wmInst" in 
            "$wm1")
              echo "installing gnome (xorg)"
              paru -S --needed --noconfirm xorg xorg-server
              paru -S --needed --noconfirm gnome gnome-tweaks gnome-terminal gnome-bluetooth 
              
              sudo systemctl start gdm.service
              ;;
            "$wm2")
              echo "installing qtile (xorg)"
              paru -S --needed --noconfirm xorg xorg-server lightdm-gtk-greeter
              paru -S --needed -noconfirm qtile qtile-extras


              sudo systemctl enable lightdm
              ;;
            "$wm3")
              echo "installing gnome (wayland)"
              paru -S --needed --noconfirm wayland xorg-xwayland xorg-xlsclients glfw-wayland wlroots python-pywlroots 
              paru -S --needed --noconfirm gnome gnome-tweaks gnome-terminal gnome-bluetooth 
              
              sudo systemctl start gdm.service
              ;;
            "$wm4")
              echo "installing qtile (wayland)"
              paru -S --needed --noconfirm wayland xorg-xwayland xorg-xlsclients glfw-wayland wlroots python-pywlroots 
              paru -S --needed --noconfirm qtile qtile-extras
              paru -S --needed --noconfirm sddm
              
              sudo systemctl enable sddm
              ;;
            "$wm5")
              echo "installing hyprland (non nvidia)"
              paru -S --needed --noconfirm gdb ninja gcc cmake meson libxcb xcb-proto xcb-util xcb-util-keysyms libxfixes libx11 libxcomposite xorg-xinput libxrender pixman wayland-protocols cairo pango seatd libxkbcommon xcb-util-wm xorg-xwayland libinput libliftoff libdisplay-info cpio tomlplusplus kitty wlroots python-pywlroots 
              paru -S --needed --noconfirm hyprland-git 
              paru -S --needed --noconfirm sddm
              paru -S --needed --noconfirm wired wireplumber xdg-desktop-portal-hyprland polkit-kde-agent wofi
            
              sudo systemctl enable sddm
              ;;
            "$wm6")
              echo "installing hyprland (nvidia)"
              paru -S --needed --noconfirm gdb ninja gcc cmake meson libxcb xcb-proto xcb-util xcb-util-keysyms libxfixes libx11 libxcomposite xorg-xinput libxrender pixman wayland-protocols cairo pango seatd libxkbcommon xcb-util-wm xorg-xwayland libinput libliftoff libdisplay-info cpio tomlplusplus kitty wlroots python-pywlroots 
              paru -S --needed --noconfirm hyprland-git 
              paru -S --needed --noconfirm wired wireplumber xdg-desktop-portal-hyprland polkit-kde-agent wofi

              #nvidia weirdness
              paru -S --needed --noconfirm nvidia-dkms linux-headers qt5-wayland qt6-wayland qt5ct qt6ct libva libva-nvidia-driver-git

              ##### test this
              sudo sed -i 's/GRUB_CMDLINE_LINUX_DEFAULT="\(.*\)"/GRUB_CMDLINE_LINUX_DEFAULT="\1 nvidia_drm.modeset=1 noapic"/' /etc/default/grub
              ##### test this
              
              sudo grub-mkconfig -o /boot/grub/grub.cfg

              ##### test this
              sudo sed -i '/^MODULES=/ s/)$/ nvidia nvidia_modeset nvidia_uvm nvidia_drm)/' /etc/mkinitcpio.conf
              ##### test this
              

              sudo mkinitcpio --config /etc/mkinitcpio.conf --generate /boot/initramfs-custom.img

              ##### test this
              echo "options nvidia-drm modeset=1" | sudo tee -a /etc/modprobe.d/nvidia.conf > /dev/null
              ##### test this

              mkdir .config/hypr
              cp repos/Hyprland/example/hyprland.conf .config/hypr/hyprland.conf
              
              ##### test this
              echo -e "env = LIBVA_DRIVER_NAME,nvidia\nenv = XDG_SESSION_TYPE,wayland\nenv = GBM_BACKEND,nvidia-drm\nenv = __GLX_VENDOR_LIBRARY_NAME,nvidia\nenv = WLR_NO_HARDWARE_CURSORS,1" | tee -a ~/.config/hypr/config.hypr > /dev/null
              ##### test this

              paru -S --needed --noconfirm sddm
              sudo systemctl enable sddm

              ;;
            
        esac
fi



opt1="nvidia"
opt2="code"
opt3="space"
opt4="gaming"
opt5="useful"
opt6="all"

packgelist=""

pkg1=" nvidia-dkms "
pkg2=" code pyenv python python-pipx rust  "
pkg3=" ds9 python-astropy31 stellarium "
pkg4=" lutris protonup-qt qbittorrent-git steam xpadneo-dkms "
pkg5=" betterdiscordctl discord firefox-beta-bin mullvad-vpn obsidian-bin openasar-git pcloud-drive "
#install optional packages, check for dotfiles
for arg in "$@"; do
    case "$arg" in
        "$opt1")
            echo "installing nvidia packages..."
            packgelist+="$pkg1"
            ;;
        "$opt2")
            echo "installing code packages..."
            packgelist+="$pkg2"
            ;;
        "$opt3")
            echo "installing space packages AND code packages ..."
            packgelist+="$pkg2"
            packgelist+="$pkg3"
            ;;
        "$opt4")
            echo "installing gaming packages ..."
            packgelist+="$pkg4"
            ;;
        "$opt5")
            echo "installing useful packages ..."
            packgelist+="$pkg5"
            ;;
        "$opt6")
            echo "installing all optional packages ..."
            packgelist+="$pkg1"
            packgelist+="$pkg2"
            packgelist+="$pkg3"
            packgelist+="$pkg4"
            packgelist+="$pkg5"
            break
            ;;
        "$wm1" | "$wm2" | "$wm3" | "$wm4" | "$wm5" | "$wm6" | "$dot1" | "$dot2")
            ;;
        *)
            echo "argument not found: $arg moving on..."
            ;;
    esac
done
eval "paru -S --needed --noconfirm $packgelist"

#install dot-files
##if both passed, pretty takes priority

if [ "$prty" == 1 ]; then
  echo "installing recommended dot files"
f [ "$wm_check" == 0 ]; then
    case "$wmInst" in 
            "$wm1" | "$wm3")
              echo "installing gnome-dots"
              cd ~/repos/
              git clone https://github.com/GabrielTenma/dotfiles-gnm.git
              cd dotfiles-gnm

              cp -r ./themes/* ~/.themes/
              cp -r ./icons/* ~/.icons/
              cp -r ./gnome-shell/* ~/.local/share/gnome-shell/*

              paru -S --needed --noconfirm gnome-tweak-tool
              sudo cp -r ./misc/fonts/* /usr/share/fonts/


              array=( https://extensions.gnome.org/extension/3628/arcmenu/
              https://extensions.gnome.org/extension/5338/aylurs-widgets/ 
              https://extensions.gnome.org/extension/4679/burn-my-windows/
              https://extensions.gnome.org/extension/3740/compiz-alike-magic-lamp-effect/
              https://extensions.gnome.org/extension/307/dash-to-dock/ 
              https://extensions.gnome.org/extension/5696/one-window-wonderland/ 
              https://extensions.gnome.org/extension/750/openweather/
              https://extensions.gnome.org/extension/4356/top-bar-organizer/ 
              https://extensions.gnome.org/extension/4684/useless-gaps/ 
              https://extensions.gnome.org/extension/517/caffeine/ 
              https://extensions.gnome.org/extension/4412/advanced-alttab-window-switcher/
              https://extensions.gnome.org/extension/1018/text-scaler/ )

              for i in "${array[@]}"
              do
                  EXTENSION_ID=$(curl -s $i | grep -oP 'data-uuid="\K[^"]+')
                  VERSION_TAG=$(curl -Lfs "https://extensions.gnome.org/extension-query/?search=$EXTENSION_ID" | jq '.extensions[0] | .shell_version_map | map(.pk) | max')
                  wget -O ${EXTENSION_ID}.zip "https://extensions.gnome.org/download-extension/${EXTENSION_ID}.shell-extension.zip?version_tag=$VERSION_TAG"
                  gnome-extensions install --force ${EXTENSION_ID}.zip
                  if ! gnome-extensions list | grep --quiet ${EXTENSION_ID}; then
                      busctl --user call org.gnome.Shell.Extensions /org/gnome/Shell/Extensions org.gnome.Shell.Extensions InstallRemoteExtension s ${EXTENSION_ID}
                  fi
                  gnome-extensions enable ${EXTENSION_ID}
                  rm ${EXTENSION_ID}.zip
              done

              ;;
            "$wm2" | "$wm4")
              echo "installing qtile-dots"
              paru -S --needed -noconfirm nerd-fonts-ubuntu-mono
              pip install psutil

              cd ~/repos/
              git clone https://github.com/antoniosarosi/dotfiles.git
              cp -r dotfiles/.config/qtile ~/.config
              
              ;;

            "$wm5" | "$wm6")
              echo "installing dots-hyprland"
              cd ~/repos/
              paru -S --needed --noconfirm blueberry brightnessctl cliphist coreutils curl fish foot fuzzel gjs gnome-bluetooth-3.0 gnome-control-center gnome-keyring gobject-introspection grim gtk3 gtk-layer-shell libdbusmenu-gtk3 meson networkmanager npm plasma-browser-integration playerctl polkit-gnome python-pywal ripgrep sassc slurp starship swayidle typescript upower xorg-xrandr webp-pixbuf-loader wget wireplumber wl-clipboard tesseract yad ydotool adw-gtk3-git cava gojq gradience-git hyprland-git hyprpicker-git lexend-fonts-git python-material-color-utilities python-pywal python-poetry python-build python-pillow ttf-material-symbols-variable-git ttf-space-mono-nerd swaylock-effects-git ttf-jetbrains-mono-nerd wayland-idle-inhibitor-git wlogout wlsunset-git
              sudo usermod -aG video $(whoami)  # if this somehow doesn't work, just replace "$(whoami)" with your username
              sudo usermod -aG input $(whoami)  # same for this

              git clone --recursive https://github.com/Aylur/ags.git
              cd ags
              npm install
              meson setup build
              meson install -C build  

              cd .. # Let's not trash your home folder
              git clone https://github.com/end-4/dots-hyprland.git
              cd dots-hyprland && git checkout illogical-impulse

              cp -r .config/* ~/.config/
              cp -r .local/* ~/.local/

              ;;
        esac
fi
  

  elif [ "$livvy" == 1 ]; then
  echo "installing livova dot files not supported yet sorry :("
fi



echo "please reboot for best resulusts" 