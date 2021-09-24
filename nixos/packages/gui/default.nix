{ pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    android-studio
    audacity
    blender
    chromium
    dbeaver
    deadbeef
    discord
    evince
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
    reaper
    remmina
    screenkey
    shotcut
    skype
    sublime-merge
    sublime4
    tdesktop
    texlive.combined.scheme-full
    texstudio
    thunderbird
    tigervnc
    transmission
    tridactyl-native
    unityhub
    virtviewer
    vlc
    wireshark
    xdg-launch
    xdg-utils
    xournalpp
    yed
    zoom-us
  ];

  imports = [
    ./firefox/firefox.nix
    ./jitsi/jitsi.nix
  ];
}
