{ pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    git
    gnupg
    haskellPackages.update-nix-fetchgit
    killall
    nix-prefetch-git
    tigervnc
    tmux
    tree
    vim
    virtviewer
    wget
  ];

  imports = [
    ./nemu/nemu.nix
    ./nemu/nemu-veth.nix
  ];
}
