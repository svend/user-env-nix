# TODO: Difficult to override go modules
# Bug report: https://github.com/NixOS/nixpkgs/issues/86349
# Workaround: https://discourse.nixos.org/t/inconsistent-vendoring-in-buildgomodule-when-overriding-source/9225/3
self: super: {
  # https://github.com/NixOS/nixpkgs/blob/master/pkgs/development/tools/cue/default.nix

  cue = super.buildGoModule rec {
    # These are the attributes in cue/default.nix, except the ones that are
    # being overridden
    inherit (super.cue.drvAttrs) pname doCheck subPackages;
    inherit (super.cue) meta;
    version = "0.4.0";

    src = super.fetchgit {
      url = "https://cue.googlesource.com/cue";
      rev = "v${version}";
      sha256 = "sha256-rcGEl+CMFyxZKsOKhVimhv5/ONo3xS6FjgKModZGR2o=";
    };

    vendorSha256 = "sha256-eSKVlBgnHR1R0j1lNwtFoIgRuj8GqoMbvuBl/N1SanY=";

    buildFlagsArray = [
      "-ldflags=-X cuelang.org/go/cmd/cue/cmd.version=${version}"
    ];
  };
}
