{ stdenv, fetchFromGitHub, substituteAll, glib, gettext, xorg }:

# This is a fork of no-title-bar from nixpkgs to point towards a non-broken fork
# of the upstream project.
# Original: https://github.com/endocrimes/nixpkgs/blob/24a323b767e923507950ae7e856f5235db75f65b/pkgs/desktops/gnome-3/extensions/no-title-bar/default.nix

stdenv.mkDerivation rec {
  pname = "gnome-shell-extension-no-title-bar-unstable";
  version = "62f1c4e32fd982b48fdc3161674a0abb15ee20e0";

  src = fetchFromGitHub {
    owner = "poehlerj";
    repo = "no-title-bar";
    rev = "${version}";
    sha256 = "1jq12s3l30fnm2djs2p21mkzf463r1lp4lmmhvbj2xx8lpcmks99";
  };

  nativeBuildInputs = [
    glib gettext
  ];

  patches = [
    (substituteAll {
      src = ./fix-paths.patch;
      xprop = "${xorg.xprop}/bin/xprop";
      xwininfo = "${xorg.xwininfo}/bin/xwininfo";
    })
  ];

  makeFlags = [ "INSTALLBASE=$(out)/share/gnome-shell/extensions" ];

  meta = with stdenv.lib; {
    description = "Integrates maximized windows with the top panel";
    homepage = https://github.com/franglais125/no-title-bar;
    license = licenses.gpl2;
  };
}