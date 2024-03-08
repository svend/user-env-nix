final: prev: {
  gotools = prev.gotools.overrideAttrs (old: rec {
    # Do not install bundle (conflicts with ruby bundler)
    excludedPackages = with prev; "\\(" + pkgs.lib.concatStringsSep "\\|" ([ "bundle" ]) + "\\)";
  });
}
