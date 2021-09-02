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

  environment.systemPackages = with pkgs; [
    x2goserver
  ];

  services.x2goserver = {
    enable = true;
  };
}
