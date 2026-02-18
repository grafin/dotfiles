{ ... }:

let
  bindAddress = "192.168.0.70";
in {
  services.bind = {
    enable = true;
    listenOn = [ bindAddress ];
    extraOptions = ''
      recursion no;
    '';
    zones = {
      "hivebedrock.network" = {
        master = true;
        file = "db.hivebedrock.network";
      };
      "inpvp.net" = {
        master = true;
        file = "db.inpvp.net";
      };
      "lbsg.net" = {
        master = true;
        file = "db.lbsg.net";
      };
      "galaxite.net" = {
        master = true;
        file = "db.galaxite.net";
      };
    };
  };
}
