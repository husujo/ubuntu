alias rebash="source ~/.bashrc"
alias sa="sudo apt"
alias sp='source ~/.profile'
alias ba='vim ~/.bash_aliases'
alias hi='echo "Hello World"'
alias myip='curl http://ipinfo.io/ip && echo'
alias battery='acpitool'
alias l='ls -G'
alias la='ls -a -G'
alias ll='ls -l -G'
alias lal='ls -la -G'

alias dockerinit='sudo chmod 666 /var/run/docker.sock'

# kubectl
alias k='kubectl'
alias kg='kubectl get'
alias kgn='kubectl get nodes'
alias kgd='kubectl get deployments'
alias kgs='kubectl get services'
alias kgp='kubectl get pods'
alias kgi='kubectl get ingress'
alias kd='kubectl describe'
alias ka='kubectl apply -f'
alias ke='kubectl exec -it'
alias kgistio='kubectl get gateway,virtualservice,destinationrule'

alias switchjava="sudo update-alternatives --config java"

FIREFOX_HOME=$HOME/snap/firefox/common/.mozilla/firefox
FIREFOX_PROFILE=$FIREFOX_HOME/$(cat $FIREFOX_HOME/profiles.ini | sed -n -e 's/^.*Path=//p' | head -n 1)
FIREFOX_CSS=$FIREFOX_PROFILE/chrome/userChrome.css
alias firefox-css="mkdir -p $FIREFOX_PROFILE/chrome && touch $FIREFOX_CSS && vim $FIREFOX_CSS"
