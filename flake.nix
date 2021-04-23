{
  description = "NixOS/nixpkgs development environment.";

  inputs = {
    nixpkgs.url = "nixpkgs";
    devshell.url = "github:numtide/devshell";
  };

  outputs = { self, nixpkgs, devshell }: {

    devShell = {
        x86_64-linux = import ./shell.nix { inherit nixpkgs devshell; system = "x86_64-linux"; };
        x86_64-darwin = import ./shell.nix { inherit nixpkgs devshell; system = "x86_64-darwin"; };
        aarch64-linux = import ./shell.nix { inherit nixpkgs devshell; system = "aarch64-linux"; };
    };

  };
}
