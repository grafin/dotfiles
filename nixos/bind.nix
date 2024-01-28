{ ... }:

{
  services.bind = {
    enable = true;
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
