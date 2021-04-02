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
    killall
    lazygit
    maestral
    nix-prefetch-git
    nnn
    p7zip
    python39Packages.flake8
    ranger
    tmux
    tree
    udiskie
    wget
  ];

  programs.mtr.enable = true;

  imports = [
    ./nemu/nemu.nix
    ./schroot/schroot.nix
    ./udevil/udevil.nix
    ./vim/vim.nix
  ];
}
