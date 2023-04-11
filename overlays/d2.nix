# TODO: Difficult to override go modules
# Bug report: https://github.com/NixOS/nixpkgs/issues/86349
# Workaround: https://discourse.nixos.org/t/inconsistent-vendoring-in-buildgomodule-when-overriding-source/9225/3
self: super: {
  # https://github.com/NixOS/nixpkgs/blob/nixos-unstable/pkgs/tools/text/d2/default.nix

  d2 = super.buildGoModule rec {
    # These are the attributes in d2/default.nix, except the ones that are
    # being overridden
    inherit (super.d2.drvAttrs) pname nativeBuildInputs postInstall subPackages;
    inherit (super.d2) meta;
    version = "0.2.0";

    src = super.fetchFromGitHub {
      owner = "terrastruct";
      repo = pname;
      rev = "v${version}";
      hash = "sha256-1AFioXDIh+qQYhhIaQky2SkGd+amnYdOeoNDU+1+poI=";
    };

    ldflags = [
      "-s"
      "-w"
      "-X oss.terrastruct.com/d2/lib/version.Version=${version}"
    ];

    vendorSha256 = "sha256-PtKKGHzxshahecbfvvo1nGCseap4o8r8raBpFDUSbx4=";
  };
}
