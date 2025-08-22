# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, ... }:

{
  imports =
    [ # Include the results of the hardware scan.
      ./hardware-configuration.nix
    ];

  nix.extraOptions = ''experimental-features = nix-command flakes'';

  # Bootloader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;
  boot.loader.efi.efiSysMountPoint = "/boot/efi";

  # Setup keyfile
  boot.initrd.secrets = {
    "/crypto_keyfile.bin" = null;
  };

  # Enable swap on luks
  boot.initrd.luks.devices."luks-ef6d51cd-5289-4817-bebc-c0226e09421c".device = "/dev/disk/by-uuid/ef6d51cd-5289-4817-bebc-c0226e09421c";
  boot.initrd.luks.devices."luks-ef6d51cd-5289-4817-bebc-c0226e09421c".keyFile = "/crypto_keyfile.bin";

  boot.extraModprobeConfig = ''
    options snd slots=snd-hda-intel
    options snd_hda_intel enable=0,1
  '';

  networking.hostName = "mini-nixos"; # Define your hostname.
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
  users.users.lynchc = {
    isNormalUser = true;
    description = "lynchc";
    extraGroups = [ "networkmanager" "wheel" "docker" "audio"];
    packages = with pkgs; [];
  };

  #sound.enable = true;
  #hardware.pulseaudio.enable = true;
  #hardware.pulseaudio.support32Bit = true; 
  #nixpkgs.config.pulseaudio = true;
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
    # If you want to use JACK applications, uncomment this
    #jack.enable = true;
  };
  programs.nix-ld.enable = true;
  programs.nix-ld.libraries = with pkgs; [
    libpulseaudio
  ];

  virtualisation.waydroid.enable = true;
  virtualisation.docker.enable = true;

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
    alsa-oss
    bitwarden
    bluez
    bluez-tools
    blueman
    caffeine-ng
    chromium
    cura-appimage
    dialog
    dunst
    firefox-bin
    flameshot
    foliate
    freecad
    galculator
    gh
    ghostty
    globalprotect-openconnect
    gnome-keyring
    gnumake
    google-cloud-sdk
    google-chrome
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
    libinput
    libreoffice
    lsof
    nettools
    netcat-gnu
    nmap
    numactl
    #matterhorn
    onionshare
    onionshare-gui
    orca-slicer
    pango
    pcmanfm
    prismlauncher
    profont
    qemu
    quasselClient
    samba
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
    tor-browser-bundle-bin
    traceroute
    ubuntu_font_family
    unetbootin
    usbutils
    warp-terminal
    #waydroid
    weston
    wireguard-tools
    wl-clipboard
    xorg.xinput
    yubikey-personalization
    yubikey-personalization-gui
    yubico-piv-tool
    yubioath-flutter
    zoom-us

    #dev tools
    android-tools
    bazel
    git
    gcc
    jsonnet
    mercurial
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
      ];
    };
  };

  programs.i3lock.enable = true;
  programs.sway.enable = true;
  systemd.targets.sleep.enable = false;
  systemd.targets.suspend.enable = false;
  systemd.targets.hibernate.enable = false;
  systemd.targets.hybrid-sleep.enable = false;
  powerManagement.enable = false;
  services.logind.lidSwitch = "ignore";

#services.openssh = {
#  enable = true;
#  ports = [ 22 ];
#  settings = {
#    PasswordAuthentication = true;
#    AllowUsers = null; # Allows all users by default. Can be [ "user1" "user2" ]
#    UseDns = true;
#    X11Forwarding = false;
#    PermitRootLogin = "prohibit-password"; # "yes", "without-password", "prohibit-password", "forced-commands-only", "no"
#  };
#};
}
