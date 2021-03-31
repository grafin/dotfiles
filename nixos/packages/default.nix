{ pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    file
    gdb
    git
    gnupg
    haskellPackages.update-nix-fetchgit
    killall
    maestral
    nix-prefetch-git
    nnn
    p7zip
    ranger
    tmux
    tree
    udiskie
    wget
  ];

  imports = [
    ./nemu/nemu.nix
    ./schroot/schroot.nix
    ./udevil/udevil.nix
    ./vim/vim.nix
  ];
}
