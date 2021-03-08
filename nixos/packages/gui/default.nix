{ pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    firefox
    keepassxc
    sublime3
    sublime-merge
    tdesktop
  ];
}
