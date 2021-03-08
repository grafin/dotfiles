{ stdenv, config, lib, fetchFromGitHub, fetchpatch
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
, virtviewer
, tigervnc

, withDbus ? false
, withNetworkMap ? false
, withOVF ? true
, withSnapshots ? false
, withSpice ? true
, withUTF ? false
, withVNC ? true
}:

stdenv.mkDerivation rec {
  pname = "nemu";
  version = "2021-03-03";

  src = fetchFromGitHub {
    owner = "nemuTUI";
    repo = "nemu";
    rev = "fbf8ebe553757a508165146fe8f9013008b97b6a";
    sha256 = "1z8sr8nisdakzhxgy5m2pff9pkqjn6sdrkkmp873smf0z3d033z8";
  };

  qemu_ = if withSnapshots
    then qemu.overrideAttrs (attrs: {
      patches = attrs.patches ++ [
        (fetchpatch {
          url = "https://raw.githubusercontent.com/nemuTUI/nemu/master/patches/qemu-qmp-savevm-5.0.0+.patch";
          sha256 = "07w18h61m282f2nllxjxzv92lnvz61y9la6p8w7haj6a00kyispn";
        })
      ];
    })
    else qemu;

  system.requiredKernelConfig = with config.lib.kernelConfig; [
    (isEnabled "VETH")
    (isEnabled "MACVTAP")
  ];

  nativeBuildInputs = [ cmake pkg-config ];

  buildInputs = [
    gettext
    libpthreadstubs
    libudev
    libusb1
    sqlite
    qemu_
    ncurses
    socat
    picocom
  ]
    ++ lib.optional withDbus dbus
    ++ lib.optional withNetworkMap graphviz
    ++ lib.optionals withOVF [ libxml2 libarchive ]
    ++ lib.optional withSpice virtviewer
    ++ lib.optional withVNC tigervnc;

  cmakeFlags = lib.optional withDbus "-DNM_WITH_DBUS=ON"
    ++ lib.optional withNetworkMap "-DNM_WITH_NETWORK_MAP=ON"
    ++ lib.optional withOVF "-DNM_WITH_OVF_SUPPORT=ON"
    ++ lib.optional withSnapshots "-DNM_SAVEVM_SNAPSHOTS=ON"
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
      "qemu_bin_path = /usr/bin" "qemu_bin_path = ${qemu_}/bin"

    substituteInPlace sh/ntty --replace \
      /usr/bin/socat ${socat}/bin/socat

    substituteInPlace sh/ntty --replace \
      /usr/bin/picocom ${picocom}/bin/picocom

    substituteInPlace sh/setup_nemu_nonroot.sh --replace \
      /usr/bin/nemu $out/bin/$pname

    substituteInPlace src/nm_cfg_file.c --replace \
      /usr/bin/vncviewer ${tigervnc}/bin/vncviewer

    substituteInPlace src/nm_cfg_file.c --replace \
      /usr/bin/remote-viewer ${virtviewer}/bin/remote-viewer

    substituteInPlace src/nm_cfg_file.c --replace \
      'NM_DEFAULT_QEMUDIR[]  = "/usr/bin"' "NM_DEFAULT_QEMUDIR[]  = \"${qemu_}/bin\""

    substituteInPlace src/nm_cfg_file.c --replace \
      /bin/false /run/current-system/sw/bin/false
  '';

  preInstall = ''
    install -D -m0644 -t $out/share/doc ../LICENSE
  '';

  meta = {
    homepage = "https://github.com/nemuTUI/nemu";
    description = "Ncurses UI for QEMU";
    license = lib.licenses.bsd2;
    platforms = with lib.platforms; linux;
  };
}
