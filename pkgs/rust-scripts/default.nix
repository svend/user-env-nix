{
  lib,
  stdenv,
  fetchFromGitHub,
  rustPlatform,
}:

with rustPlatform;

buildRustPackage rec {
  pname = "rust-scripts";
  version = "0.1.0";

  src = fetchFromGitHub {
    owner = "svend";
    repo = "rust-scripts";
    # rev = version;
    rev = "761dc59755ee95de59766545cb0eda2b9166aa83";
    sha256 = "sha256-MehfNWSNCTSw4rZ4QnoMvYSwU6cDRyVFyWw0z3Qsp0U=";
  };

  cargoSha256 = "sha256-zSdVAUPGKSlD2Xma4piCyHO9eHcIJd+o3xMZCcIGSjk=";

  meta = with lib; {
    description = "Various rust scripts";
    homepage = "https://github.com/svend/rust-scripts";
    license = with licenses; [ unlicense ];
    maintainers = [ ];
    platforms = platforms.all;
  };
}
