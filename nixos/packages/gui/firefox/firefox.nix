{ pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    (firefox.override {
      cfg = {
        enableTridactylNative = true;
      };
    })
  ];
}
