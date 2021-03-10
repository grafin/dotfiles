{ config, pkgs, ... }:

let
  # We need to do this, because tigervnc pakage includes some unfree fonts...
  unfreeConfig = config.nixpkgs.config // {
    allowUnfree = true;
  };

  nixpkgs = import <nixpkgs> { config = unfreeConfig; };

  nemu = nixpkgs.callPackage ./pkgs/nemu.nix {
    withDbus = true;
    withNetworkMap = true;
    withSnapshots = true;
    withUTF = true;
  };
in {
  environment.systemPackages = with pkgs; [
    nemu
  ];

  security.wrappers.nemu = {
    source = "${nemu}/bin/nemu";
    capabilities = "cap_net_admin+ep";
    owner = "root";
    group = "root";
    permissions = "u+rx,g+rx,a+rx";
  };
}
