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
    tigervnc
    tdesktop
    thunderbird
    transmission
    virtviewer
    vlc
    volctl
    wireshark
    xournalpp
    zoom-us
  ];

  imports = [
    ./jitsi/jitsi.nix
  ];
}
