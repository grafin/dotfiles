{ ... }:

{
  networking = {
    hostName = "nixos";
    useDHCP = false;
    enableIPv6 = false;
    resolvconf.useLocalResolver = false;

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
      ens34.ipv4 = {
        addresses = [{
          address = "172.16.18.10";
          prefixLength = 24;
        }];
      };
      ens37 = {
        useDHCP = true;
      };
    };

    nameservers = [
      "1.1.1.1"
      "1.0.0.1"
    ];

    hosts = {
      "172.16.18.1" = [ "host" ];
    };

    firewall = {
      enable = true;
      allowPing = true;
      allowedUDPPorts = [
        22 # SSH
        53 # DNS
      ];
      allowedTCPPorts = [
        22 # SSH
        53 # DNS
        80 # nginx
        2181 # zookeeper
        2182 # zookeeper-admin
        6060 # golang pprof
        9092 # kafka
        50051 # gRPC

        # tarantool
        3301
        3302
        3303
        13301
        13302
        13303

        # tdg
        8080

        # cartridge web-ui
        8081
        8082
        8083
        8091
        8092
        8093

        # Minecraft
        10001
        10002
        19132
        25565

        # TCF
        10080
        10081
        10082
        10180
        10181
        10182

        # DEBUG
        11148
        11149
      ];
    };
  };
}
