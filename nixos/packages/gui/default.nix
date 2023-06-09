{ pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    android-file-transfer
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
    remmina
    screenkey
    shotcut
    skype
    sublime-merge
    sublime4
    tdesktop
    teams
    texlive.combined.scheme-full
    texstudio
    thunderbird
    tigervnc
    transmission
    tridactyl-native
    unityhub
    virtviewer
    vlc
    wineWowPackages.full
    xdg-launch
    xdg-utils
    xournalpp
    yed
    zoom-us
  ];

  programs = {
    wireshark = {
      enable = true;
      package = pkgs.wireshark-qt;
    };
  };

  imports = [
    ./firefox/firefox.nix
    ./jitsi/jitsi.nix
    ./R/R.nix
  ];
}
