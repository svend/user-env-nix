{ stdenv, fetchFromGitHub, rustPlatform, makeWrapper, Security }:

with rustPlatform;

buildRustPackage rec {
  name = "rust-script-${version}";
  version = "v0.7.0";

  src = fetchFromGitHub {
    owner = "fornwall";
    repo = "rust-script";
    rev = version;
    sha256 = "";
  };

  cargoSha256 = "";

  buildInputs = stdenv.lib.optional stdenv.isDarwin Security;

  meta = with stdenv.lib; {
    description = "Run Rust files and expressions as scripts without any setup or compilation step";
    homepage = https://github.com/fornwall/rust-script;
    # license = with licenses; [ unlicense ];
    maintainers = [ ];
    platforms = platforms.all;
  };
}
