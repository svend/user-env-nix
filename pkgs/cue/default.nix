# nixpkgs/pkgs/development/tools/cue/default.nix
{ buildGoModule, fetchgit, stdenv }:

buildGoModule rec {
  pname = "cue";
  version = "0.3.0-alpha6";

  src = fetchgit {
    url = "https://cue.googlesource.com/cue";
    rev = "v${version}";
    sha256 = "sha256-GhwfuC8Hb/LzPOvwB+VNcQxkB9hz0xxKJXWqKyJmIfg=";
  };

  vendorSha256 = "sha256-t03E/KGhwruyF39NJSeHhum3JprTUErMoOe3ixuvuXU=";
  doCheck = false;

  subPackages = [ "cmd/cue" ];

  buildFlagsArray = [
    "-ldflags=-X cuelang.org/go/cmd/cue/cmd.version=${version}"
  ];

  meta = {
    description = "A data constraint language which aims to simplify tasks involving defining and using data";
    homepage = "https://cuelang.org/";
    maintainers = with stdenv.lib.maintainers; [ solson ];
    license = stdenv.lib.licenses.asl20;
  };
}
