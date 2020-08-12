{ pkgs ? import <nixpkgs> {} }:

{
  modules = import ./modules;

  gnomeExtensions = { no-title-bar = pkgs.callPackage ./pkgs/no-title-bar { }; };
  libvitamtp = pkgs.callPackage ./pkgs/libvitamtp { };
  qcma = pkgs.callPackage ./pkgs/qcma { };
  finalhe = pkgs.callPackage ./pkgs/finalhe { };
  pico-8 = pkgs.callPackage ./pkgs/pico-8 { };
  voxatron = pkgs.callPackage ./pkgs/voxatron { };
  dell-command-configure = pkgs.callPackage ./pkgs/dell-command-configure { };
}
