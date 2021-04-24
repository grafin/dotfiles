{ pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    codespell
    cppcheck
    file
    gdb
    gitFull
    gnupg
    haskellPackages.update-nix-fetchgit
    oraclejre
    killall
    lazygit
    maestral
    nix-prefetch-git
    nnn
    p7zip
    python39Packages.flake8
    ranger
    tree
    udiskie
    wget
  ];

  programs.mtr.enable = true;

  imports = [
    ./nemu/nemu.nix
    ./schroot/schroot.nix
    ./tmux/tmux.nix
    ./udevil/udevil.nix
    ./vim/vim.nix
  ];
}
