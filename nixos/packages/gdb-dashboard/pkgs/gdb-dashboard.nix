{ lib
, stdenv
, python3
, fetchFromGitHub
, makeWrapper
, gdb
}:

let
  pythonPath = with python3.pkgs; makePythonPath [
    pygments
  ];

in stdenv.mkDerivation rec {
  pname = "gdb-dashboard";
  version = "unstable-2021-12-28";
  format = "other";

  src = fetchFromGitHub {
    owner = "cyrus-and";
    repo = "gdb-dashboard";
    rev = "13df4b1267b6cf3545601db0ac5c872317beb189";
    sha256 = "0di8k84kh9l0b9rg8wjq84nxsww0mxmkm575kb8qik1gjdb1ad5n";
  };

  nativeBuildInputs = [ makeWrapper ];

  installPhase = ''
    mkdir -p $out/share/gdb-dashboard
    sed 's/monokai/default/' .gdbinit > $out/share/gdb-dashboard/gdbinit
    chmod +x $out/share/gdb-dashboard/gdbinit
    makeWrapper ${gdb}/bin/gdb $out/bin/gdb-dashboard \
      --add-flags "-q --init-command=$out/share/gdb-dashboard/gdbinit" \
      --set NIX_PYTHONPATH ${pythonPath}
  '';

  meta = {
    homepage = "https://github.com/cyrus-and/gdb-dashboard";
    description = "Modular visual interface for GDB in Python";
    license = lib.licenses.mit;
    platforms = lib.platforms.all;
  };
}
