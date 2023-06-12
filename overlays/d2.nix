# TODO: Difficult to override go modules
# Bug report: https://github.com/NixOS/nixpkgs/issues/86349
# Workaround: https://discourse.nixos.org/t/inconsistent-vendoring-in-buildgomodule-when-overriding-source/9225/3
self: super: {
  # https://github.com/NixOS/nixpkgs/blob/nixos-unstable/pkgs/tools/text/d2/default.nix
  d2 = super.buildGoModule rec {
    # These are the attributes in d2/default.nix, except the ones that are
    # being overridden
    inherit (super.d2.drvAttrs) pname excludedPackages nativeBuildInputs postInstall preCheck;
    inherit (super.d2) meta;
    version = "0.5.1";

    vendorHash = "sha256-SocBC/1LrdSQNfcNVa9nnPaq/UvLVIghHlUSJB7ImBk=";

    src = super.fetchFromGitHub {
      owner = "terrastruct";
      repo = pname;
      rev = "v${version}";
      hash = "sha256-Oq6bJ/cX+kDyVUVP/RpCIcNeWpT3HESUMmR6mEi9X4Q=";
    };

    ldflags = [
      "-s"
      "-w"
      "-X oss.terrastruct.com/d2/lib/version.Version=${version}"
    ];
  };
}
