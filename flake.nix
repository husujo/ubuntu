{
  inputs.nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";

  #nixConfig = {
  #  extra-substituters = ["https://<name>.cachix.org"];
  #  extra-trusted-public-keys = ["<name>.cachix.org-1:<pub-key>"];
  #};

  outputs = { nixpkgs, ... }:
    let
      system = "x86_64-linux";
      pkgs = import nixpkgs { inherit system; config.allowUnfree = true; };

      cliTools = with pkgs; [
        # kubectl
        # kubectx
        # (wrapHelm kubernetes-helm {
        #   plugins = [ kubernetes-helmPlugins.helm-cm-push ];
        # })
        # argocd
        # google-cloud-sdk
        # doctl
        # flyctl
        # s3cmd
        # opencode
        # gemini-cli
        rclone
        gh
        ngrok
        rustup
        bun
	    # deno
        # nodejs_24
        # expect
        # yamllint
        # yq
        # ripgrep
        # ollama-cuda (doesn't work)
        # <other>.packages.${system}.<name>
      ];
    in {
      packages.${system}.default = pkgs.buildEnv {
        name = "cli-tools";
        paths = cliTools;
      };
    };
}

## how to update nix package manager
# sudo su
# nix-env --install --file '<nixpkgs>' --attr nix cacert -I nixpkgs=channel:nixpkgs-unstable
# systemctl daemon-reload
# systemctl restart nix-daemon
