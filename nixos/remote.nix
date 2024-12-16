{ pkgs, ... }:

{
  networking.firewall = {
    allowedTCPPorts = [
      139
      445
    ];
    allowedUDPPorts = [
      137
      138
    ];
  };

  services.samba = {
    enable = true;

    settings = {
      global = {
        workgroup = "WORKGROUP";
        security = "user";
      };

      public = {
        browseable = "no";
        path = "/home";
        "read only" = "no";
        "guest ok" = "no";
      };
    };
  };
}
