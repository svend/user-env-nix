# TODO: Difficult to override go modules
# Bug report: https://github.com/NixOS/nixpkgs/issues/86349
# Workaround: https://discourse.nixos.org/t/inconsistent-vendoring-in-buildgomodule-when-overriding-source/9225/3
self: super: {
  # gopls = super.buildGoModule rec {
  #   # These are the attributes in gopls/default.nix, except the ones that are
  #   # being overridden
  #   inherit (super.gopls.drvAttrs) pname modRoot doCheck subPackages;
  #   inherit (super.gopls) meta;
  #   version = "0.6.10";
  #   src = super.fetchgit {
  #     rev = "gopls/v${version}";
  #     url = "https://go.googlesource.com/tools";
  #     sha256 = "sha256-manbV2Yz5SnDl2DIM2QMP8aIX8fUQtChDvZVinc2u44=";
  #   };
  #   vendorSha256 = "sha256-Ea/XmoQg2NP5jFLkLsKVK1P1KPlnLBsRqsMh3ebWVwU=";
  # };
}
