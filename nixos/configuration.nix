# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, lib, ... }:

{
  imports = [
      ./hardware-configuration.nix
      ./network.nix
      ./www.nix
      ./remote.nix
      ./packages/default.nix
    ];

  # Use systemd-boot EFI boot loader.
  boot.loader = {
    efi.canTouchEfiVariables = true;
    systemd-boot = {
      enable = true;
      consoleMode = "keep";
      configurationLimit = 10;
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
  system.stateVersion = "22.05"; # Did you read the comment?

  # Services
  services = {
    openssh = {
      enable = true;
      forwardX11 = true;
      passwordAuthentication = false;
      kbdInteractiveAuthentication = false;
    };
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
    pinentryFlavor = "tty";
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

  nix.settings.auto-optimise-store = true;

  # Man
  documentation.dev.enable = true;
}
