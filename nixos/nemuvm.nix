{  config, ... }:

{
  imports = [
    ./packages/nemu/nemuvm.nix
  ];

  services.nemuvm.enable = true;
  services.nemuvm.user = "boris";
  services.nemuvm.vm = "CentOS-ViPNet,Windows-ViPNet,Minecraft";
}
