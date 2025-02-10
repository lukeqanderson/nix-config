# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, lib, inputs, main-user, ... }:
{
  imports = [
    ./hardware-configuration.nix
    inputs.home-manager.nixosModules.default
    ( import ../../modules/bundles/system-module-bundle.nix 
      {
        default-user = "luke";
        host-name = "nixlaptop";
	time-zone = "America/Los_Angeles";
	locale = "en_US.UTF-8";
	luks-link = "luks-7949dacf-5185-4d08-9e97-a9523f2959bd";
	luks-disk-link = "/dev/disk/by-uuid/7949dacf-5185-4d08-9e97-a9523f2959bd";
      }
    )
  ];

  bluetooth-module.enable = true;

  networking-module.enable = true;
  
  xserver-module.enable = true;

  auto-login-module.enable = true;

  portal-module.enable = true;

  systemd-boot-module.enable = true;

  luks-module.enable = true;

  time-zone-module.enable = true;

  locale-module.enable = true;

  #boot.initrd.luks.devices."luks-7949dacf-5185-4d08-9e97-a9523f2959bd".device = "/dev/disk/by-uuid/7949dacf-5185-4d08-9e97-a9523f2959bd";

  # Define a user account. Don't forget to set a password with ‘passwd’. 
  users.users."luke" = {
    isNormalUser = true;
    description = "admin user";
    extraGroups = [ 
      "wheel" 
      "networkmanager" 
      "systemd-journal"
    ];
    packages = with pkgs; [

    ];
  };

  # Home-manger setup 
  home-manager = {
    extraSpecialArgs = { inherit inputs; };
    users = {
      "luke" = import ./home.nix;
    };
  };

  # Allow unfree packages
  nixpkgs = {
    config = {
      allowUnfree = true;
    };
  };

  # Allow experimental features
  nix.settings.experimental-features = ["nix-command" "flakes"];

  # Enable hyprland
  programs = {
    hyprland = {
      enable = true;
      withUWSM = true;
      xwayland = {
        enable = true;
      };
    };
    waybar = {
      enable = true;
      package = pkgs.waybar.overrideAttrs (oldAttrs: {
        mesonFlags = oldAttrs.mesonFlags ++ [ "-Dexperimental=true" ];
      });
    };
  };

  # Security
  security = {
    pam.services.swaylock = {
      text = ''
        auth include login
      '';
    };
    rtkit.enable = true;
  };

  # Services
  services = {

    dbus.enable = true;

    gvfs.enable = true;

    tumbler.enable = true;

    # Enable gnome
    gnome = {
      gnome-keyring.enable = true;
    };

    # Enable sound with pipewire
    pipewire = {
      enable = true;
      alsa.enable = true;
      alsa.support32Bit = true;
      pulse.enable = true;
      jack.enable = true;
    };

    # Enable touchpad support
    libinput.enable = true;

    # Enable the OpenSSH daemon.
    openssh.enable = true;

  };

  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages = with pkgs; [
    ( import ../../scripts/display/hyprland/hyprland-startup.nix { inherit pkgs; } )
    ( import ../../scripts/display/wallpaper/animated-wallpaper.nix { inherit pkgs; } )
    vim 
    polkit_gnome
    adwaita-icon-theme
    gnome-themes-extra
    gsettings-desktop-schemas
    swaynotificationcenter
    wlr-randr
    libva-utils
    fuseiso
    udiskie
    ydotool
    swayidle
    swaylock
    xdg-desktop-portal-hyprland
    hyprpaper
    wofi
    neovim 
    wget
    waybar
    mako
    libnotify
    mpvpaper
    grim
    xdg-utils
    xdg-desktop-portal
    xdg-desktop-portal-gtk
    qt5.qtwayland
    qt6.qmake
    qt6.qtwayland
    adwaita-qt
    adwaita-qt6
    git
    alacritty
    rofi-wayland
    hyprland
    firefox-wayland
    anki
    tree
    pavucontrol
    displaylink
    xwayland
    discord-canary
    betterdiscordctl
    toybox
    fd
  ];

  # Install fonts
  fonts.fontDir.enable = true;
  fonts.packages = with pkgs; [
    nerd-fonts.hack
    font-awesome
    google-fonts
  ];

  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  # programs.mtr.enable = true;
  programs.gnupg.agent = {
    enable = true;
    enableSSHSupport = true;
  };

  
  environment.sessionVariables = {
    POLKIT_AUTH_AGENT = "${pkgs.polkit_gnome}/libexec/polkit-gnome-authentication-agent-1";
    GSETTINGS_SCHEMA_DIR = "${pkgs.gsettings-desktop-schemas}/share/gsettings-schemas/${pkgs.gsettings-desktop-schemas.name}/glib-2.0/schemas";
    XDG_SESSION_TYPE = "wayland";
    MOZ_ENABLE_WAYLAND = "1";
    SDL_VIDEODRIVER = "wayland";
    _JAVA_AWT_WM_NONREPARENTING = "1";
    CLUTTER_BACKEND = "wayland";
    WLR_RENDERER = "vulkan";
    XDG_CURRENT_DESKTOP = "Hyprland";
    XDG_SESSION_DESKTOP = "Hyprland";
    GTK_USE_PORTAL = "1";
    NIXOS_XDG_OPEN_USE_PORTAL = "1";
  };

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "unstable"; # Did you read the comment?

}
