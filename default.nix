{ system ? builtins.currentSystem }:

let
  pkgs = import <nixpkgs> { inherit system; };
  callPackage = pkgs.lib.callPackageWith (pkgs // self);
  self = {
    gnomeExtensions = { no-title-bar = callPackage ./pkgs/no-title-bar { }; };
  };
in self
