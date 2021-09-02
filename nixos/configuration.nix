# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, lib, ... }:

{
  imports = [
      ./hardware-configuration.nix
      ./boot/systemd-boot.nix
      ./network.nix
      ./fonts.nix
      ./i3.nix
      ./packages/default.nix
      ./packages/gui/default.nix
      ./remote.nix
      ./secret.nix
    ];

  # Use systemd-boot EFI boot loader.
  boot.loader = {
    efi.canTouchEfiVariables = true;
    systemd-boot = {
      enable = true;
      consoleMode = "keep";
      configurationLimit = 10;
      signed = true;
      signing-key = "/root/secure-boot/db.key";
      signing-certificate = "/root/secure-boot/db.crt";
    };
  };

  # Linux kernel
  boot.kernelPackages = pkgs.linuxPackages_latest;

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "20.09"; # Did you read the comment?

  # Sound
  sound.enable = true;
  hardware = {
    pulseaudio = {
      enable = true;
      support32Bit = true;
    };
  };

  # Services
  services = {
    logind.extraConfig = ''
      HandlePowerKey=suspend
      IdleAction=suspend
      IdleActionSec=30min
    '';
    openssh = {
      enable = true;
      forwardX11 = true;
      passwordAuthentication = false;
      challengeResponseAuthentication = false;
    };
    printing = {
      enable = true;
      drivers = with pkgs; [
        cnijfilter2
        cups-filters
        gutenprint
      ];
    };
    devmon.enable = true;
    fail2ban.enable = true;
  };

  # Internationalisation properties.
  i18n.defaultLocale = "en_US.UTF-8";

  # Console
  console = {
    font = "Lat2-Terminus16";
    keyMap = "us";
  };

  # Time zone and location
  time.timeZone = "Europe/Moscow";
  location = {
    provider = "manual";
    latitude = 56.051883;
    longitude = 37.500270;
  };

  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  programs.gnupg.agent = {
    enable = true;
    enableSSHSupport = true;
    pinentryFlavor = "gnome3";
  };

  # Podman
  virtualisation = {
    podman = {
      enable = true;
      dockerCompat = true;
    };
  };

  # Users
  users.users.boris = {
    isNormalUser = true;
    home = "/home/boris";
    description = "Stepanenko Boris";
    extraGroups = [
      "wheel"
    ];
  };

  # Packages
  nixpkgs.config.allowUnfreePredicate = pkg: builtins.elem (lib.getName pkg) [
    "android-studio-stable"
    "cnijfilter2"
    "discord"
    "geogebra"
    "skypeforlinux"
    "sublime-merge"
    "sublimetext4"
    "unityhub"
    "yEd"
    "zoom"
  ];
  environment.systemPackages = with pkgs; [
    home-manager
  ];
  nix.autoOptimiseStore = true;

  # Man
  documentation.dev.enable = true;
}
