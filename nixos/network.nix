{ ... }:

{
  # Network
  networking = {
    hostName = "mainhost";
    useDHCP = false;

    # Interfaces
    # interfaces.enp0s3.ipv4.addresses = [
    #   {
    #     address = "169.254.1.5";
    #     prefixLength = 16;
    #   }
    # ];
    # defaultGateway = "169.254.1.1";
    interfaces.enp3s0.useDHCP = true;
    nameservers = [ "1.1.1.1" "1.0.0.1" ];

    # Proxy
    # proxy = {
    #   default = "http://user:password@proxy:port/";
    #   noProxy = "127.0.0.1,localhost,internal.domain";
    # }
  };
}
