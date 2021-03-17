{ config, pkgs, ... }:

let
  nixpkgs = import <nixpkgs> { config = config.nixpkgs.config; };
  jitsi = nixpkgs.callPackage ./pkgs/jitsi.nix { };
in {
  environment.systemPackages = with pkgs; [
    jitsi
  ];
}
