{ lib
, stdenv
, requireFile
, unzip
, makeDesktopItem
, SDL2
, xorg
, libpulseaudio
, systemd }:

let
  arch = "amd64";

  desktopItem = makeDesktopItem {
    desktopName = "voxatron";
    genericName = "voxatron virtual console";
    categories = "Game;";
    exec = "voxatron";
    icon = "lexaloffle-vox";
    name = "voxatron";
    type = "Application";
  };

in

stdenv.mkDerivation rec {
  pname = "voxatron";
  version = "0.3.5b";

  helpMsg = ''
    We cannot download the full version automatically, as you require a license.
    Once you have bought a license, you need to add your downloaded version to the nix store.
    You can do this by using "nix-prefetch-url file://\$PWD/${pname}_${version}_${arch}.zip"
    in the directory where you saved it.
  '';

  src = requireFile {
    message = helpMsg;
    name = "${pname}_${version}_${arch}.zip";
    sha256 = "529eff5315481ffb0553a1a4d2097144ffdcd4290119795b009a60e75fa316c2";
  };

  buildInputs = [ unzip ];
  phases = [ "unpackPhase" "installPhase" ];

  libPath = pkgs.lib.makeLibraryPath [ stdenv.cc.cc.lib stdenv.cc.libc SDL2
    xorg.libX11 xorg.libXinerama libpulseaudio ];

  installPhase = ''
    mkdir -p $out/bin $out/lib $out/share/applications $out/share/icons/hicolor/128x128/apps

    install -t $out/bin -m755 -v vox
    install -t $out/bin -m644 vox.dat
    install -t $out/share/icons/hicolor/128x128/apps -m644 lexaloffle-vox.png

    cp ${desktopItem}/share/applications/voxatron.desktop \
      $out/share/applications/voxatron.desktop

    ln -s ${systemd}/lib/libudev.so.1 $out/lib/libudev.so.1

    patchelf \
      --interpreter $(cat $NIX_CC/nix-support/dynamic-linker) \
      --set-rpath ${libPath}:$out/lib \
      $out/bin/pico8
  '';

  meta = with lib; {
    description = "Fantasy console and cartridges made out of voxels.";
    homepage = "https://www.lexaloffle.com/voxatron.php";
    license = licenses.unfree;
    platforms = [ "x86_64-linux" ];
    maintainers = with maintainers; [ maxeaubrey ];
  };
}

