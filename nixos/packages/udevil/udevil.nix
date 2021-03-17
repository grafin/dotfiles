{ pkgs, config, ... }:

let
  nixpkgs = import <nixpkgs> { config = config.nixpkgs.config; };
  udevil = nixpkgs.udevil;
in {
  environment.systemPackages = with pkgs; [
    udevil
  ];

  security.wrappers.udevil = {
    source = "${udevil}/bin/udevil";
    setuid = true;
    owner = "root";
    group = "root";
    permissions = "u+rx,g+rx,a+rx";
  };
}
