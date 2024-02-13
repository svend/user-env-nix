{
  lib,
  stdenv,
  fetchFromGitHub,
  rustPlatform,
}:

with rustPlatform;

buildRustPackage {
  pname = "multi-x509";
  version = "0.1.0";

  src = fetchFromGitHub {
    owner = "svend";
    repo = "multi-x509";
    # rev = "${version}";
    rev = "3ba17ef69aa35478914ac22f3cad44ebf46bbbbf";
    sha256 = "sha256-0qLluFX/C9qKqkgHei9IaIkSMaAGiUXQtaCvHRXVXQc=";
  };

  # buildRustPackage requires a cargoSha256 attribute which is computed over all
  # crate sources of this package. Currently it is obtained by inserting a fake
  # checksum into the expression and building the package once. The correct
  # checksum can be then take from the failed build.
  cargoSha256 = "sha256-52jz9EjU+x3dp3OxpHHsk455lK1PHYC2jdGjbByvodw=";

  meta = with lib; {
    description = "Run a command on each x509 certificate";
    homepage = "https://github.com/svend/multi-x509";
    license = with licenses; [ unlicense ];
    maintainers = [ ];
    platforms = platforms.all;
  };
}
