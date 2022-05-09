# TODO: https://github.com/NixOS/nixpkgs/issues/168984
self: super: {
  golangci-lint = super.golangci-lint.override ({
    # Override https://github.com/NixOS/nixpkgs/pull/166801 which changed this
    # to buildGo118Module because it does not build on Darwin.
    buildGoModule = super.buildGoModule;
  });
}
