{ pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    ansible
    awscli
    bottom
    ccls
    codespell
    cppcheck
    ffmpeg
    file
    gh
    gitFull
    gnupg
    goofys
    haskellPackages.update-nix-fetchgit
    inetutils
    jq
    killall
    lazygit
    lsof
    man-pages
    man-pages-posix
    nix-index
    nix-output-monitor
    nix-prefetch-git
    openjdk8
    p7zip
    pandoc
    patchelf
    podman-compose
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
