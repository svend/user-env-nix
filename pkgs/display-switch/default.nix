{ lib, stdenv, fetchFromGitHub, rustPlatform, udev, pkg-config }:

rustPlatform.buildRustPackage {
  pname = "display-switch";
  version = "dev";

  src = fetchFromGitHub {
    owner = "haimgel";
    repo = "display-switch";
    rev = "1.2.0";
    sha256 = "sha256-irNX2z3lc6HgdpRz1B+jCmMn5i5MTYRQAOUbZG7BGq8=";
  };

  cargoSha256 = "sha256-JIdJuYkvI0eCCSZJWJQVDGZNc9FivprxFK/qq+/Zla4=";

  nativeBuildInputs = [ pkg-config ];
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
