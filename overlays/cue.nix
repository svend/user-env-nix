# TODO: Difficult to override go modules
# Bug report: https://github.com/NixOS/nixpkgs/issues/86349
# Workaround: https://discourse.nixos.org/t/inconsistent-vendoring-in-buildgomodule-when-overriding-source/9225/3
self: super: {
  # https://github.com/NixOS/nixpkgs/blob/master/pkgs/development/tools/cue/default.nix

  # cue = super.buildGoModule rec {
  #   # These are the attributes in cue/default.nix, except the ones that are
  #   # being overridden
  #   inherit (super.cue.drvAttrs) pname doCheck subPackages;
  #   inherit (super.cue) meta;
  #   version = "0.3.0";

  #   src = super.fetchgit {
  #     url = "https://cue.googlesource.com/cue";
  #     rev = "v${version}";
  #     sha256 = "sha256-tafAkQGn2aT6A1u7OeAfsZSST3bRshFPye3Y+noCaMA=";
  #   };

  #   vendorSha256 = "sha256-d8p/vsbJ/bQbT2xrqqCoU1sQB8MrwKOMwEYhNYTWe4I=";

  #   buildFlagsArray = [
  #     "-ldflags=-X cuelang.org/go/cmd/cue/cmd.version=${version}"
  #   ];
  # };
}
