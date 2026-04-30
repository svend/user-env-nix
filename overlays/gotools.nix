final: prev: {
  gotools = prev.gotools.overrideAttrs (old: rec {
    # Do not install bundle (conflicts with ruby bundler)
    # TODO: Do not install modernize (conflicts with gopls)
    # https://github.com/NixOS/nixpkgs/issues/509480
    excludedPackages = with prev; "\\(" + pkgs.lib.concatStringsSep "\\|" ([ "bundle" "modernize" ]) + "\\)";
  });
}
