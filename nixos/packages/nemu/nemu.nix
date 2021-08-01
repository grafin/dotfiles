{ config, pkgs, ... }:

let
  nixpkgs = import <nixpkgs> { config = config.nixpkgs.config; };

  nemu = nixpkgs.callPackage ./pkgs/nemu.nix {
    withDbus = true;
    withNetworkMap = true;
    withUTF = true;
    withRemote = true;
  };
in {

  imports = [
    ./module.nix
  ];

  programs.nemu = {
    package = nemu;
    enable = true;
    vhostNetGroup = "vhost";
    macvtapGroup = "vhost";
    usbGroup = "usb";
    users = {
      boris = {
        autoAddVeth = true;
        autoStartVMs = [
          "CentOS-ViPNet"
          "Minecraft"
          "Windows-ViPNet"
        ];
      };
    };
  };
}
