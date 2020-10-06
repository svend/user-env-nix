{ stdenv, fetchFromGitHub, rustPlatform, makeWrapper, Security }:

with rustPlatform;

buildRustPackage rec {
  name = "scriptisto-${version}";
  version = "v0.6.5";

  src = fetchFromGitHub {
    owner = "igor-petruk";
    repo = "scriptisto";
    rev = version;
    sha256 = "0jm5v1rbcjprbk5c4djbra9w12jx728fr7gl8c2i9s8akfilaas0";
  };

  # buildRustPackage requires a cargoSha256 attribute which is computed over all
  # crate sources of this package. Currently it is obtained by inserting a fake
  # checksum into the expression and building the package once. The correct
  # checksum can be then take from the failed build.
  cargoSha256 = "1fnk33crzwpyj96jpbgspv13vdcwvfv4mjbss0a74p45fm8mskyd";

  buildInputs = stdenv.lib.optional stdenv.isDarwin Security;

  meta = with stdenv.lib; {
    description = "A language-agnostic shebang interpreter that enables you to write scripts in compiled languages";
    homepage = https://github.com/igor-petruk/scriptisto;
    license = with licenses; [ unlicense ];
    maintainers = [ ];
    platforms = platforms.all;
  };
}
