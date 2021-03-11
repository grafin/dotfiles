{ pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    git
    gnupg
    haskellPackages.update-nix-fetchgit
    killall
    nix-prefetch-git
    tmux
    tree
    vim
    wget
  ];

  imports = [
    ./nemu/nemu.nix
    ./nemu/nemu-veth.nix
  ];
}
