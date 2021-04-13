{ lib, stdenv, fetchFromGitHub, rustPlatform }:

with rustPlatform;

buildRustPackage {
  pname = "multi-x509";
  version = "0.1.0";

  src = fetchFromGitHub {
    owner = "svend";
    repo = "multi-x509";
    # rev = "${version}";
    rev = "cef61c7900de156fc24444767b39d05eef2a1a53";
    sha256 = "sha256-mqQxp1OSy1iEiimKyzDgoRq/0wDtCw+BUhSGGCXUtwI=";
  };

  # buildRustPackage requires a cargoSha256 attribute which is computed over all
  # crate sources of this package. Currently it is obtained by inserting a fake
  # checksum into the expression and building the package once. The correct
  # checksum can be then take from the failed build.
  cargoSha256 = "sha256-STTfmDKFNLWPwpBZ3lq7hSZxaD4Y4cJtj7yaxfp+I+U=";

  meta = with  lib; {
    description = "Run a command on each x509 certificate";
    homepage = https://github.com/svend/multi-x509;
    license = with licenses; [ unlicense ];
    maintainers = [ ];
    platforms = platforms.all;
  };
}
