# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).
{
  config,
  pkgs,
  ...
}:
{
  imports = [
    # Include the results of the hardware scan.
    ./hardware-configuration.nix
  ];



  # Bootloader.
  boot.loader = {
    efi.canTouchEfiVariables = true;
    grub = {
      enable = true;
      useOSProber = true;
      device = "nodev";
      efiSupport = true;
    };

  };

  # Stylix
  stylix = {
        autoEnable = true;
	  enable = true;
	  base16Scheme = "${pkgs.base16-schemes}/share/themes/gruvbox-dark-medium.yaml";
	  cursor={
	    package = pkgs.bibata-cursors;
	    name = "Bibata-Modern-Ice";
	    size = 8;
	  };
	  fonts = {
	    monospace = {
	      package = pkgs.nerd-fonts.jetbrains-mono;
	      name = "JetBrainsMono Nerd Font Mono";
	    };

	    sansSerif = {
	      package = pkgs.dejavu_fonts;
	      name = "DejaVu Sans";
	    };

	    serif = {
	      package = pkgs.dejavu_fonts;
	      name = "DejaVu Serif";
	    };
	    emoji = {
	      package = pkgs.noto-fonts-color-emoji;
	      name = "Noto Color Emoji";
	    };
	  };

	  fonts.sizes = {
	    applications = 12;
	    terminal = 12;
	    desktop = 12;
	    popups = 12;
	  };

	  opacity = {
	    applications = 1.0;
	    terminal = 1.0;
	    desktop = 1.0;
	    popups = 1.0;
	  };

	  polarity = "either";
  };

  
  

 # Use latest kernel.
  boot.kernelPackages = pkgs.linuxPackages_latest;


  networking.hostName = "nixos"; # Define your hostname.
  # networking.wireless = {
  #	enable = true;
  #	 networks = {
  #		"Jio 508 5GHz" = {
  #				psk = "Satyam@13";
  #				    };
  #		};
  #			};  # Enables wireless support via wpa_supplicant
  # Configure network proxy if necessary
  # networking.proxy.default = "http://user:password@proxy:port/";
  # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";

  # Flakes
  nix.settings.experimental-features = ["nix-command" "flakes"];

  # Enable networking
  networking.networkmanager.enable = true;

  # Set your time zone.
  time.timeZone = "Asia/Kolkata";

  # Select internationalisation properties.
  i18n.defaultLocale = "en_IN";

  i18n.extraLocaleSettings = {
    LC_ADDRESS = "en_IN";
    LC_IDENTIFICATION = "en_IN";
    LC_MEASUREMENT = "en_IN";
    LC_MONETARY = "en_IN";
    LC_NAME = "en_IN";
    LC_NUMERIC = "en_IN";
    LC_PAPER = "en_IN";
    LC_TELEPHONE = "en_IN";
    LC_TIME = "en_IN";
  };

  # Enable the X11 windowing system.
  # You can disable this if you're only using the Wayland session.
  services.xserver.enable = true;

  # Enabling Flatpak delete after Stremio stabilizes
  # services.flatpak.enable = true;
  # systemd.services.flatpak-repo = {
  #   wantedBy = ["multi-user.target"];
  #   path = [pkgs.flatpak];
  #   script = ''
  #     flatpak remote-add --if-not-exists flathub https://flathub.org/repo/flathub.flatpakrepo
  #   '';
  # };

  # Enable 32bit Support for Epic games
  hardware.graphics.enable32Bit = true;

  # Enable the KDE Plasma Desktop Environment.
  services.displayManager.sddm.enable = true;
  services.desktopManager.plasma6.enable = true;

  # Configure keymap in X11
  services.xserver.xkb = {
    layout = "us";
    variant = "";
  };

  # Enable CUPS to print documents.
  services.printing = {
    enable = true;
    drivers = [pkgs.epson-escpr];
    browsing = true;
    defaultShared = true;
  };

  services.blueman.enable = true;
  services.gnome.gnome-keyring.enable = true;

  hardware.bluetooth.enable = true;

  # Enable sound with pipewire.
  services.pulseaudio.enable = false;
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
    # If you want to use JACK applications, uncomment this
    jack.enable = true;

    # use the example session manager (no others are packaged yet so this is enabled by default,
    # no need to redefine it in your config for now)
    #media-session.enable = true;
  };

  # Enable touchpad support (enabled default in most desktopManager).
  services.libinput.enable = true;

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.shaswat = {
    isNormalUser = true;
    description = "Shaswat";
    extraGroups = ["networkmanager" "wheel"];
    packages = with pkgs; [
      kdePackages.kate
    ];
  };

  # Install firefox.
  programs.firefox.enable = true;

  # Manage Neovim
  # programs.neovim = {
  #   defaultEditor = true;
  #   enable = true;
  #   viAlias = true;
  #   vimAlias = true;
  # };
  

  programs.steam.enable = true;
  programs.steam.gamescopeSession.enable = true;

  programs.gamemode.enable = true;

  programs.hyprland = {
    enable = true;
    xwayland.enable = true;
  };

  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;

  services.locate = {
    enable = true;
    package = pkgs.mlocate;
  };

  xdg.portal.enable = true;
  xdg.portal.extraPortals = [pkgs.xdg-desktop-portal-gtk];

  environment.sessionVariables = {
    STEAM_EXTRA_COMPAT_TOOLS_PATHS = "/home/user/.steam/root/compatibilitytools.d";
  };

  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages = with pkgs; [

    # Desktop Environment
    walker
    pavucontrol
    pipewire
    playerctl
    rofi
    scrot
    home-manager

    ## Wayland 
    waybar
    wget
    wl-clipboard
    wlroots
    xdg-desktop-portal-hyprland
    xdg-desktop-portal-gtk
    xwayland
    firefox
    wl-color-picker
    wofi

    ## Notification
    ags
    swaynotificationcenter
    mako
    libnotify
    eww
    wofi
    brightnessctl

    ## Hyprland
    hyprland
    hyprshot
    waypaper
    hyprpaper
    hyprpicker

    ## Wallpaper
    swww
    mpvpaper

    vim # Do not forget to add an editor to edit configuration.nix! The Nano editor is also installed by default.

    # Secret Manager
    gnome-keyring
    libsecret
    polkit_gnome

    ## Network Manager
    networkmanagerapplet
    blueman

    # Application Software

    ## Programming Lanaguage
    git
    podman
    gh
    vscodium

    #### Lua
    lua


    #### JavaScript
    nodejs
    pnpm

    #### C
    gcc

    #### Python
    meson

    ## GUI
    kitty
    ghostty
    thunderbird
    qbittorrent
    tor
    librewolf
    brave
    obsidian
    jrnl
    anki
    fontpreview
    libreoffice

    # stremio

    # Games
    openrct2
    openloco
    steam-run

    ## CLI
    wget
    alejandra
    brillo
    tldr
    trash-cli
    fd
    unzip
    unrar
    virt-viewer

    ## TUI Games
    nethack


    ## TUI

    fzf
    yazi
    lsd
    lazygit
    discordo
    btop
    bluetui
    impala
    wiremix
    lynx 
    ncdu
    posting
    caligula
    gophertube
    qutebrowser


    # System Software
    libvirt
    mpv


    # Gaming
    heroic
    lutris
    mangohud
    steam
    protonup-ng
    wine64

  ];


  environment.sessionVariables = {
    # Hint electron apps to use wayland
    NIXOS_OZONE_WL = "1";
  };

  hardware = {
    nvidia.modesetting.enable = true;
  };

  # Until Stremio Gets Secure
  # nixpkgs.config.permittedInsecurePackages = [
  #   "qtwebengine-5.15.19"
  # ];

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


  # Auto Updates
  system.autoUpgrade.enable = true;
  system.autoUpgrade.allowReboot = true;

  # Garbage Collection
  nix.gc.automatic = true;
  nix.gc.dates = "weekly";
  nix.gc.options = "--delete-older-than 10d";
  nix.settings.auto-optimise-store = true;

  # Open ports in the firewall.
  # networking.firewall.allowedTCPPorts = [ ... ];
  # networking.firewall.allowedUDPPorts = [ ... ];
  # Or disable the firewall altogether.
  # networking.firewall.enable = false;

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "25.05"; # Did you read the comment?
}
