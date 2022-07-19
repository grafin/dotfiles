{ pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    ccls
    codespell
    cppcheck
    file
    ffmpeg
    gh
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
    pandoc
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
    ./gdb-dashboard/gdb-dashboard.nix
    ./python/python.nix
    ./schroot/schroot.nix
    ./tmux/tmux.nix
    ./udevil/udevil.nix
    ./vim/vim.nix
  ];
}
