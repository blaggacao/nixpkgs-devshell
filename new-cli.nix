{ lib, stdenv, templates }:
let
  name = "new";

  flake = ./.;

  TEMPLATES = lib.concatStringsSep ''" "'' (
    lib.flatten (
      lib.zipListsWith
        (a: b: [ a b ])
        (builtins.attrNames templates)
        (map (v: v.description) (builtins.attrValues templates))
    )
  );

in
stdenv.mkDerivation {
  inherit name;

  src = ./new-cli.sh;

  dontUnpack = true;
  dontBuild = true;


  installPhase = ''
    mkdir -p $out/bin
    install $src $out/bin/${name}
    substituteInPlace $out/bin/${name} \
      --replace '@TEMPLATES@' '${TEMPLATES}' \
      --replace '@flake@' '${flake}'
  '';

  checkPhase = ''
    ${stdenv.shell} -n -O extglob $out/bin/${name}
  '';

  meta.description = "Bootstrap a new contribution from templates";
}
