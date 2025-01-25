# ubuntu-setup
commands for setting up a new ubuntu installation with settings, apps and packages

# User configuration

## home directory setup
```
mkdir ~/.local/bin
mkdir ~/.local/share/themes
mkdir ~/code
mkdir ~/Games
rmdir ~/Templates
rmdir ~/Public
```

## user gnome settings
```
gsettings set org.gnome.desktop.wm.keybindings close "['<Shift><Super>c']"
gsettings set org.gnome.shell.extensions.dash-to-dock dock-position "BOTTOM"
gsettings set org.gnome.shell.extensions.dash-to-dock show-trash false
gsettings set org.gnome.shell.extensions.dash-to-dock show-mounts false
gsettings set org.gnome.shell.extensions.dash-to-dock dash-max-icon-size 34
gsettings set org.gnome.shell.extensions.dash-to-dock transparency-mode "FIXED"
gsettings set org.gnome.shell.extensions.dash-to-dock background-opacity 0.5
gsettings set org.gnome.desktop.wm.preferences resize-with-right-button "true"
gsettings set org.gnome.desktop.input-sources xkb-options "['shift:both_capslock', 'caps:backspace']"
```

## gnome extensions
```
# extension list found in ~/.local/share/gnome-shell/extensions
EXT_LIST=(Vitals@CoreCoding.com clipboard-indicator@tudmotu.com scroll-workspaces@gfxmonk.net user-theme@gnome-shell-extensions.gcampax.github.com another-window-session-manager@gmail.com); for i in "${EXT_LIST[@]}"; do busctl --user call org.gnome.Shell.Extensions /org/gnome/Shell/Extensions org.gnome.Shell.Extensions InstallRemoteExtension s ${i}; done
```

# System Essentials

## swapfile
```
sudo swapoff -a
sudo dd if=/dev/zero of=/swapfile bs=1G count=16 # 16GB
# Set up a Linux swap area and turn it on
sudo chmod 0600 /swapfile && mkswap /swapfile && swapon /swapfile
echo 'vm.swappiness = 10' | sudo tee -a /etc/sysctl.conf
# https://askubuntu.com/questions/103915/how-do-i-configure-swappiness
```

## drivers setup
```
sudo ubuntu-drivers install
```

## apt
```
sudo mkdir --parents --mode=0755 /etc/apt/keyrings
sudo apt update && sudo apt install -y vim curl git neofetch gnome-tweaks gnome-sushi alacarte timeshift openjdk-8-jdk dconf-editor synaptic flatpak fzf
```

## global dotfiles
```
echo '"\C-H":"\C-W"' | sudo tee -a /etc/inputrc # ctrl+backspace will delete word
echo 'set completion-ignore-case On' | sudo tee -a /etc/inputrc # case insensitive tab completion
echo 'set number' | sudo tee -a /etc/vim/vimrc.local
```

## 1password
```
# Add the key for the 1Password apt repository:
curl -sS https://downloads.1password.com/linux/keys/1password.asc | sudo gpg --dearmor --output /usr/share/keyrings/1password-archive-keyring.gpg
# Add the 1Password apt repository:
echo 'deb [arch=amd64 signed-by=/usr/share/keyrings/1password-archive-keyring.gpg] https://downloads.1password.com/linux/debian/amd64 stable main' | sudo tee /etc/apt/sources.list.d/1password.list
# Add the debsig-verify policy:
sudo mkdir -p /etc/debsig/policies/AC2D62742012EA22/
curl -sS https://downloads.1password.com/linux/debian/debsig/1password.pol | sudo tee /etc/debsig/policies/AC2D62742012EA22/1password.pol
sudo mkdir -p /usr/share/debsig/keyrings/AC2D62742012EA22
curl -sS https://downloads.1password.com/linux/keys/1password.asc | sudo gpg --dearmor --output /usr/share/debsig/keyrings/AC2D62742012EA22/debsig.gpg
sudo apt update && sudo apt install -y 1password
```

## flatpak
```
flatpak remote-add --if-not-exists flathub https://flathub.org/repo/flathub.flatpakrepo
flatpak install flathub com.github.tchx84.Flatseal
flatpak install flathub com.mattjakeman.ExtensionManager
flatpak install flathub net.nokyan.Resources
flatpak install flathub com.system76.Popsicle
flatpak install flathub net.lutris.Lutris
flatpak install flathub com.jeffser.Alpaca
flatpak install flathub org.torproject.torbrowser-launcher
flatpak install flathub org.freedesktop.Piper
flatpak install flathub net.ankiweb.Anki
```

## snaps
```
sudo snap install chromium
sudo snap install slack
sudo snap install code --classic
sudo snap install dbeaver-ce
sudo snap install vlc
sudo snap install simplescreenrecorder
sudo snap install discord
sudo snap install steam # issues
sudo snap install todoist # maybe replace later with thunderbird
sudo snap install nordvpn # new, try it

sudo snap install codium --classic
# sudo snap install anki-woodrow # old version
sudo snap install yt-dlp
sudo snap install gimp
sudo snap install godot-4
sudo snap install blender --classic
sudo snap install foliate
sudo snap install yubioath-desktop
sudo snap install libreoffice
sudo snap install visualboyadvance-m
sudo snap install desmume-emulator

# try it again
sudo snap install docker # instructions - https://snapcraft.io/docker

# sudo snap install 0ad
# sudo snap install 1password
```

