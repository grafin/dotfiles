{ ... }:
{
  systemd.services.nemu-veth = {
    description = "Service, which creates nemu's veth interfaces";
    before = [ "network-pre.target" ];
    serviceConfig = {
      Type = "oneshot";
      User = "boris";
      ExecStart = "/run/wrappers/bin/nemu -c";
    };
    wantedBy = [ "multi-user.target" ];
  };
}
