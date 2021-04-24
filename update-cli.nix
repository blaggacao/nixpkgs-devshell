{ stdenv }:
let
  name = "update";
in
stdenv.mkDerivation {
  inherit name;

  src = ./update-cli.sh;

  dontUnpack = true;
  dontBuild = true;

  installPhase = ''
    mkdir -p $out/bin
    install $src $out/bin/${name}
  '';

  checkPhase = ''
    ${stdenv.shell} -n -O extglob $out/bin/${name}
  '';

  meta.description = "Update a package / your contribution";
}
