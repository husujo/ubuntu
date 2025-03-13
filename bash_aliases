# laptop
alias kboff="sudo meestic -m Disabled"
alias kbon="sudo meestic -m Static MsiBlue"
alias battery="acpitool"
alias gputop="radeontop -b 03:00.0"

# apt
alias sa='sudo apt'
alias saup='sudo apt update'
alias saupg='sudo apt upgrade'

# du
alias dusort='du -sch .[!.]* * | sort -h'

# bash
alias sp='source ~/.profile'
alias bashrc='vim ~/.bashrc'
alias rebash='source ~/.bashrc'
alias ba='vim ~/.bash_aliases'
alias babackup='sudo cp ~/.bash_aliases /'

# cd
alias ".." = "cd ..";
alias cddt='cd ~/Desktop'
alias cddl='cd ~/Downloads'
alias cddoc='cd ~/Documents'
alias cdc='cd ~/code'

# ls
alias ls='ls --color=auto'
alias l='ls'
alias la='ls -a'
alias ll='ls -lF'
alias lal='ls -la'

# git
alias gs='git status'
alias gb='git branch -a'
alias gl='git log'
alias gll='git log --oneline'
alias glog='git log --oneline --decorate --graph'
alias glhash='git rev-parse --short HEAD'
alias gcm='git commit -m'
alias gcma='git commit --amend'
alias gc='git checkout'
alias gfa='git fetch --all'
alias gspp='git stash && git pull && git stash pop'
alias gpush='git push'
alias gpull='git pull'
alias gbb='git-backup-branch'
git-backup-branch() (
    set -eux
    
    timestamp=$(date "+%Y-%m-%dT%H-%M-%S")
    current_branch=$(git rev-parse --abbrev-ref HEAD)
    new_branch="backup/${current_branch}/${timestamp}"

    # Copy the current remote branch to a new branch with '-old' appended
    # Note: This will overwrite the target branch if it already exists
    git fetch origin
    git push origin "refs/remotes/origin/${current_branch}:refs/heads/${new_branch}"
)

# firefox
FIREFOX_HOME=$HOME/snap/firefox/common/.mozilla/firefox
FIREFOX_PROFILE=$FIREFOX_HOME/$(cat $FIREFOX_HOME/profiles.ini | sed -n -e 's/^.*Path=//p' | head -n 1)
FIREFOX_CSS=$FIREFOX_PROFILE/chrome/userChrome.css
alias firefox-css="mkdir -p $FIREFOX_PROFILE/chrome && touch $FIREFOX_CSS && vim $FIREFOX_CSS"
# /* about:config => toolkit.legacyUserProfileCustomizations.stylesheets */
# /* hides the native tabs */
# #TabsToolbar {
#   visibility: collapse;
# }

# nix
NIX_HOME=$HOME/.config/home-manager/home.nix
alias nixhome="code $NIX_HOME"
alias nixbackup="sudo cp $NIX_HOME /"
alias renix="nix-channel --update && home-manager switch"

## how to update nix package manager
# sudo su
# nix-env --install --file '<nixpkgs>' --attr nix cacert -I nixpkgs=channel:nixpkgs-unstable
# systemctl daemon-reload
# systemctl restart nix-daemon

# audio (broken)
# alias speaker_card_id="pactl list short cards | grep EDIFIER | awk '{print \$2}'"
# alias speaker_analog="pactl set-card-profile '$(speaker_card_id)' 'output:analog-stereo'"
# alias speaker_digital="pactl set-card-profile '$(speaker_card_id)' 'output:iec958-stereo'"
alias audio="pactl list short sinks"
alias speaker_sink_id="pactl list short sinks | grep EDIFIER | awk '{print \$2}'"
alias bluetooth_sink_id="pactl list short sinks | grep blue | awk '{print \$2}'"
# alias speakers="speaker_analog && pactl set-default-sink '$(speaker_sink_id)'"
# alias headphones="pactl set-default-sink 'alsa_output.pci-0000_00_1f.3.analog-stereo'"
# alias btheadphones="pactl set-default-sink 'bluez_sink.F8_4E_17_7C_E3_30.a2dp_sink'"
speakers () { pactl set-default-sink "$(speaker_sink_id)"; }
headphones () { pactl set-default-sink "$(bluetooth_sink_id)"; }
alias h="headphones"
alias s="speakers"

# kubectl
alias k='kubectl'
alias kn='kubens'
alias kg='kubectl get'
alias kgn='kubectl get nodes'
alias kgd='kubectl get deployments'
alias kgs='kubectl get services'
alias kgp='kubectl get pods'
alias kgpa='kubectl get pods --all-namespaces'
alias kgi='kubectl get ingress'
alias kgr='kubectl get replicaset'
alias kd='kubectl describe'
alias kdp='kubectl describe pod'
alias kdd='kubectl describe deployment'
alias kds='kubectl describe service'
alias kdr='kubectl describe replicaset'
alias ka='kubectl apply -f'
alias ke='kubectl exec -it'
alias kl='kubectl logs'
alias klf='kubectl logs --follow'
alias kgistio='kubectl get gateway,virtualservice,destinationrule'
alias krrd='kubectl rollout restart deployment'
alias kwp='watch -n 3 kubectl get pods'
alias ktp="kubectl top pods"
alias ktn="kubectl top nodes"
alias pima="kubectl describe pod $1 | grep Image:"
alias knc="kubens -c"

# docker
alias dockeri='sudo chmod 666 /var/run/docker.sock'

# doctl
alias docean='doctl' # do not use 'do'
alias doswitch='doctl auth switch --context'

# nordvpn
alias usa="nordvpn c United_States"

base64d () { 
    echo $1 | base64 -d
}

alias myip='curl ifconfig.io -4 >> ~/ips && echo "" >> ~/ips && cat ~/ips'

# qpdf --password="$password" --decrypt "$input_pdf" --replace-input

# PS1='${debian_chroot:+($debian_chroot)}\[\033[01;32m\]\u\[\033[00m\]:\[\033[01;34m\]\w$(__git_ps1 "\[\033[00m\]:\[\033[01;33m\]%s")\[\033[00m\]\$ '

alias fzf='fzf --preview="cat {}"'
