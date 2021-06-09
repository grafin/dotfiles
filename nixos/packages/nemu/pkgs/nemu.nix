{ stdenv, config, lib, fetchurl, fetchFromGitHub, fetchpatch, installShellFiles
, cmake
, pkg-config
, gettext
, libpthreadstubs
, libudev
, libusb1
, sqlite
, qemu
, ncurses
, socat
, picocom

, dbus
, graphviz
, libxml2
, libarchive
, json_c
, virtviewer
, tigervnc

, withDbus ? false
, withNetworkMap ? false
, withOVF ? true
, withSpice ? true
, withUTF ? false
, withVNC ? true

, configName ? ".config/nemu/nemu.cfg"
, vmDir ? ".local/share/nemu/vms"
, databaseName ? ".local/share/nemu/nemu.db"
}:

stdenv.mkDerivation rec {
  pname = "nemu";
  version = "2021-06-01";

  src = fetchFromGitHub {
    owner = "nemuTUI";
    repo = "nemu";
    rev = "a2155f2793e58a3882aecdcc07487f507ee3294c";
    sha256 = "0y8mm14s8hmw0c0bdx4l7awfp5x22pdwgm28ks1405qjwhwgmf85";
  };

  system.requiredKernelConfig = with config.lib.kernelConfig; [
    (isEnabled "VETH")
    (isEnabled "MACVTAP")
  ];

  nativeBuildInputs = [ cmake pkg-config installShellFiles ];

  buildInputs = [
    gettext
    libpthreadstubs
    libudev
    libusb1
    sqlite
    qemu
    ncurses
    socat
    picocom
    json_c
  ]
    ++ lib.optional withDbus dbus
    ++ lib.optional withNetworkMap graphviz
    ++ lib.optionals withOVF [ libxml2 libarchive ]
    ++ lib.optional withSpice virtviewer
    ++ lib.optional withVNC tigervnc;

  cmakeFlags = [
    "-DNM_CFG_NAME=${configName}"
    "-DNM_DEFAULT_VMDIR=${vmDir}"
    "-DNM_DEFAULT_VNC=${tigervnc}/bin/vncviewer"
    "-DNM_DEFAULT_DBFILE=${databaseName}"
    "-DNM_DEFAULT_SPICE=${virtviewer}/bin/remote-viewer"
    "-DNM_DEFAULT_QEMUDIR=${qemu}/bin"
  ]
    ++ lib.optional withDbus "-DNM_WITH_DBUS=ON"
    ++ lib.optional withNetworkMap "-DNM_WITH_NETWORK_MAP=ON"
    ++ lib.optional withOVF "-DNM_WITH_OVF_SUPPORT=ON"
    ++ lib.optional withSpice "-DNM_WITH_SPICE=ON"
    ++ lib.optional withUTF "-DNM_USE_UTF=ON"
    ++ lib.optional withVNC "-DNM_WITH_VNC_CLIENT=ON";

  preConfigure = ''
    patchShebangs .

    substituteInPlace lang/ru/nemu.po --replace \
      /bin/false /run/current-system/sw/bin/false

    substituteInPlace nemu.cfg.sample --replace \
      /usr/bin/vncviewer ${tigervnc}/bin/vncviewer

    substituteInPlace nemu.cfg.sample --replace \
      /usr/bin/remote-viewer ${virtviewer}/bin/remote-viewer

    substituteInPlace nemu.cfg.sample --replace \
      "qemu_bin_path = /usr/bin" "qemu_bin_path = ${qemu}/bin"

    substituteInPlace sh/ntty --replace \
      /usr/bin/socat ${socat}/bin/socat

    substituteInPlace sh/ntty --replace \
      /usr/bin/picocom ${picocom}/bin/picocom

    substituteInPlace sh/upgrade_db.sh --replace \
      sqlite3 ${sqlite}/bin/sqlite3

    substituteInPlace sh/setup_nemu_nonroot.sh --replace \
      /usr/bin/nemu $out/bin/$pname

    substituteInPlace src/nm_cfg_file.c --replace \
      /bin/false /run/current-system/sw/bin/false
  '';

  preInstall = ''
    install -D -m0644 -t $out/share/doc ../LICENSE
  '';

  postInstall = ''
    installShellCompletion --bash $out/share/nemu/scripts/nemu.bash
  '';

  meta = {
    homepage = "https://github.com/nemuTUI/nemu";
    description = "Ncurses UI for QEMU";
    license = lib.licenses.bsd2;
    platforms = with lib.platforms; linux;
  };
}
