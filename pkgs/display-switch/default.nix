{ lib, stdenv, fetchFromGitHub, rustPlatform, udev, pkgconfig }:

rustPlatform.buildRustPackage {
  pname = "display-switch";
  version = "dev";

  src = fetchFromGitHub {
    owner = "haimgel";
    repo = "display-switch";
    rev = "1c9ba1990e9c288ca39c216d9f860804da9adc32";
    sha256 = "sha256-/9nj7DxC1HN5eI2r2BUbqH7CiG1+EinDC4xbxhqYl3Q=";
  };

  cargoSha256 = "sha256-PyJSx8CY4qkIf6BDgxigaN9nBKzrCq1oy5qLul1eVTs=";

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
