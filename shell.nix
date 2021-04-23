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
      nixpkgs-review
      nix-update
      # nixpkgs-hammering
    ];
  };

  commands = with pkgs; let
    linters =
      map (e: e // { category = "linters"; } )
        [ {
          package = editorconfig-checker;
        } {
          name = "fmt";
          help = "Check Nix formatting";
          command = "nixpkgs-fmt $${@} .";
        } {
          name = "evalnix";
          help = "Check Nix parsing";
          command = "fd --extension nix --exec nix-instantiate --parse --quiet {} >/dev/null";
        } ]
    ;
    github =
      map (e: e // { category = "github"; } )
        [ {
          package = "gitAndTools.gh";
        } {
          name = "bugs";
          help = "List issues labeled as bugs";
          command = "set -x; gh issue list --label=\"0.kind: bug\"";
        } {
          name = "packaging-requests";
          help = "List issues labeled as packaging requests (chill out work)";
          command = "set -x; gh issue list --label=\"0.kind: packaging request\"";
        } {
          name = "pr-status";
          help = "Information about relevant PRs";
          command = "set -x; gh pr status";
        } {
          name = "issue-status";
          help = "Information about relevant issues";
          command = "set -x; gh issue status";
        } ]
    ;
    workflow =
      map (e: e // { category = "workflow"; } )
        [ {
          name = "review";
          help = pkgs.nixpkgs-review.meta.description;
          command = "set -x; nixpkgs-review $${@}";
        } {
          name = "update";
          help = pkgs.nix-update.meta.description;
          command = "set -x; nix-update $${@}";
        # } {
        #   name = "hammer";
        #   help = pkgs.nixpkgs-hammering.meta.description;
        #   command = "set -x; nixpkgs-hammering $${@}";
        } ]
    ;
  in linters ++ github ++ workflow;

}

