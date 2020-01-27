{ stdenv, fetchFromGitHub, autoconf, automake, autoreconfHook, libtool, libusb
, libxml2, pkgconfig }:

stdenv.mkDerivation rec {
  pname = "libvitamtp";
  version = "2.5.9";

  src = fetchFromGitHub {
    owner = "codestation";
    repo = "vitamtp";
    rev = "v${version}";
    sha256 = "09c9f7gqpyicfpnhrfb4r67s2hci6hh31bzmqlpds4fywv5mzaf8";
  };

  nativeBuildInputs =
    [ autoconf automake autoreconfHook pkgconfig libusb libxml2 libtool ];

  meta = with stdenv.lib; {
    description = "libvitamtp does low level USB communications with the Vita";
    homepage = "https://github.com/codestation/vitamtp";
    license = licenses.gpl3;
  };
}
