{ pkgs, config, ... }:

let
  nixpkgs = import <nixpkgs> { config = config.nixpkgs.config; };
  schroot = nixpkgs.callPackage ./pkgs/schroot.nix { };
in {
  environment.systemPackages = with pkgs; [
    schroot
  ];

  security.wrappers.schroot = {
    source = "${schroot}/bin/schroot";
    setuid = true;
    owner = "root";
    group = "root";
    permissions = "u+rx,g+rx,a+rx";
  };

  security.pam.services.schroot = {
    rootOK = true;
  };

  environment.etc."schroot/chroot.d/debian9.amd64.buildd" = {
    text = ''
[debian9.amd64.buildd]
description=Debian 9 Stretch amd64
directory=/var/lib/sandboxes/debian9.amd64.buildd
personality=linux
root-users=boris
type=directory
users=boris
    '';

    mode = "0444";
  };

  environment.etc."schroot/chroot.d/debian10.amd64.buildd" = {
    text = ''
[debian10.amd64.buildd]
description=Debian 10 Buster amd64
directory=/var/lib/sandboxes/debian10.amd64.buildd
personality=linux
root-users=boris
type=directory
users=boris
    '';

    mode = "0444";
  };
}
