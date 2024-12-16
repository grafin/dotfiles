{ pkgs, ... }:

let

  my-python-packages = python-packages: with python-packages; [
    flake8
    jedi
    pygments
    pylint
    sympy
    scapy
  ];

  my-python = pkgs.python3.withPackages my-python-packages;
in {
    environment.systemPackages = with pkgs; [
      my-python
    ];
}
