# TODO: Difficult to override go modules
# Bug report: https://github.com/NixOS/nixpkgs/issues/86349
# Workaround: https://discourse.nixos.org/t/inconsistent-vendoring-in-buildgomodule-when-overriding-source/9225/3
self: super: {
  # # FTB: module requires Go 1.19
  # steampipe = super.buildGoModule rec {
  #   # These are the attributes in steampipe/default.nix, except the ones that are
  #   # being overridden
  #   inherit (super.steampipe.drvAttrs) pname proxyVendor nativeBuildInputs ldflags postInstall;
  #   inherit (super.steampipe) meta;
  #   version = "0.16.4";
  #   src = super.fetchFromGitHub {
  #     owner = "turbot";
  #     repo = "steampipe";
  #     rev = "v${version}";
  #     sha256 = "sha256-awZlA02lKYpFdvCsGUC8Blv8FHek5XskkljseDGjDmk==";
  #   };
  #   vendorSha256 = "sha256-1E9segDcLqjnk0wqTYBgIQNKHlDCxdnQmADBs17Rcm8=";
  # };
}
