# TODO: Difficult to override go modules
# Bug report: https://github.com/NixOS/nixpkgs/issues/86349
# Workaround: https://discourse.nixos.org/t/inconsistent-vendoring-in-buildgomodule-when-overriding-source/9225/3
self: super: {
  age = super.buildGoModule rec {
    # These are the attributes in age/default.nix, except the ones that are
    # being overridden
    inherit (super.age.drvAttrs) pname ldflags nativeBuildInputs preInstall doInstallCheck installCheckPhase;
    inherit (super.age) meta;
    version = "1.1.1";
    src = super.fetchFromGitHub {
      owner = "FiloSottile";
      repo = "age";
      rev = "v${version}";
      sha256 = "sha256-LRxxJQLQkzoCNYGS/XBixVmYXoZ1mPHKvFicPGXYLcw=";
    };
    vendorSha256 = "sha256-XjJH3wyQXxj73JQUVkJFIBofijf+KERuRZ0gEhvhftA=";
    doCheck = !super.stdenv.isDarwin;
  };
}
