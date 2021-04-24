{ config, pkgs, ... }:

{
  fonts.fonts = with pkgs; [
    font-awesome
    fira-code
    fira-code-symbols
    lmodern
    opensans-ttf
  ];
}
