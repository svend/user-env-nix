# TODO: Difficult to override go modules
# Bug report: https://github.com/NixOS/nixpkgs/issues/86349
# Workaround: https://discourse.nixos.org/t/inconsistent-vendoring-in-buildgomodule-when-overriding-source/9225/3
self: super: {
  # FTB
  # steampipe = super.buildGoModule rec {
  #   # These are the attributes in steampipe/default.nix, except the ones that are
  #   # being overridden
  #   inherit (super.steampipe.drvAttrs) pname proxyVendor nativeBuildInputs ldflags postInstall;
  #   inherit (super.steampipe) meta;
  #   version = "0.14.4";
  #   src = super.fetchFromGitHub {
  #     owner = "turbot";
  #     repo = "steampipe";
  #     rev = "v${version}";
  #     sha256 = "sha256-D6wsHqvLc7gS42dlBJd5eN1R9s3NOk+bMmqjCYb55j0=";
  #   };
  #   vendorSha256 = "sha256-Q8GA6Tap58S0Asdzaa9vmG9yc9ia5DSGVZ1s5dQzFAs=";
  # };
}
