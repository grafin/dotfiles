{ config, pkgs, ... }:

{
  fonts.packages = with pkgs; [
    font-awesome
    fira-code
    fira-code-symbols
    lmodern
    opensans-ttf
  ];
}
