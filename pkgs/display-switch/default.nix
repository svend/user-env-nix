{ lib, stdenv, fetchFromGitHub, rustPlatform, udev, pkgconfig }:

rustPlatform.buildRustPackage {
  pname = "display-switch";
  version = "dev";

  src = fetchFromGitHub {
    owner = "haimgel";
    repo = "display-switch";
    rev = "7ce57aff36603ad081c8a5674f988291b9507fb9";
    sha256 = "sha256-v5MQiFobCdi+6pkmAXiAvN5ZJNNR5wMx/uMHAacxDJQ=";
  };

  cargoSha256 = "sha256-KAwtEh/qkd6FoT1shQdHdbsLJsvnguZUBdU9rx3m8D8=";

  nativeBuildInputs = [ pkgconfig ];
  buildInputs = [ udev ];

  doCheck = false;

  meta = with lib; {
    description = "";
    homepage = "";
    license = licenses.mit;
    maintainers = with maintainers; [ ];
    platforms = platforms.all; # Linux, Darwin, Windows
  };
}
