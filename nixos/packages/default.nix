{ pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    ansible
    awscli
    bottom
    ccls
    codespell
    cppcheck
    file
    ffmpeg
    gh
    gitFull
    gnupg
    goofys
    haskellPackages.update-nix-fetchgit
    inetutils
    killall
    lazygit
    man-pages
    man-pages-posix
    nix-index
    nix-output-monitor
    nix-prefetch-git
    nodejs
    openjdk8
    p7zip
    pandoc
    ranger
    ripgrep-all
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
