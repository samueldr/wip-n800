{ stdenv, fetchurl, pkgconfig, systemd ? null, fetchpatch }:

stdenv.mkDerivation rec {
  name = "libusb-0.1.12";

  src = fetchurl {
    url = "mirror://sourceforge/libusb/libusb-0.1%20%28LEGACY%29/0.1.12/libusb-0.1.12.tar.gz";
    sha256 = "0i4bacxkyr7xyqxbmb00ypkrv4swkgm0mghbzjsnw6blvvczgxip";
  };

  outputs = [ "out" ];

  buildInputs = [ pkgconfig ];
  propagatedBuildInputs =
    stdenv.lib.optional stdenv.isLinux systemd;

  preConfigure = ''
    #set -x
      _multioutConfig() {
      configureFlags="\
          --bindir=''${!outputBin}/bin --sbindir=''${!outputBin}/sbin \
          --includedir=''${!outputInclude}/include --oldincludedir=''${!outputInclude}/include \
          --mandir=''${!outputMan}/share/man --infodir=''${!outputInfo}/share/info \
          --libdir=''${!outputLib}/lib --libexecdir=''${!outputLib}/libexec \
          $configureFlags"

      installFlags="\
          pkgconfigdir=''${!outputDev}/lib/pkgconfig \
          m4datadir=''${!outputDev}/share/aclocal aclocaldir=''${!outputDev}/share/aclocal \
          $installFlags"
    }
  '';

  NIX_CFLAGS_COMPILE = toString [   
    "-Wno-error=format-truncation"  
  ];                                                                                      

  NIX_LDFLAGS = stdenv.lib.optionalString stdenv.isLinux "-lgcc_s";

  meta = with stdenv.lib; {
    homepage = http://www.libusb.info;
    description = "The actual legacy user-space USB library";
    platforms = platforms.unix;
    license = licenses.lgpl21;
  };
}
