{ stdenv, fetchFromGitHub, libusb }:

stdenv.mkDerivation {
  pname = "0xFFFF";
  version = "2020-01-15";

  src = fetchFromGitHub {
    repo = "0xFFFF";
    owner = "pali";
    rev = "e94279eecbfdd1988912ac7ce24e6d4d702695a1";
    sha256 = "12va2i1fhhczzipmd6nqgijg26s53mz2cg8dz11rpq0z9s8p6nw9";
  };

  postPatch = ''
    substituteInPlace config.mk \
      --replace /usr/local "$out"
  '';

  buildInputs = [
    libusb
  ];
}
