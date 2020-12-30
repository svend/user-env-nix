# TODO: Difficult to override go modules
# Bug report: https://github.com/NixOS/nixpkgs/issues/86349
# Workaround: https://discourse.nixos.org/t/inconsistent-vendoring-in-buildgomodule-when-overriding-source/9225/3
self: super: {
  gopls = super.buildGoModule rec {
    # These are the attributes in gopls/default.nix, except the ones that are
    # being overridden
    inherit (super.gopls.drvAttrs) pname modRoot doCheck subPackages;
    inherit (super.gopls) meta;
    version = "0.6.1";
    src = super.fetchgit {
      rev = "gopls/v${version}";
      url = "https://go.googlesource.com/tools";
      sha256 = "sha256-Rf+vZXKIM6pL9iv4INr46BUhfhmzXvvSLLPMYKLSG3A=";
    };
    vendorSha256 = "sha256-g1MIua1b+xxI/1JpyLxGn7d231HMhG1+dMuPsHQ03dE=";
  };
}
