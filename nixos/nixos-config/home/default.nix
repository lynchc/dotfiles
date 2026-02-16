{ vars, pkgs, ... }:

{
  imports = [
    ./direnv
    ./dunst
    ./feh
    ./git
    ./gtk
    ./hyprland
    ./lock
    ./scripts
    ./shell
    ./swappy
    ./waybar
    ./wofi
    ./zellij
  ];

  nixpkgs = {
    config = {
      allowUnfree = true;
      allowUnfreePredicate = _: true;
    };
  };

  home = {
    username = "${vars.user}";
    homeDirectory = "/home/${vars.user}";
    packages = with pkgs; [
      #(callPackage ../derivations/dbvisualizer.nix { })
      #mine
      vim
      vimPlugins.Vundle-vim
      _1password-gui
      arandr
      aws-vault
      alsa-utils
      blueman
      bluez
      bluez-tools
      blueman
      btop
      caffeine-ng
      chromium
      delta
      dialog
      docker
      dunst
      feh
      flameshot
      foliate
      freecad
      kicad
      ghostty
      qastools
      high-tide
      galculator
      gnome-keyring
      gnumake
      google-cloud-sdk
      google-chrome
      htop
      i3
      i3status
      iftop
      jq
      kitty
      keepass
      keybase
      keybase-gui
      less
      libinput
      libreoffice
      lm_sensors
      lsof
      neovim
      nettools
      netcat-gnu
      networkmanagerapplet
      nmap
      #matterhorn
      onionshare-gui
      orca-slicer
      pango
      pcmanfm
      prismlauncher
      qemu
      quasselClient
      ripgrep
      samba
      screen
      scrub
      seahorse
      signal-desktop
      slack
      speedtest-cli
      sqlite
      sqlite-analyzer
      strace
      sysdig
      tcpdump
      termite
      terminus_font
      terragrunt
      tintin
      tor
      tor-browser
      traceroute
      ubuntu-classic
      unetbootin
      unzip
      usbutils
      waydroid
      weston
      wireguard-tools
      xbindkeys
      xbindkeys-config
      xorg.xinput
      xorg.xcalc
      xorg.xbacklight
      yubikey-personalization
      yubico-piv-tool
      yubikey-manager
      yubioath-flutter
      zoom-us

      #dev tools
      android-tools
      bazel
      git
      gcc
      jsonnet
      mercurial
      pkgs.vscode-extensions.vadimcn.vscode-lldb
      python3
      rustup
      sqlx-cli
      vagrant
      vscodium-fhs
      wipe
      wdisplays
      wireshark
      xterm
      yamllint

      bat
      beeper
      bemenu
      bluez
      brightnessctl
      chromium
      coreutils-full
      dbeaver-bin
      difftastic
      discord
      eza
      fastfetch
      fd
      firefox
      flyctl
      google-cloud-sdk
      gamemode
      google-chrome
      gotop
      grim
      groff
      haskellPackages.git-mediate
      httpie
      hyprlock
      hyprpaper
      hyprpicker
      jdk17
      kooha
      mitmproxy
      mullvad-vpn
      ncdu
      neovide
      ngrok
      nix-your-shell
      ollama
      pavucontrol
      pgadmin4
      playerctl
      powertop
      ripgrep
      slack
      slurp
      swappy
      swaylock-effects
      telegram-desktop
      tlrc
      vlc
      vscode.fhs
      wl-clipboard
      xdotool
      zathura
      zoom-us

      # fonts
      cascadia-code
      dejavu_fonts
      fira-code
      nerd-fonts.jetbrains-mono
      material-design-icons
      material-icons
      material-symbols
      nerd-fonts.ubuntu
      powerline-fonts
      sarasa-gothic
      siji
    ];
    file."code/.keep".text = "";
    file.".icons/default".source = "${pkgs.vanilla-dmz}/share/icons/Vanilla-DMZ";
  };

  fonts.fontconfig.enable = true;

  programs.home-manager.enable = true;

  # Nicely reload system units when changing configs
  systemd.user.startServices = "sd-switch";

  # https://nixos.wiki/wiki/FAQ/When_do_I_update_stateVersion
  home.stateVersion = "25.11";
}
