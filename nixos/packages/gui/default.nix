{ pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    audacity
    chromium
    dbeaver
    deadbeef
    discord
    dropbox
    firefox
    geogebra
    gimp
    jitsi
    keepassxc
    libreoffice
    mellowplayer
    pavucontrol
    qucs
    remmina
    shotcut
    skype
    sourcetrail
    sublime-merge
    sublime3
    tdesktop
    thunderbird
    transmission
    vlc
    volctl
    wireshark
    xournalpp
    zoom-us
  ];
}
