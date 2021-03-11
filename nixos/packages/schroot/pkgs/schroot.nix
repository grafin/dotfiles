{ stdenv, lib, fetchgit, installShellFiles
, cmake
, pkg-config
, doxygen
, boost
, cppunit
, gettext
, groff
, libuuid
, pam
, perlPackages

, schroots ? { }
}:

stdenv.mkDerivation rec {
  pname = "schroot";
  version = "2021-02-28";

  src = fetchgit {
    url = "https://salsa.debian.org/debian/schroot.git";
    rev = "debian/1.6.10-12";
    sha256 = "0yjqc55bhyqdxdf193s6bw3zsl9va4z2xf84l0w6c3nfz3w2q493";
  };

  nativeBuildInputs = [ cmake pkg-config doxygen installShellFiles ];

  buildInputs = [
    boost
    cppunit
    gettext
    groff
    libuuid
    pam
    perlPackages.Po4a
  ];

  patches = [
    ./patches/cross.patch
    ./patches/path.patch
    ./patches/nosetuid.patch
    ./patches/fixpam.patch
  ];

  cmakeFlags = [
    "-DCMAKE_INSTALL_LOCALSTATEDIR=/var"
    "-DSCHROOT_CONF_CHROOT_D=/etc/${pname}/chroot.d"
  ];

  preConfigure = ''
    patchShebangs .

    substituteInPlace bin/schroot-mount/schroot-mount-main.cc --replace \
      /bin/mount /run/current-system/sw/bin/mount

    substituteInPlace etc/bash_completion/schroot --replace \
      "have schroot &&" ""
  '';

  postInstall = ''
    installShellCompletion --bash $out/etc/bash_completion.d/schroot
  '';

  meta = {
    homepage = "https://salsa.debian.org/debian/schroot";
    description = "Securely enter a chroot and run a command or login shell";
    license = lib.licenses.gpl3;
    platforms = with lib.platforms; linux;
  };
}