## nordvpn
```
# sh <(curl -sSf https://downloads.nordcdn.com/apps/linux/install.sh)
sudo usermod -aG nordvpn $USER
# sudo reboot
```

# Dev

## docker
```
# try the snap (nix doesn't work)
# sudo apt install gnupg lsb-release
# curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo gpg --dearmor -o /etc/apt/keyrings/docker.gpg
# echo "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.gpg] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable" | sudo tee /etc/apt/sources.list.d/docker.list > /dev/null
# sudo apt update && sudo apt install -y docker-ce docker-ce-cli containerd.io docker-compose-plugin
# sudo usermod -aG docker $USER
```

## postgres
```
wget --quiet -O - https://www.postgresql.org/media/keys/ACCC4CF8.asc | sudo apt-key add -
sudo sh -c 'echo "deb http://apt.postgresql.org/pub/repos/apt/ $(lsb_release -cs)-pgdg main" >> /etc/apt/sources.list.d/pgdg.list'
sudo apt update && sudo apt install -y postgresql postgresql-contrib
```

## Bun
```
# can use nix once I don't need bleeding edge
curl -fsSL https://bun.sh/install | bash
```

## Nix package manager
```
# install nix package manager
sh <(curl -L https://nixos.org/nix/install) --daemon
```
```
# install nix home-manager https://nix-community.github.io/home-manager/index.xhtml
nix-channel --add https://github.com/nix-community/home-manager/archive/master.tar.gz home-manager
nix-channel --add https://nixos.org/channels/nixpkgs-unstable nixpkgs
nix-channel --update
nix-shell '<home-manager>' -A install && echo '. "$HOME/.nix-profile/etc/profile.d/hm-session-vars.sh"' >> ~/.bashrc
# TODO does this add direnv or nix-direnv?
# Copy home.nix into ~/.config/home-manager/home.nix
```

# Optional

## MSI keyboard backlight
```
sudo apt install -y git build-essential libudev-dev acpitool
git clone https://github.com/Koromix/rygel.git && cd rygel
./bootstrap.sh && ./felix -pFast meestic && cd
sudo cp ~/rygel/bin/Fast/meestic /bin/
rm -r ~/rygel
# sudo meestic -m Disabled
# sudo meestic -m Static MsiBlue
```

## ollama
```
curl https://ollama.ai/install.sh | sh
```

## flatpak options if snap fails
```
flatpak install flathub com.google.Chrome
flatpak install flathub com.discordapp.Discord
flatpak install flathub com.visualstudio.code
flatpak install flathub com.slack.Slack
flatpak install flathub io.dbeaver.DBeaverCommunity
flatpak install flathub us.zoom.Zoom

flatpak install https://downloads.1password.com/linux/flatpak/1Password.flatpakref
flatpak install flathub com.valvesoftware.Steam
flatpak install flathub net.ankiweb.Anki
flatpak install flathub org.DolphinEmu.dolphin-emu
flatpak install flathub org.gimp.GIMP
flatpak install flathub org.blender.Blender
flatpak install flathub org.godotengine.Godot
flatpak install flathub com.vba_m.visualboyadvance-m
flatpak install flathub org.desmume.DeSmuME
flatpak install flathub nz.mega.MEGAsync
flatpak install flathub io.github.yairm210.unciv
flatpak install flathub org.freeciv.gtk322
```

## AMD ROC
https://rocm.docs.amd.com/projects/install-on-linux/en/latest/how-to/native-install/ubuntu.html
```
sudo wget https://repo.radeon.com/rocm/rocm.gpg.key -O - | gpg --dearmor | sudo tee /etc/apt/keyrings/rocm.gpg > /dev/null
sudo echo "deb [arch=amd64 signed-by=/etc/apt/keyrings/rocm.gpg] https://repo.radeon.com/amdgpu/6.1.2/ubuntu jammy main" | sudo tee /etc/apt/sources.list.d/amdgpu.list
sudo apt update

sudo echo "deb [arch=amd64 signed-by=/etc/apt/keyrings/rocm.gpg] https://repo.radeon.com/rocm/apt/6.1.2 jammy main" | sudo tee --append /etc/apt/sources.list.d/rocm.list
sudo echo -e 'Package: *\nPin: release o=repo.radeon.com\nPin-Priority: 600' | sudo tee /etc/apt/preferences.d/rocm-pin-600
sudo apt update

sudo apt install amdgpu-dkms
```
(reboot and configure MOK)
```
sudo apt install rocm
sudo tee --append /etc/ld.so.conf.d/rocm.conf <<EOF
/opt/rocm/lib
/opt/rocm/lib64
EOF
sudo ldconfig
```
add to bashrc
```
export PATH=$PATH:/opt/rocm-6.1.2/bin
```

## Godot
```
GODOT_VERSION=4.3
wget https://github.com/godotengine/godot/releases/download/$GODOT_VERSION-stable/Godot_v$GODOT_VERSION-stable_linux.x86_64.zip
unzip Godot_v$GODOT_VERSION-stable_linux.x86_64.zip
mv Godot_v$GODOT_VERSION-stable_linux.x86_64 .local/bin/godot
rm Godot_v$GODOT_VERSION-stable_linux.x86_64.zip
```


