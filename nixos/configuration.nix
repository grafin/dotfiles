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
      ./pproxy.nix
      ./kafka.nix
      ./secret_vk.nix
      ./minecraft-server.nix
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
  boot.kernelParams = [
    "mitigations=off"
  ];

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
      settings = {
        X11Forwarding = true;
        PasswordAuthentication = false;
        KbdInteractiveAuthentication = false;
      };
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
    #pinentryPackage = pkgs.pinentry-gtk2;
    pinentryPackage = pkgs.pinentry-curses;
  };

  # Podman
  virtualisation = {
    podman = {
      enable = true;
      dockerCompat = false;
    };
    docker = {
      rootless = {
        enable = true;
      };
    };
  };

  # Groups
  users.groups = {
    docker = { };
  };

  # Users
  users.users.boris = {
    isNormalUser = true;
    home = "/home/boris";
    description = "Demidov Borislav";
    extraGroups = [
      "docker"
      "wheel"
    ];
  };

  nix.settings.auto-optimise-store = true;

  # Man
  documentation.dev.enable = true;

  # Debug symbols
  environment.enableDebugInfo = true;

  environment.variables = {
    NIX_SHELL_PRESERVE_PROMPT = "true";
  };

  security.pam.loginLimits = [{
    domain = "*";
    type = "soft";
    item = "nofile";
    value = "unlimited";
  }];

  security.sudo.extraRules= [{
    users = [ "boris" ];
    commands = [{
      command = "ALL";
      options= [ "NOPASSWD" ];
    }];
  }];

  nixpkgs.config.allowUnfree = true;
  nixpkgs.config.allowUnfreePredicate = pkg: builtins.elem (lib.getName pkg) [
   "minecraft-server-1.20.4"
  ];
}
