{ lib
, stdenv
, fetchFromGitHub
, cmake
, qt5
, libdeflate
, libusb
, libxml2
, pkgconfig
, makeWrapper }:

stdenv.mkDerivation rec {
  pname = "finalhe";
  version = "2020-05-25";

  src = fetchFromGitHub {
    owner = "soarqin";
    repo = "finalhe";
    rev = "624b8ebe3c68e412307c582931ce9d8de2e55b4a";
    sha256 = "06k96dz3xs2ch8a547fs9jfhbhq1vk6gk55763spmb3iwcjpy6fa";
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

  meta = with lib; {
    description = "A tool to push the h-encore explot for PS Vita/PS TV automatically";
    homepage = "https://github.com/soarqin/finalhe";
    license = licenses.gpl3;
  };
}
