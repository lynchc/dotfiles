{
  # don't use nix-darwin. it's been a disaster
  description = "flake to install pkgs in either darwin or linux through nix profile only";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-25.05";
    nixpkgs-unstable.url = "github:NixOS/nixpkgs/nixos-unstable";
    #nixpkgs-k8s.url = "github:NixOS/nixpkgs/1c1c9b3f5ec0421eaa0f22746295466ee6a8d48f"; # 1.30
  };

  outputs = inputs: let
    # Define some variables to make handling platform specifics easier.
    linux = {
      displayName = "linux";
      architecture = "x86_64-linux";
    };
    mac = {
      displayName = "mac";
      architecture = "aarch64-darwin";
    };

    # Helper function. Call it with one of the above objects.
    # It will call the system specific`buildEnv` function with a name
    # reflecting the profile being built and system specific packages.
    buildPackage = {
      displayName,
      architecture,
    } @ platform: let
      pkgs = inputs.nixpkgs.legacyPackages.${architecture};
      #pkgs-k8s = inputs.nixpkgs-k8s.legacyPackages.${architecture};
      unstablePkgs = inputs.nixpkgs-unstable.legacyPackages.${architecture};
    in {
      default = pkgs.buildEnv {
        name = "dotfile-nix-profile-" + displayName;
        paths = with pkgs;
          [
            arandr
            awscli2
            aws-vault
            cilium-cli
            delta
            dialog # tui dialogs
            direnv
            flameshot
            gh
            #ghostty
            gnumake
            google-cloud-sdk
            #globalprotect-openconnect
            #gpclient
            htop
            hub
            hubble
            iftop
            jq
            keybase
            k9s
            kitty
            kubectl
            kubernetes-helm
            less
            lsof
            nettools
            netcat-gnu
            nh
            nmap
            oh-my-zsh
            profont
            qemu
            #quasselClient
            screen
            scrub
            speedtest-cli
            sqlite
            sqlite-analyzer
            sysdig
            tcpdump
            termite
            terminus_font
            terragrunt
            tintin
            tor
            ubuntu_font_family
            unixtools.watch
            unzip
            usbutils
            wireguard-tools
            wl-clipboard
            yubikey-personalization
            yubico-piv-tool

            android-tools
            bazel
            docker
            git
            gcc
            helix
            jsonnet
            pkgs.vscode-extensions.vadimcn.vscode-lldb
            python3
            rustup
            vim
            vimPlugins.Vundle-vim
            vscodium
            vscode
            wget
            wipe
            yamllint
            nodejs_22
            #pkgs.nodePackages.cdktf-cli
            pkgs.nodePackages.npm
            consul
            vault
            nomad

            stow # ln farm
            wezterm
            tmux
            starship #shell prompt
            (unstablePkgs.neovim)
            fzf # fuzzy finder
            lazygit
            ripgrep
            fd
            yazi # tui file manager in rs
            jq
            nodejs_22
            typescript
            nodePackages.nodemon
            vscode-langservers-extracted
            nodePackages.typescript-language-server
            nodePackages.eslint
            prettierd
            lua-language-server
            stylua
            nixd # nix lang server
            alejandra #nix formatter
            zig
          ]
          ++ (
            # NOTE there is pkgs.stdenv.isDarwin
            if platform == mac
            then
              # MAC SPECIFIC
              [aerospace]
            else []
          )
          ++ (
            # NOTE there is pkgs.stdenv.isLinux
            if platform == linux
            then
              # LINUX SPECIFIC
              [
                bpftools
                keybase-gui
                kubernetes
                numactl
                pcmanfm
                strace
                traceroute
                vagrant
                yubikey-personalization-gui
                yubioath-flutter
              ]
            else []
          );
      };
    };
  in {
    packages = {
      ${linux.architecture} = buildPackage linux;
      ${mac.architecture} = buildPackage mac;
    };
  };
}
