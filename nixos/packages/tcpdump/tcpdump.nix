{ pkgs, fetchFromGitHub,... }:

let
  tcpdump-patched = pkgs.tcpdump.overrideAttrs(
    attrs: {
      version = "unstable-2023-09-09";

      src = pkgs.fetchFromGitHub {
        owner = "the-tcpdump-group";
        repo = "tcpdump";
        rev = "48a2f9ecac9e9480771f13479ddbf866cb36c9d7";
        sha256 = "10kwhp0nfqxd1cc1c3yzxx18b0cfs69p4byyr024wn5y0y8lm4ab";
      };

      patches = [ ./patches/tarantool.patch ];

      buildInputs = attrs.buildInputs ++ [ pkgs.autoconf ];

      preConfigure = ''
        ./autogen.sh
      '';
    }
  );
in {
  environment.systemPackages = with pkgs; [
    tcpdump-patched
  ];
}
