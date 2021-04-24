{ stdenv }:
let
  name = "review";
in
stdenv.mkDerivation {
  inherit name;

  src = ./review-cli.sh;

  dontUnpack = true;
  dontBuild = true;

  installPhase = ''
    mkdir -p $out/bin
    install $src $out/bin/${name}
  '';

  checkPhase = ''
    ${stdenv.shell} -n -O extglob $out/bin/${name}
  '';

  meta.description = "Review your contribution against current upstream before submitting";
}
