{ pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    python3
    python310Packages.pproxy
  ];

  systemd.services.pproxy = {
    enable = true;
    description = "pproxy server";
    unitConfig = {
      Type = "simple";
    };
    serviceConfig = {
      EnvironmentFile = /etc/nixos/secret_proxy.env;
      ExecStart = let
        python = pkgs.python3.withPackages (ps: with ps; [ pproxy ]);
      in
        "${python.interpreter} -m pproxy -l $PPROXY_BIND_PATH -r $PPROXY_PROXY_SERVER";
    };
    wantedBy = [ "multi-user.target" ];
    wants = [ "network-online.target" ];
    after = [ "network-online.target" ];
  };

}
