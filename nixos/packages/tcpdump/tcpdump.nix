{ pkgs, fetchFromGitHub,... }:

let
  tcpdump-patched = pkgs.tcpdump.overrideAttrs(
    attrs: {
      version = "custom";

      src = pkgs.fetchFromGitHub {
        owner = "the-tcpdump-group";
        repo = "tcpdump";
        rev = "c8bf9d20b3531d925101578cb5ca1613dc7f9d78";
        sha256 = "01kg4i538n9a364wdf2lhfczy2l6239015f5lbl6b8jyc388w9bg";
      };

      patches = [ ./patches/tarantool.patch ];
    }
  );
in {
  environment.systemPackages = with pkgs; [
    tcpdump-patched
  ];
}
