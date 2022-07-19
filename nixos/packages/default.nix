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
    nix-prefetch-git
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
    ./gdb-dashboard/gdb-dashboard.nix
    #./nemu/nemu.nix
    ./python/python.nix
    ./tcpdump/tcpdump.nix
    ./tmux/tmux.nix
    ./udevil/udevil.nix
    ./vim/vim.nix
  ];
}
