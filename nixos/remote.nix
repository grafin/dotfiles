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
    securityType = "user";

    extraConfig = ''
      workgroup = WORKGROUP
      browseable = yes
    '';

    shares = {
      homes = {
        browseable = "no";
        "read only" = "no";
        "guest ok" = "no";
      };
    };
  };
}
