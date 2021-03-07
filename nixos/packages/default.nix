{ pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    git
    gnupg
    haskellPackages.update-nix-fetchgit
    killall
    nix-prefetch-git
    pinentry
    pinentry-curses
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
}
