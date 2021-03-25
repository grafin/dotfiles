{ pkgs, ... }:

{
  networking.firewall = {
    allowedTCPPorts = [
      445
      139
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
      security = user
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
