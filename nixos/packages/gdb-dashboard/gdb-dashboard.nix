{ pkgs, ... }:

let
  gdb-dashboard = pkgs.callPackage ./pkgs/gdb-dashboard.nix {};
in {
    environment.systemPackages = with pkgs; [
      gdb-dashboard
    ];
}
