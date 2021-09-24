{ pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    ccls
    codespell
    cppcheck
    file
    ffmpeg
    gdb
    gitFull
    gnupg
    haskellPackages.update-nix-fetchgit
    inetutils
    killall
    lazygit
    maestral
    nix-prefetch-git
    nnn
    nodejs
    openjdk8
    p7zip
    ranger
    tree
    udiskie
    universal-ctags
    usbutils
    valgrind
    wget
  ];

  programs.mtr.enable = true;

  imports = [
    ./nemu/nemu.nix
    ./python/python.nix
    ./schroot/schroot.nix
    ./tmux/tmux.nix
    ./udevil/udevil.nix
    ./vim/vim.nix
  ];
}
