# ubuntu-setup
scripts for setting up a new ubuntu installation with apps and packages

# swapfile
```
sudo swapoff -a
sudo dd if=/dev/zero of=/swapfile bs=1G count=16 # 16GB
sudo chmod 0600 /swapfile
sudo mkswap /swapfile  # Set up a Linux swap area
sudo swapon /swapfile  # Turn the swap on
echo 'vm.swappiness = 10' | sudo tee -a /etc/sysctl.conf # https://askubuntu.com/questions/103915/how-do-i-configure-swappiness
```

# essentials
```
sudo apt install -y timeshift gnome-tweaks vim curl git apt-transport-https neofetch ca-certificates openjdk-8-jdk acpitool python-is-python3 alacarte gnome-sushi
sudo apt update
```

# drivers setup
```
sudo ubuntu-drivers install
```

# snaps:
sudo snap install deja-dup --classic \
sudo snap install discord \
sudo snap install dbeaver-ce \
sudo snap install code --classic \
sudo snap install steam --beta \
sudo snap install postman \
sudo snap install yt-dlp
```
note 1password is a snap too
```

# flatpak (restart after)
```
sudo apt install -y flatpak
flatpak remote-add --if-not-exists flathub https://flathub.org/repo/flathub.flatpakrepo
```
flatpak install flathub com.google.Chrome -y \
flatpak install flathub com.slack.Slack -y \
flatpak install flathub nz.mega.MEGAsync -y \
flatpak install flathub org.desmume.DeSmuME -y \
flatpak install flathub com.mattjakeman.ExtensionManager -y

# 1password
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
# Install 1Password:
sudo apt update && sudo apt install -y 1password 1password-cli
```

# dev
```
sudo apt install -y nodejs npm
sudo npm install -g n
sudo npm install --global yarn
curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh
```

# MSI keyboard backlight
```
sudo apt install -y git build-essential libudev-dev
git clone https://github.com/Koromix/rygel.git && cd rygel
./bootstrap.sh && ./felix -pFast meestic
sudo cp ~/rygel/bin/Fast/meestic /bin/
# sudo meestic -m Disabled
# sudo meestic -m Static MsiBlue
cd ..
```

# docker
```
sudo apt-get install gnupg lsb-release
sudo mkdir -p /etc/apt/keyrings
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo gpg --dearmor -o /etc/apt/keyrings/docker.gpg
echo "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.gpg] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable" | sudo tee /etc/apt/sources.list.d/docker.list > /dev/null
sudo apt-get update && sudo apt-get install -y docker-ce docker-ce-cli containerd.io docker-compose-plugin
```

# kubectl
```
# https://kubernetes.io/docs/tasks/tools/install-kubectl-linux/
sudo apt-get update
curl -fsSL https://packages.cloud.google.com/apt/doc/apt-key.gpg | sudo gpg --dearmor -o /etc/apt/keyrings/kubernetes-archive-keyring.gpg
echo "deb [signed-by=/etc/apt/keyrings/kubernetes-archive-keyring.gpg] https://apt.kubernetes.io/ kubernetes-xenial main" | sudo tee /etc/apt/sources.list.d/kubernetes.list
sudo apt-get update && sudo apt-get install -y kubectl
```
```
# extras: (TODO test)
kubectl completion bash | sudo tee /etc/bash_completion.d/kubectl > /dev/null
sudo chmod a+r /etc/bash_completion.d/kubectl
echo 'complete -o default -F __start_kubectl k' >>~/.bashrc
```

# helm
```
curl https://baltocdn.com/helm/signing.asc | gpg --dearmor | sudo tee /usr/share/keyrings/helm.gpg > /dev/null
sudo apt-get install apt-transport-https --yes
echo "deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/helm.gpg] https://baltocdn.com/helm/stable/debian/ all main" | sudo tee /etc/apt/sources.list.d/helm-stable-debian.list
sudo apt-get update && sudo apt-get install -y helm
sudo helm completion bash | sudo tee /etc/bash_completion.d/helm >/dev/null
```

# kubectx
```
echo 'deb [trusted=yes] http://ftp.de.debian.org/debian buster main' | sudo tee -a /etc/apt/sources.list
sudo apt update && sudo apt install kubectx
```

# table plus
wget -qO - https://deb.tableplus.com/apt.tableplus.com.gpg.key | gpg --dearmor | sudo tee /etc/apt/trusted.gpg.d/tableplus-archive.gpg \
sudo add-apt-repository "deb [arch=amd64] https://deb.tableplus.com/debian/22 tableplus main" \
sudo apt update \
sudo apt install -y tableplus

# postgres
wget --quiet -O - https://www.postgresql.org/media/keys/ACCC4CF8.asc | sudo apt-key add - \
sudo sh -c 'echo "deb http://apt.postgresql.org/pub/repos/apt/ $(lsb_release -cs)-pgdg main" >> /etc/apt/sources.list.d/pgdg.list' \
sudo apt update \
sudo apt install -y postgresql postgresql-contrib

# ollama
```
curl https://ollama.ai/install.sh | sh
```

