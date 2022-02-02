# TODO: Difficult to override go modules
# Bug report: https://github.com/NixOS/nixpkgs/issues/86349
# Workaround: https://discourse.nixos.org/t/inconsistent-vendoring-in-buildgomodule-when-overriding-source/9225/3
self: super: {
  # These are the attributes in the upstream default.nix, except the ones that are
  # being overridden
  steampipe = super.buildGoModule rec {
    inherit (super.steampipe.drvAttrs) pname version src doCheck nativeBuildInputs ldflags postInstall;
    inherit (super.steampipe) meta;

    vendorSha256 = "sha256-cw0Xoa+BM+pgFtgCmSgADJXTH8tfp1hGbFKY1pVk3tk=";
  };
}
