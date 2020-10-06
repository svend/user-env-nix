{ stdenv, fetchFromGitHub, rustPlatform, makeWrapper, Security }:

with rustPlatform;

buildRustPackage rec {
  name = "multi-x509-${version}";
  version = "0.1.0";

  src = fetchFromGitHub {
    owner = "svend";
    repo = "multi-x509";
    # rev = "${version}";
    rev = "cef61c7900de156fc24444767b39d05eef2a1a53";
    sha256 = "00mpshjii1hlaa0hy2zd039vy6m1w0qcp2i9ia25ijwjafkk394s";
  };

  # buildRustPackage requires a cargoSha256 attribute which is computed over all
  # crate sources of this package. Currently it is obtained by inserting a fake
  # checksum into the expression and building the package once. The correct
  # checksum can be then take from the failed build.
  cargoSha256 = "1ylp57mzfqav8c2hkz55grxv0lgf2cbhql7adri1bgc44wv30akq";

  buildInputs = stdenv.lib.optional stdenv.isDarwin Security;

  meta = with stdenv.lib; {
    description = "Run a command on each x509 certificate";
    homepage = https://github.com/svend/multi-x509;
    license = with licenses; [ unlicense ];
    maintainers = [ ];
    platforms = platforms.all;
  };
}
