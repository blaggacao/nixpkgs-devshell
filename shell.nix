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
    {
      package = "gitAndTools.gh";
      category = "github";
    }
    {
      name = "bugs";
      help = "List issues labeled as bugs";
      category = "github";
      command = "gh issue list --label=\"0.kind: bug\"";
    }
    {
      name = "packaging-requests";
      help = "List issues labeled as packaging requests (chill out work)";
      category = "github";
      command = "gh issue list --label=\"0.kind: packaging request\"";
    }
    {
      name = "pr-status";
      help = "Information about relevant PRs";
      category = "github";
      command = "gh pr status";
    }
    {
      name = "issue-status";
      help = "Information about relevant issues";
      category = "github";
      command = "gh issue status";
    }
  ];
}

