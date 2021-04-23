{
  description = "A very basic flake";

  outputs = { self, nixpkgs }: {

    packages.x86_64-linux.hello = nixpkgs.legacyPackages.x86_64-linux.hello;

    defaultPackage.x86_64-linux = self.packages.x86_64-linux.hello;

    devShell = {
        x86_64-linux = import ./shell.nix { system = "x86_64-linux"; };
        x86_64-darwin = import ./shell.nix { system = "x86_64-darwin"; };
        aarch64-linux = import ./shell.nix { system = "aarch64-linux"; };
    };

  };
}
