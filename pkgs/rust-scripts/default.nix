{ stdenv, fetchFromGitHub, rustPlatform }:

with rustPlatform;

buildRustPackage rec {
  name = "rust-scripts-${version}";
  version = "0.1.0";

  src = fetchFromGitHub {
    owner = "svend";
    repo = "rust-scripts";
    # rev = "${version}";
    rev = "761dc59755ee95de59766545cb0eda2b9166aa83";
    sha256 = "0id75iscyd3cr52jaiq3lx9v115x1ix44y5nwaq382cdchsmzs1i";
  };

  cargoSha256 = "1dx3mmzxsbvwpr8wf2g4gglv8cfyv8d4gmx1w52cqpvwqgwdkn2f";

  meta = with stdenv.lib; {
    description = "Various rust scripts";
    homepage = https://github.com/svend/rust-scripts;
    license = with licenses; [ unlicense ];
    maintainers = [ ];
    platforms = platforms.all;
  };
}
