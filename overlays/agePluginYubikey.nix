# TODO: https://github.com/NixOS/nixpkgs/pull/208891
self: super: {
  age-plugin-yubikey = super.rustPlatform.buildRustPackage rec {
    inherit (super.age-plugin-yubikey.drvAttrs) pname nativeBuildInputs buildInputs;
    inherit (super.age-plugin-yubikey) meta;
    version = "0.3.2";

    src = super.fetchFromGitHub {
      owner = "str4d";
      repo = pname;
      rev = "v${version}";
      sha256 = "sha256-x4J8lE4Peenu3I7bZ3yoLpyukkMHD2re63GCni0cfnI=";
    };

    cargoSha256 = "sha256-Qp7AXy044G17FxR2sopN00cgX91A8TAydrwvJrAfhns=";
  };
}
