{ pkgs, ... }:

{
  imports = [
    ./bind.nix
    ./mysql.nix
  ];

  environment.systemPackages = with pkgs; [
    minecraft-server
  ];
}
