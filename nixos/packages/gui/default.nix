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
    keepassxc
    libreoffice
    lyx
    mellowplayer
    obs-studio
    octaveFull
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
    texlive.combined.scheme-full
    texstudio
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
