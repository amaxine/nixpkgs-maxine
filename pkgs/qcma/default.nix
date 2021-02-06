{ lib
, stdenv
, fetchFromGitHub
, autoconf
, automake
, autoreconfHook
, libvitamtp
, pkgconfig
, libnotify
, ffmpeg
, qt5
, makeWrapper }:

stdenv.mkDerivation rec {
  pname = "qcma";
  version = "0.4.2";

  src = fetchFromGitHub {
    owner = "codestation";
    repo = "qcma";
    rev = "718e31ece8483840369b4d4a9b8791d0244fc0ea";
    sha256 = "1hkzqpsyrfhxh8caz66jh08aqar2d5svz85aqn9xhk61qivf6ryq";
  };

  nativeBuildInputs = [
    pkgconfig
    qt5.qmake
    qt5.qttools
    qt5.qtmultimedia
    qt5.qtbase
    qt5.qtwayland
    libvitamtp
    ffmpeg
    libnotify
    makeWrapper
  ];

  postInstall = ''
    wrapProgram $out/bin/qcma \
      --prefix QT_PLUGIN_PATH : "${qt5.qtbase}/${qt5.qtbase.qtPluginPrefix}"
  '';

  preConfigure = ''
    lrelease common/resources/translations/qcma_*.ts
  '';

  meta = with lib; {
    description = "QCMA is an open-source implementation of Sony's CMA";
    homepage = "https://github.com/codestation/qcma";
    license = licenses.gpl3;
  };
}
