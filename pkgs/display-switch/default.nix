{ lib, stdenv, fetchFromGitHub, rustPlatform, udev, pkgconfig }:

rustPlatform.buildRustPackage {
  pname = "display-switch";
  version = "dev";

  # TODO: https://github.com/haimgel/display-switch/pull/66
  src = fetchFromGitHub {
    owner = "svend";
    repo = "display-switch";
    rev = "83d5e9bdc25f24ae214e755f7412f2aa54454d7b";
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
