alias rebash="source ~/.bashrc"
alias sa="sudo apt"
alias sp='source ~/.profile'
alias ba='vim ~/.bash_aliases'
alias hi='echo "Hello World"'
alias myip='curl http://ipinfo.io/ip && echo'
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
