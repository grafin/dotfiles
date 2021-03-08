{ pkgs, ... }:

let
  nixpkgs = import <nixpkgs> { };
  nemu = nixpkgs.callPackage ./nemu.nix {
    withDbus = true;
    withNetworkMap = true;
    withSnapshots = true;
    withUTF = true;
  };
in {
  environment.systemPackages = with pkgs; [
    git
    gnupg
    haskellPackages.update-nix-fetchgit
    killall
    nemu
    nix-prefetch-git
    pinentry-gnome
    tmux
    tree
    vim
    wget
  ];

  programs = {
    gnupg = {
      agent = {
        enable = true;
        pinentryFlavor = "gnome3";
      };
    };
  };

  security.wrappers.nemu = {
    source = "${nemu}/bin/nemu";
    capabilities = "cap_net_admin+ep";
    owner = "root";
    group = "root";
    permissions = "u+rx,g+rx,a+rx";
  };
}
