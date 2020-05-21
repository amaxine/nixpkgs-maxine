{ stdenv, fetchFromGitHub, substituteAll, glib, gettext, xorg }:

# This is a fork of no-title-bar from nixpkgs to point towards a non-broken fork
# of the upstream project.
# Original: https://github.com/endocrimes/nixpkgs/blob/24a323b767e923507950ae7e856f5235db75f65b/pkgs/desktops/gnome-3/extensions/no-title-bar/default.nix

stdenv.mkDerivation rec {
  pname = "gnome-shell-extension-no-title-bar-unstable";
  version = "4115905e1d3df51072a2c6b173a471667181b31a";

  src = fetchFromGitHub {
    owner = "poehlerj";
    repo = "no-title-bar";
    rev = "${version}";
    sha256 = "0hcbbfapk76lr8yajacx59cyzs2c1dnccf8fq3gv3zk1z8jfqb1h";
  };

  nativeBuildInputs = [ glib gettext ];

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
    homepage = "https://github.com/franglais125/no-title-bar";
    license = licenses.gpl2;
  };
}
