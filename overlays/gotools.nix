self: super: {
  gotools = super.gotools.overrideAttrs (old: rec {
    # Do not install bundle (conflicts with ruby bundler)
    excludedPackages = with super; "\\(" + pkgs.lib.concatStringsSep "\\|" ([ "bundle" ]) + "\\)";
  });
}
