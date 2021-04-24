{
  description = "NixOS/nixpkgs development environment.";

  inputs = {
    nixpkgs.url = "nixpkgs";
    devshell.url = "github:numtide/devshell";
    flake-utils.url = "github:numtide/flake-utils";
  };

  outputs = { self, nixpkgs, devshell, flake-utils }:
    flake-utils.lib.eachDefaultSystem (system:
      {
        devShell = import ./shell.nix { inherit nixpkgs devshell system; templates = self.templates; };
      }
    )
    //
    {
      templates = {
        # either submit/maintain your language specific templates here, or link them here from an upstream flake
        go-module = { path = ./templates/go-module; description = "how-to package a go module for nixpkgs"; };
        go-package = { path = ./templates/go-package; description = "how-to package a go package for nixpkgs"; };
      };
    }
    ;
}
