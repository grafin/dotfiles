{ pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    git
    haskellPackages.update-nix-fetchgit
    killall
    nix-prefetch-git
    tmux
    tree
    vim
    wget
  ];
}
