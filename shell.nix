{ nixpkgs, devshell, system ? builtins.currentSystem }:
let

  pkgs = import nixpkgs {
    inherit system;
    overlays = [ devshell.overlay ];
  };

in
pkgs.devshell.mkShell {

  imports = [ "${pkgs.devshell.extraModulesDir}/git/hooks.nix" ];

  git.hooks = {
    enable = true;
    pre-commit.text = pkgs.lib.fileContents ./pre-commit.sh;
  };

  devshell = {
    name = "nixpkgs";
    packages = with pkgs; [
      fd
      nixpkgs-fmt
      editorconfig-checker
    ];
  };

  commands = with pkgs; [
    {
      package = editorconfig-checker;
      category = "linters";
    }
    {
      name = "fmt";
      help = "Check Nix formatting";
      category = "linters";
      command = "nixpkgs-fmt $${@} .";
    }
    {
      name = "evalnix";
      help = "Check Nix parsing";
      category = "linters";
      command = "fd --extension nix --exec nix-instantiate --parse --quiet {} >/dev/null";
    }
  ];
}

