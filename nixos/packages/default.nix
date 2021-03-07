{ pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    git
    gnupg
    haskellPackages.update-nix-fetchgit
    killall
    nix-prefetch-git
    pinentry
    tmux
    tree
    vim
    wget
  ];

  programs.gnupg.agent.enable = true
}
