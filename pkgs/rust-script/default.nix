{ stdenv, fetchFromGitHub, rustPlatform }:

with rustPlatform;

buildRustPackage rec {
  name = "rust-script-${version}";
  version = "v0.7.0";

  src = fetchFromGitHub {
    owner = "fornwall";
    repo = "rust-script";
    rev = version;
    sha256 = "sha256-qf8o8gG4PtP9GNUYGtkafgNjQzlbrguEXUjrJlDiDV8=";
  };

  cargoSha256 = "sha256-KFi07KQiCtp2BGrPRPpKZbEfgmzgqamKLrh9yR/VO24=";

  doCheck = false;

  meta = with stdenv.lib; {
    description = "Run Rust files and expressions as scripts without any setup or compilation step";
    homepage = https://github.com/fornwall/rust-script;
    # license = with licenses; [ unlicense ];
    maintainers = [ ];
    platforms = platforms.all;
  };
}
