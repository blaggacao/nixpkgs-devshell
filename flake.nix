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
        devShell = import ./shell.nix { inherit nixpkgs devshell system; };
      }
    );
}
