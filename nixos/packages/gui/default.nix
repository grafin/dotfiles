{ pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    firefox
    sublime3
    sublime-merge
    tdesktop
  ];
}
