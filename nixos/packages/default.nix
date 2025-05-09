{ pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    ansible
    awscli2
    bottom
    ccls
    codespell
    cppcheck
    devpod
    ffmpeg
    file
    gh
    gitFull
    gnupg
    goofys
    google-cloud-sdk
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
    unzip
    usbutils
    valgrind
    wget
    zip
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
