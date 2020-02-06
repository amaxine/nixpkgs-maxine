{ stdenv, fetchurl, dpkg, autoPatchelfHook }:

stdenv.mkDerivation rec {
  pname = "dell-command-configure";
  version = "4.2.0";

  src = fetchurl {
    url = "https://downloads.dell.com/FOLDER05519670M/1/command-configure_4.2.0-553.ubuntu16_amd64.tar.gz";
    sha256 = "0bwmrgz335sm1mfh890pjylcqg30q98vmgazcc4vc45sj13fvry1";
  };

  buildInputs = [ dpkg autoPatchelfHook ];
  sourceRoot = pname;
  phases = [ "unpackPhase" "installPhase" ];

  unpackPhase = ''
    mkdir ${pname}
    tar -C ${pname} -xzf ${src}
    dpkg-deb -x ${pname}/command-configure_4.2.0-553.ubuntu16_amd64.deb ${pname}/command-configure
    dpkg-deb -x ${pname}/srvadmin-hapi_9.3.0_amd64.deb ${pname}/srvadmin-hapi
  '';

  installPhase = ''
    mkdir $out
    #install -m755 -D $out/srvadmin ${pname}/srvadmin-hapi/opt/dell/srvadmin/lib64
    install -t $out -m755 -v command-configure/opt/dell/dcc/libhapiintf.so
    install -t $out -m755 -v command-configure/opt/dell/dcc/cctk
    install -t $out -m755 -v srvadmin-hapi/opt/dell/srvadmin/lib64/libdchbas.so.9.3.0
    ln -fs $out/libdchbas.so.9.3.0 $out/libdchbas.so.9
    patchelf --set-rpath ${stdenv.cc.cc.lib}/lib:$out $out/libhapiintf.so
    patchelf --set-rpath ${stdenv.cc.cc.lib}/lib:$out $out/cctk
  '';

  meta = with stdenv.lib; {
    description = "Configure BIOS settings on Dell laptops.";
    homepage = "https://www.dell.com/support/article/us/en/19/sln311302/dell-command-configure";
    license = licenses.unfree;
    platforms = [ "x86_64-linux" ];
  };
}
