{ config, pkgs, ... }:

let
  username = builtins.getEnv "USER";
  homeDir = builtins.getEnv "HOME";
in
{
  home.username = username;
  home.homeDirectory = homeDir;

  # This value determines the Home Manager release that your configuration is
  # compatible with. This helps avoid breakage when a new Home Manager release
  # introduces backwards incompatible changes.
  #
  # You should not change this value, even if you update Home Manager. If you do
  # want to update the value, then make sure to first check the Home Manager
  # release notes.
  home.stateVersion = "25.05"; # Please read the comment before changing.

  nixpkgs.config.allowUnfree = true;

  # The home.packages option allows you to install Nix packages into your environment.
  home.packages = with pkgs; [
    kubectl
    kubectx
    (wrapHelm kubernetes-helm {
        plugins = [ kubernetes-helmPlugins.helm-cm-push ];
    })
    # terraform
    # terragrunt
    # argocd
    doctl
    flyctl
    # google-cloud-sdk
    # s3cmd
    ngrok
    nodejs_24 # & npm
    bun
    # deno
    python3 # & pip

    # things with daemons don't seem to work, like:
    # postgresql_16
    # docker

    # this adds a command 'my-hello' to your environment:
    # (pkgs.writeShellScriptBin "my-hello" ''
    #   echo "Hello, ${config.home.username}!"
    # '')
  ];

  # Managing dotfiles through home.file:
  home.file = {
    # # Building this configuration will create a copy of 'dotfiles/screenrc' in
    # # the Nix store. Activating the configuration will then make '~/.screenrc' a
    # # symlink to the Nix store copy.
    # ".screenrc".source = dotfiles/screenrc;

    ".config/bash/nix-bashrc.sh".text = ''
      # kubectl completions
      source <(kubectl completion bash)
      complete -o default -F __start_kubectl k
      
      # flyctl completions
      source <(flyctl completion bash)
      complete -o default -F __start_flyctl fly
      
      # Add any other Nix-managed bash config here
    '';
  };

  # Home Manager can also manage your environment variables through
  # 'home.sessionVariables'. These will be explicitly sourced when using a
  # shell provided by Home Manager. If you don't want to manage your shell
  # through Home Manager then you have to manually source 'hm-session-vars.sh'
  # located at either
  #  ~/.nix-profile/etc/profile.d/hm-session-vars.sh
  # or
  #  ~/.local/state/nix/profiles/profile/etc/profile.d/hm-session-vars.sh
  # or
  #  /etc/profiles/per-user/chainstarters/etc/profile.d/hm-session-vars.sh

  home.sessionVariables = {
    NIX_HOME = "$HOME/.config/home-manager/home.nix";
    EDITOR = "vim";
    KUBE_EDITOR = "cursor --wait";
    # CURSOR_FLAGS = "--no-sandbox";

    # sensitive
  };

  # can't do this - existing .bashrc would be clobbered
  # programs.bash = {};

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;

  programs = {
    # direnv = {
    #   enable = true; # TODO what is this? does it work?
    # };
  };
}


# in ~/.bashrc:
# nix home-manager session variables
# if [ -d "/nix" ]; then
#     unset __HM_SESS_VARS_SOURCED
#     . "$HOME/.nix-profile/etc/profile.d/hm-session-vars.sh"
#     . "$HOME/.config/bash/nix-bashrc.sh"
# fi


## how to update nix package manager
# sudo su
# nix-env --install --file '<nixpkgs>' --attr nix cacert -I nixpkgs=channel:nixpkgs-unstable
# systemctl daemon-reload
# systemctl restart nix-daemon

