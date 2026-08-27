# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

# NixOS system configuration
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
    /home/boris/dev/github/dotfiles/nixos/secret_vk.nix
    ./minecraft-server.nix
  ];

  # Bootloader and kernel
  boot = {
    loader = {
      efi.canTouchEfiVariables = true;
      systemd-boot = {
        enable = true;
        consoleMode = "keep";
        configurationLimit = 10;
      };
    };
    kernelPackages = pkgs.linuxPackages_latest;
    kernelParams = [ "mitigations=off" ];
  };

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
    xserver = {
      enable = true;
      windowManager.openbox.enable = true;
    };
  };

  # Internationalization and console
  i18n.defaultLocale = "en_US.UTF-8";
  console = {
    font = "Lat2-Terminus16";
    keyMap = "us";
  };

  # Time and location
  time.timeZone = "Europe/Moscow";
  location = {
    provider = "manual";
    latitude = 56.051883;
    longitude = 37.500270;
  };

  # Allow running non-patched binaries
  programs.nix-ld.enable = true;

  # GnuPG agent
  programs.gnupg.agent = {
    enable = true;
    enableSSHSupport = true;
    pinentryPackage = pkgs.pinentry-gnome3;
    #pinentryPackage = pkgs.pinentry-curses;
  };

  # Virtualization
  virtualisation = {
    podman = {
      enable = true;
      dockerCompat = false;
    };
    docker.rootless.enable = true;
  };

  # User and group management
  users = {
    groups.docker = {};
    users.boris = {
      isNormalUser = true;
      home = "/home/boris";
      description = "Demidov Borislav";
      extraGroups = [ "docker" "wheel" ];
    };
  };

  # Nix settings
  nix.settings = {
    auto-optimise-store = true;
    experimental-features = [ "nix-command" "flakes" ];
  };

  # Documentation and debug info
  documentation.dev.enable = true;
  environment.enableDebugInfo = true;

  # Environment variables
  environment.variables.NIX_SHELL_PRESERVE_PROMPT = "true";

  # Security
  security = {
    pam.loginLimits = [{
      domain = "*";
      type = "soft";
      item = "nofile";
      value = "unlimited";
    }];
    sudo.extraRules = [{
      users = [ "boris" ];
      commands = [{
        command = "ALL";
        options = [ "NOPASSWD" ];
      }];
    }];
  };

  # Allow unfree packages
  nixpkgs.config = {
    allowUnfree = true;
    allowUnfreePredicate = pkg: builtins.elem (lib.getName pkg) [
      "minecraft-server-1.20.4"
    ];
  };
}
