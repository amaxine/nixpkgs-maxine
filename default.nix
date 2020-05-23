{ system ? builtins.currentSystem }:

let
  pkgs = import <nixpkgs> { inherit system; };
  callPackage = pkgs.lib.callPackageWith (pkgs // self);
  self = {
    gnomeExtensions = { no-title-bar = callPackage ./pkgs/no-title-bar { }; };
    libvitamtp = callPackage ./pkgs/libvitamtp { };
    qcma = callPackage ./pkgs/qcma { };
    finalhe = callPackage ./pkgs/finalhe { };
    pico-8 = callPackage ./pkgs/pico-8 { };
    voxatron = callPackage ./pkgs/voxatron { };
  };
in self
