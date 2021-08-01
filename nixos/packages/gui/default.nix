{ pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    android-studio
    audacity
    chromium
    dbeaver
    deadbeef
    discord
    evince
    (firefox.override {
      cfg = {
        enableTridactylNative = true;
      };
    })
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
    ./jitsi/jitsi.nix
  ];
}
