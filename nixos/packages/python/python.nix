{ pkgs, ... }:

let
  sympy_1_5_1 = pkgs.python3.pkgs.buildPythonPackage rec {
    pname = "sympy";
    version = "1.5.1";

    src = pkgs.python3.pkgs.fetchPypi {
      inherit pname version;
      sha256 = "0zjfbxlkazzh9z22gf62azrkipb2xw7mpzjz3wl1az9893bh2yfp";
    };

    propagatedBuildInputs = with pkgs; [
      python3Packages.mpmath
    ];

    doCheck = false;

    meta = {
      homepage = "https://www.sympy.org/en/index.html";
      description = "Python library for symbolic mathematics";
    };
  };

  my-python-packages = python-packages: with python-packages; [
    flake8
    jedi
    sympy_1_5_1
  ];

  my-python = pkgs.python3.withPackages my-python-packages;
in {
    environment.systemPackages = with pkgs; [
      my-python
    ];
}
