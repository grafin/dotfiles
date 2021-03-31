{ pkgs, ... }:

{
  environment.pathsToLink = [ "/libexec" ];
  services.xserver = {
    enable = true;

    desktopManager = {
      xterm.enable = false;
    };

    displayManager = {
        defaultSession = "none+i3";
    };

    windowManager.i3 = {
      enable = true;
      extraPackages = with pkgs; [
        compton
        dunst
        i3lock-fancy-rapid
        kitty
        libnotify
        lxappearance
        polybarFull
        rofi
     ];
    };
  };
}
