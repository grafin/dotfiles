{ ... }:

{
  networking = {
    hostName = "nixos";
    useDHCP = false;

    interfaces = {
      ens33.ipv4 = {
        addresses = [{
          address = "172.16.17.10";
          prefixLength = 24;
        }];
        routes = [{
          address = "0.0.0.0";
          prefixLength = 0;
          via = "172.16.17.2";
        }];
      };
    };

    nameservers = [
      "1.1.1.1"
      "1.0.0.1"
    ];

    hosts = {
      "172.16.17.2" = [ "host" ];
    };

    firewall = {
      enable = true;
      allowPing = true;
      allowedUDPPorts = [
        22 # SSH
      ];
      allowedTCPPorts = [
        22 # SSH
        80 # nginx

        # tarantool
        3301
        3302
        3303
        13301
        13302
        13303

        # cartridge web-ui
        8081
        8082
        8083
        8091
        8092
        8093
      ];
    };
  };
}
