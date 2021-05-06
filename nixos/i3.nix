{ pkgs, ... }:

{
  environment.pathsToLink = [ "/libexec" ];
  environment.variables = {
    _JAVA_OPTIONS = "-Dawt.useSystemAAFontSettings=lcd";
  };

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
    xautolock = {
      enable = true;
      enableNotifier = true;
      time = 15;
      locker = ''${pkgs.i3lock-fancy-rapid}/bin/i3lock-fancy-rapid 8 pixel'';
      notify = 10;
      notifier =
        ''${pkgs.libnotify}/bin/notify-send "Locking in 10 seconds"'';
      };
  };
}
