# TODO: Difficult to override go modules
# Bug report: https://github.com/NixOS/nixpkgs/issues/86349
# Workaround: https://discourse.nixos.org/t/inconsistent-vendoring-in-buildgomodule-when-overriding-source/9225/3
self: super: {
  cue = super.buildGoModule rec {
    # These are the attributes in cue/default.nix, except the ones that are
    # being overridden
    inherit (super.cue.drvAttrs) pname doCheck subPackages;
    inherit (super.cue) meta;
    version = "0.3.0-beta.2";

    src = super.fetchgit {
      url = "https://cue.googlesource.com/cue";
      rev = "v${version}";
      sha256 = "sha256-/r+pqIysXiLp0EgPKuoGV/c6bIZ/kKG1zC1lYl6CnZo=";
    };

    vendorSha256 = "sha256-t03E/KGhwruyF39NJSeHhum3JprTUErMoOe3ixuvuXU=";

    buildFlagsArray = [
      "-ldflags=-X cuelang.org/go/cmd/cue/cmd.version=${version}"
    ];
  };
}
