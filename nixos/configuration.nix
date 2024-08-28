# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, ... }:

{
  imports =
    [ # Include the results of the hardware scan.
      ./hardware-configuration.nix
    ];

  # Bootloader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  networking.hostName = "rbx-nixos"; # Define your hostname.
  # networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.

  # Configure network proxy if necessary
  # networking.proxy.default = "http://user:password@proxy:port/";
  # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";

  # Enable networking
  networking.networkmanager.enable = true;

  # Set your time zone.
  time.timeZone = "America/Los_Angeles";

  # Select internationalisation properties.
  i18n.defaultLocale = "en_US.UTF-8";

  i18n.extraLocaleSettings = {
    LC_ADDRESS = "en_US.UTF-8";
    LC_IDENTIFICATION = "en_US.UTF-8";
    LC_MEASUREMENT = "en_US.UTF-8";
    LC_MONETARY = "en_US.UTF-8";
    LC_NAME = "en_US.UTF-8";
    LC_NUMERIC = "en_US.UTF-8";
    LC_PAPER = "en_US.UTF-8";
    LC_TELEPHONE = "en_US.UTF-8";
    LC_TIME = "en_US.UTF-8";
  };

  # Configure keymap in X11
  services.xserver = {
    layout = "us";
    xkbVariant = "";
  };

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.lynch = {
    isNormalUser = true;
    description = "lynch";
    extraGroups = [ "networkmanager" "wheel" "docker" ];
    packages = with pkgs; [
      pkgs.nodePackages.cdktf-cli
      pkgs.nodePackages.npm
      nodejs_18
      awscli2
      x11docker
      tenv
      screen
      helix
      gh
    ];
  };

  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;

  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages = with pkgs; [
    vim # Do not forget to add an editor to edit configuration.nix! The Nano editor is also installed by default.
    vimPlugins.Vundle-vim
    wget
  _1password-gui
    arandr
    aws-vault
    alsa-utils
    bitwarden
    bluez
    bluez-tools
    blueman
    caffeine-ng
    chromium
    delta
    dialog
    docker
    dunst
    firefox-bin
    flameshot
    foliate
    galculator
    #globalprotect-openconnect
    #gnome.gnome-keyring
    gnumake
    google-cloud-sdk
    google-chrome
    gqview
    htop
    home-manager
    hub
    i3
    i3status
    iftop
    jq
    keepass
    keybase
    keybase-gui
    kitty
    less
    libinput
    libreoffice
    lm_sensors
    lsof
    nettools
    netcat-gnu
    nmap
    matterhorn
    mandoc
    onionshare
    onionshare-gui
    pango
    pcmanfm
    prismlauncher
    profont
    qemu
    quasselClient
    ripgrep
    samba
    screen
    scrub
    gnome.seahorse
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
  tor-browser-bundle-bin
    traceroute
    ubuntu_font_family
    unetbootin
    unzip
    usbutils
    waydroid
    weston
    wireguard-tools
    xorg.xinput
    yubikey-personalization
    yubikey-personalization-gui
    yubico-piv-tool
    yubikey-manager
    yubikey-manager-qt
    yubioath-flutter
    zoom-us

    #dev tools
    android-tools
    #dep
    git
    gcc
    jsonnet
    mercurial
    pkgs.vscode-extensions.vadimcn.vscode-lldb
    python3
    rustup
    vagrant
    virtualbox
    vscodium
    wipe
    wireshark
    xterm
    yamllint
  ];
  #Support packages for yubi to work
  services.udev.packages = with pkgs; [
    yubikey-personalization
    yubico-piv-tool
    yubikey-manager
  ];
  services.pcscd.enable = true;
  services.ntp.enable = true;

  # Enable ZRAM
  zramSwap = {
    enable = true;
    algorithm = "zstd";
  };

  # Enable CUPS to print documents.
  services.printing.enable = true;
  services.printing.drivers = [ pkgs.mfcl3770cdwlpr ];
  services.avahi = {
    enable = true;
    nssmdns = true;
    openFirewall = true;
  };

  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  # programs.mtr.enable = true;
  # programs.gnupg.agent = {
  #   enable = true;
  #   enableSSHSupport = true;
  # };

  # List services that you want to enable:

  # Enable the OpenSSH daemon.
  # services.openssh.enable = true;

  # Open ports in the firewall.
  # networking.firewall.allowedTCPPorts = [ ... ];
  # networking.firewall.allowedUDPPorts = [ ... ];
  # Or disable the firewall altogether.
  # networking.firewall.enable = false;
  networking.firewall.enable = false;
  networking.enableIPv6 = false;

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "22.11"; # Did you read the comment?

  services.keybase.enable = true;
  services.kbfs.enable = true;
  services.xserver = {
    enable = true;
    desktopManager = {
      xterm.enable = false;
    };
    displayManager = {
      defaultSession = "none+i3";
    };
    windowManager.i3 = {
      enable = true;
      extraPackages = with pkgs; [
        dmenu
        i3status
        i3lock
      ];
    };
  };

  programs.sway.enable = true;
  systemd.targets.sleep.enable = false;
  systemd.targets.suspend.enable = false;
  systemd.targets.hibernate.enable = false;
  systemd.targets.hybrid-sleep.enable = false;
  powerManagement.enable = false;
  services.logind.lidSwitch = "ignore";

  virtualisation.docker.enable = true;
  virtualisation.docker.rootless = {
    enable = true;
    setSocketVariable = true;
  };

  services.globalprotect.enable = true;

  services.gnome.gnome-keyring.enable = true;
  programs.seahorse.enable = true; # enable the graphical frontend
  programs.dconf.enable = true;
  # programs = { seahorse.enable = true; dconf. }
  #services.gnome-keyring = {
  #  enable = true;
  #  components = [ "secrets" ];
  #};

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  #system.stateVersion = "24.05"; # Did you read the comment?

}
