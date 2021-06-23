{ ... }:

{
  networking = {
    hostName = "mainhost";
    useDHCP = false;

    bridges.br0.interfaces = [ "enp3s0" "veth_br0_0" ];
    interfaces.br0.useDHCP = true;

    interfaces.veth_ll_0.ipv4.addresses = [
      {
        address = "169.254.1.1";
        prefixLength = 16;
      }
    ];

    interfaces.veth_vipnet_0.ipv4 = {
      addresses = [
        {
          address = "172.17.0.2";
          prefixLength = 24;
        }
      ];
      routes = [
        {
          address = "11.0.0.0";
          prefixLength = 8;
          via = "172.17.0.1";
        }
        {
          address = "10.0.0.0";
          prefixLength = 16;
          via = "172.17.0.1";
        }
        {
          address = "172.31.0.0";
          prefixLength = 16;
          via = "172.17.0.1";
        }
        {
          address = "192.168.40.0";
          prefixLength = 24;
          via = "172.17.0.1";
        }
        {
          address = "192.168.100.0";
          prefixLength = 24;
          via = "172.17.0.1";
        }
      ];
    };

    nameservers = [ "172.17.0.1" ];

    firewall = {
      enable = true;
      allowPing = true;
      allowedUDPPorts = [
        22 # SSH
        55777 # WG
      ];
    };

    wireguard.interfaces = {
      wg0 = {
        ips = [ "172.16.0.2/16" ];
        listenPort = 55777;

        privateKeyFile = "/root/wireguard/private-mainhost.key";

        peers = [
          {
            publicKey = "xWmKFQiiAKLP7mE1+grvLWUqHDgchOlR/4YhtV+mgAg=";
            allowedIPs = [ "172.16.0.0/16" ];
            endpoint = "142.47.104.94:55777";
            persistentKeepalive = 25;
          }
        ];
      };
    };
  };
}
