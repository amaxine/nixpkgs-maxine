{ stdenv, fetchFromGitHub, cmake, qt5, libdeflate, libusb, libxml2, pkgconfig
, makeWrapper }:

stdenv.mkDerivation rec {
  pname = "finalhe";
  version = "1.92";

  src = fetchFromGitHub {
    owner = "soarqin";
    repo = "finalhe";
    rev = "v${version}";
    sha256 = "0i9y908lbpkk3z2i8sp3q39rmsbmpa3y92jwrnzhc5f4hah8iqrg";
  };

  nativeBuildInputs = [
    pkgconfig
    cmake
    libxml2
    libusb
    libdeflate
    qt5.qtbase
    qt5.qttools
    makeWrapper
  ];

  patches = [ ./cmake.patch ];

  postInstall = ''
    wrapProgram $out/bin/FinalHE \
      --prefix QT_PLUGIN_PATH : "${qt5.qtbase}/${qt5.qtbase.qtPluginPrefix}"
  '';

  meta = with stdenv.lib; {
    description = "A tool to push the h-encore explot for PS Vita/PS TV automatically";
    homepage = "https://github.com/soarqin/finalhe";
    license = licenses.gpl3;
  };
}
