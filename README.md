# ubuntu-setup
scripts for setting up a new ubuntu installation with apps and packages

# swapfile
sudo swapoff -a \
sudo dd if=/dev/zero of=/swapfile bs=1G count=8 # 8GB \
sudo chmod 0600 /swapfile \
sudo mkswap /swapfile  # Set up a Linux swap area \
sudo swapon /swapfile  # Turn the swap on \
echo 'vm.swappiness = 10' | sudo tee -a /etc/sysctl.conf # https://askubuntu.com/questions/103915/how-do-i-configure-swappiness

# essentials
sudo apt install -y timeshift \
sudo apt install -y gnome-tweaks \
sudo apt install -y vim \
sudo apt install -y curl \
sudo apt install -y git \
sudo apt install -y apt-transport-https \
sudo apt install -y neofetch \
sudo apt install -y ca-certificates \
sudo apt install -y openjdk-8-jdk \
sudo apt update

# drivers setup
sudo ubuntu-drivers install

# snaps:
sudo snap install deja-dup --classic \
sudo snap install discord \
sudo snap install dbeaver-ce \
sudo snap install code --classic \
sudo snap install 1password \
sudo snap install steam --beta \
sudo snap install postman

# flatpak (restart after)
sudo apt install -y flatpak \
flatpak remote-add --if-not-exists flathub https://flathub.org/repo/flathub.flatpakrepo \
flatpak install flathub com.google.Chrome
flatpak install flathub com.slack.Slack
flatpak install flathub nz.mega.MEGAsync

# dev
sudo apt install -y nodejs npm \
sudo npm install -g n \
sudo npm install --global yarn

# MSI keyboard backlight
sudo apt install -y git build-essential libudev-dev \
git clone https://github.com/Koromix/rygel.git \
cd rygel \
./bootstrap.sh \
./felix -pFast meestic \
sudo ./bin/Fast/meestic -m Disabled \
cd ..

# docker
sudo apt-get install gnupg lsb-release \
sudo mkdir -p /etc/apt/keyrings \
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo gpg --dearmor -o /etc/apt/keyrings/docker.gpg \
echo "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.gpg] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable" | sudo tee /etc/apt/sources.list.d/docker.list > /dev/null \
sudo apt-get update \
sudo apt-get install -y docker-ce docker-ce-cli containerd.io docker-compose-plugin

# kubectl
sudo apt-get update \
sudo curl -fsSLo /etc/apt/keyrings/kubernetes-archive-keyring.gpg https://packages.cloud.google.com/apt/doc/apt-key.gpg \
echo "deb [signed-by=/etc/apt/keyrings/kubernetes-archive-keyring.gpg] https://apt.kubernetes.io/ kubernetes-xenial main" | sudo tee /etc/apt/sources.list.d/kubernetes.list \
sudo apt-get update \
sudo apt-get install -y kubectl

# helm
curl https://baltocdn.com/helm/signing.asc | gpg --dearmor | sudo tee /usr/share/keyrings/helm.gpg > /dev/null \
sudo apt-get install apt-transport-https --yes \
echo "deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/helm.gpg] https://baltocdn.com/helm/stable/debian/ all main" | sudo tee /etc/apt/sources.list.d/helm-stable-debian.list \
sudo apt-get update \
sudo apt-get install helm

# kubectx
echo 'deb [trusted=yes] http://ftp.de.debian.org/debian buster main' | sudo tee -a /etc/apt/sources.list \
sudo apt update \
sudo apt install kubectx

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
