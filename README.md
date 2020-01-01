# nixpkgs-overlay

My personal [nixpkgs][nixpkgs] repository.

## Usage

### Adding a channel

```bash
$ nix-channel --add
https://github.com/maxeaubrey/nixpkgs-overlay/archive/master.tar.gz
nixpkgs-maxine
$ nix-channel --update nixpkgs-maxine
```

### Using Packages

```nix
{ config, pkgs, ... }:

let
  maxine = import <nixpkgs-maxine> { };
in

{
  environment.systemPackages = [ maxine.packageName ];
}
```

### In a `shell.nix`

```nix
{ pkgs ? import <nixpkgs> {} }:

with pkgs;

let
  maxine = import (builtins.fetchTarball
    https://github.com/maxeaubrey/nixpkgs-maxine/archive/master.tar.gz) {};
in

mkShell {
  buildInputs = [
    go
    perl
    maxine.trex
  ];
}
```

[nixpkgs]: https://github.com/nixos/nixpkgs
