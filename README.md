# ubuntu-setup
scripts for setting up a new ubuntu installation with apps and packages

# Essentials

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

## 1password setup
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
```

## apt
```
sudo apt update && sudo apt install -y vim curl git neofetch gnome-tweaks gnome-sushi alacarte timeshift openjdk-8-jdk flatpak 1password 1password-cli
```

## flatpak (restart after)
```
flatpak remote-add --if-not-exists flathub https://flathub.org/repo/flathub.flatpakrepo
flatpak install flathub com.mattjakeman.ExtensionManager
flatpak install flathub nz.mega.MEGAsync -y
```

## snaps:
```
sudo snap install chromium
sudo snap install slack
sudo snap install code --classic
sudo snap install simplescreenrecorder

sudo snap install discord
sudo snap install steam

sudo snap install anki-woodrow
sudo snap install yt-dlp
sudo snap install gimp
sudo snap install godot-4
sudo snap install blender --classic
sudo snap install visualboyadvance-m
sudo snap install desmume-emulator
# try out for fun
sudo snap install 0ad
sudo snap install mumble
```

## Nix package manager
```
# install nix package manager
sh <(curl -L https://nixos.org/nix/install) --daemon
# install nix home-manager https://nix-community.github.io/home-manager/index.xhtml
nix-channel --add https://github.com/nix-community/home-manager/archive/master.tar.gz home-manager
nix-channel --update
nix-shell '<home-manager>' -A install
# TODO test
echo '. "$HOME/.nix-profile/etc/profile.d/hm-session-vars.sh"' >> ~/.bashrc
# TODO test if this adds direnv or nix-direnv
```

## docker
```
# TODO remove, use nix
sudo apt-get install gnupg lsb-release
sudo mkdir -p /etc/apt/keyrings
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo gpg --dearmor -o /etc/apt/keyrings/docker.gpg
echo "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.gpg] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable" | sudo tee /etc/apt/sources.list.d/docker.list > /dev/null
sudo apt-get update && sudo apt-get install -y docker-ce docker-ce-cli containerd.io docker-compose-plugin
```

## kubectl
```
# TODO remove, use nix
# extras: (TODO test)
kubectl completion bash | sudo tee /etc/bash_completion.d/kubectl > /dev/null
sudo chmod a+r /etc/bash_completion.d/kubectl
echo 'complete -o default -F __start_kubectl k' >>~/.bashrc
```

## helm
```
# TODO remove, use nix
sudo helm completion bash | sudo tee /etc/bash_completion.d/helm >/dev/null
```

## postgres
```
# TODO remove, use nix
wget --quiet -O - https://www.postgresql.org/media/keys/ACCC4CF8.asc | sudo apt-key add -
sudo sh -c 'echo "deb http://apt.postgresql.org/pub/repos/apt/ $(lsb_release -cs)-pgdg main" >> /etc/apt/sources.list.d/pgdg.list'
sudo apt update
sudo apt install -y postgresql postgresql-contrib
```

# Optional

## MSI keyboard backlight
```
sudo apt install -y git build-essential libudev-dev acpitool
git clone https://github.com/Koromix/rygel.git && cd rygel
./bootstrap.sh && ./felix -pFast meestic
sudo cp ~/rygel/bin/Fast/meestic /bin/
# sudo meestic -m Disabled
# sudo meestic -m Static MsiBlue
cd ..
```

## ollama
```
curl https://ollama.ai/install.sh | sh
```

## rust
```
curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh
```
