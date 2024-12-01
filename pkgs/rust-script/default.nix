{
  lib,
  stdenv,
  fetchFromGitHub,
  rustPlatform,
}:

with rustPlatform;

buildRustPackage rec {
  pname = "rust-script";

  version = "v0.7.0";

  src = fetchFromGitHub {
    owner = "fornwall";
    repo = "rust-script";
    rev = version;
    sha256 = "sha256-qf8o8gG4PtP9GNUYGtkafgNjQzlbrguEXUjrJlDiDV8=";
  };

  cargoHash = "sha256-ITbdPK3dfGtEqZZd14FtrNlWWB1jV0yC0YrB63UhcsQ=";

  doCheck = false;

  meta = with lib; {
    description = "Run Rust files and expressions as scripts without any setup or compilation step";
    homepage = "https://github.com/fornwall/rust-script";
    # license = with licenses; [ unlicense ];
    maintainers = [ ];
    platforms = platforms.all;
  };
}
