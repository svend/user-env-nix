final: prev: {
  # age-plugin-yubikey = prev.rustPlatform.buildRustPackage rec {
  #   inherit (prev.age-plugin-yubikey.drvAttrs) pname nativeBuildInputs buildInputs;
  #   inherit (prev.age-plugin-yubikey) meta;
  #   version = "0.3.2";

  #   src = prev.fetchFromGitHub {
  #     owner = "str4d";
  #     repo = pname;
  #     rev = "v${version}";
  #     sha256 = "sha256-x4J8lE4Peenu3I7bZ3yoLpyukkMHD2re63GCni0cfnI=";
  #   };

  #   cargoSha256 = "sha256-Qp7AXy044G17FxR2sopN00cgX91A8TAydrwvJrAfhns=";
  # };
}
