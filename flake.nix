{
  inputs = {
    nixpkgs.url = "nixpkgs/nixos-24.05";
    flakelight.url = "github:nix-community/flakelight";
  };
  outputs =
    { flakelight, ... }:
    flakelight ./. {
      devShell.packages =
        pkgs: with pkgs; [
          autoconf
          automake
          ghc-7_10_3
          gtk2.dev
          stack
        ];
      package =
        { stdenv, pkgs }:
        (pkgs.haskellPackages.callPackage (
          {
            mkDerivation,
            array,
            base,
            cairo,
            containers,
            directory,
            filepath,
            glib,
            gtk,
            lens,
            lib,
            mtl,
            old-time,
            pipes,
            pipes-safe,
            process,
            streams,
            system-filepath,
            text,
            transformers,
            unix,
            vector,
          }:
          mkDerivation {
            pname = "eTeak";
            version = "0.4";
            src = ./.;
            isLibrary = true;
            isExecutable = true;
            libraryHaskellDepends = [
              array
              base
              cairo
              containers
              directory
              filepath
              glib
              gtk
              lens
              mtl
              old-time
              pipes
              pipes-safe
              process
              streams
              system-filepath
              text
              transformers
              unix
              vector
            ];
            executableHaskellDepends = [
              array
              base
              cairo
              containers
              directory
              filepath
              glib
              gtk
              mtl
              old-time
              process
              text
              unix
              vector
            ];
            homepage = "balangs.github.io";
            description = "This is the eTeak system. A GALS back end for the Balsa language";
            license = lib.licenses.gpl3;
          }
        ) { });
      withOverlays = self: super: {
        ghc-7_10_3 = self.nixpkgs-16_03.ghc;
        haskellPackages = self.nixpkgs-16_03.haskellPackages;
        nixpkgs-16_03 = import (builtins.fetchTarball {
          url = "https://github.com/NixOS/nixpkgs/archive/5d540387713f2d29dac423f5faadafd5aea2ff09.tar.gz";
          sha256 = "1ng3jz3v6y132hqzava82ncj62gban8gj6l9a15713qd4p3icmgw";
        }) { system = super.system; };
      };
    };
}
