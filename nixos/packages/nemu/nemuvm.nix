{ config, pkgs, lib, ... }:

let
  cfg = config.services.nemuvm;
in

with lib;

{
  options = {
    services.nemuvm = {
      enable = mkOption {
        default = false;
        type = with types; bool;
        description = "Start VM for a user";
      };

      user = mkOption {
        type = with types; uniq string;
        description = "Name of the user";
      };

      vm = mkOption {
        type = with types; uniq string;
        description = "Name of the VM";
      };
    };
  };

  config = mkIf cfg.enable {
    systemd.services.nemuvm = {
      description = "Service, which starts/stops nemu's VMs ";
      after = [
        "network-online.target"
        "nemu-veth.service"
      ];
      serviceConfig = {
        Type = "oneshot";
        User = "${cfg.user}";
        WorkingDirectory = "/home/${cfg.user}";
        RemainAfterExit = "yes";
        ExecStart = "/run/wrappers/bin/nemu --start ${cfg.vm}";
        ExecStop = "/run/wrappers/bin/nemu --poweroff ${cfg.vm}";
      };
      wantedBy = [ "multi-user.target" ];
    };
  };
}
