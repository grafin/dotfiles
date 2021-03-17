{ pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    audacity
    chromium
    dbeaver
    deadbeef
    discord
    evince
    firefox
    flameshot
    geogebra
    gimp
    gnome3.nautilus
    keepassxc
    libreoffice
    mellowplayer
    pavucontrol
    qalculate-gtk
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
    xdg-launch
    xdg-utils
    xournalpp
    zoom-us
  ];

  imports = [
    ./jitsi/jitsi.nix
  ];
}
