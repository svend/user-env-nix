{ stdenv, fetchFromGitHub, rustPlatform }:

with rustPlatform;

buildRustPackage rec {
  pname = "scriptisto";
  version = "v0.6.5";

  src = fetchFromGitHub {
    owner = "igor-petruk";
    repo = "scriptisto";
    rev = version;
    sha256 = "0jm5v1rbcjprbk5c4djbra9w12jx728fr7gl8c2i9s8akfilaas0";
  };

  cargoSha256 = "1fnk33crzwpyj96jpbgspv13vdcwvfv4mjbss0a74p45fm8mskyd";

  meta = with stdenv.lib; {
    description = "A language-agnostic shebang interpreter that enables you to write scripts in compiled languages";
    homepage = https://github.com/igor-petruk/scriptisto;
    license = with licenses; [ unlicense ];
    maintainers = [ ];
    platforms = platforms.all;
  };
}
