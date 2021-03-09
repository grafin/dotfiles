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
    tmux
    tree
    vim
    wget
  ];

  security.wrappers.nemu = {
    source = "${nemu}/bin/nemu";
    capabilities = "cap_net_admin+ep";
    owner = "root";
    group = "root";
    permissions = "u+rx,g+rx,a+rx";
  };

  systemd.services.nemu-veth = {
    description = "Service, which creates nemu's veth interfaces";
    before = [ "network-pre.target" ];
    serviceConfig = {
      Type = "oneshot";
      User = "boris";
      ExecStart = "/run/wrappers/bin/nemu -c";
    };
    wantedBy = [ "multi-user.target" ];
  };
}
