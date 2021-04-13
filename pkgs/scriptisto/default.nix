{ lib, stdenv, fetchFromGitHub, rustPlatform }:

with rustPlatform;

buildRustPackage rec {
  pname = "scriptisto";
  version = "v0.6.5";

  src = fetchFromGitHub {
    owner = "igor-petruk";
    repo = "scriptisto";
    rev = version;
    sha256 = "sha256-QCtFo5sK6RQFQ/Sd7JA4XYrAk8pLNsLKXPlKtnLYpUo=";
  };

  cargoSha256 = "sha256-fNKSkRxk6Qj7qglBSvG0sGYkC7Q1pjulwR8vy2dg3jg=";

  meta = with lib; {
    description = "A language-agnostic shebang interpreter that enables you to write scripts in compiled languages";
    homepage = https://github.com/igor-petruk/scriptisto;
    license = with licenses; [ unlicense ];
    maintainers = [ ];
    platforms = platforms.all;
  };
}
