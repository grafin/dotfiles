{ pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    audacity
    chromium
    dbeaver
    deadbeef
    discord
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
    tdesktop
    thunderbird
    tigervnc
    transmission
    virtviewer
    vlc
    wireshark
    xournalpp
    zoom-us
  ];

  imports = [
    ./jitsi/jitsi.nix
  ];
}
