self: super:
{
  gotools = with super; gotools.overrideAttrs (old: rec {
    # Do not install things like `link`
    postConfigure = ''
      # # Make the builtin tools available here
      # mkdir -p $out/bin
      # eval $(go env | grep GOTOOLDIR)
      # find $GOTOOLDIR -type f | while read x; do
      #   ln -sv "$x" "$out/bin"
      # done
      # export GOTOOLDIR=$out/bin
    '';

    # Do not install bundle
    excludedPackages = "\\("
      + stdenv.lib.concatStringsSep "\\|" ([ "bundle" "testdata" "gopls" ] ++ stdenv.lib.optionals (stdenv.lib.versionAtLeast go.meta.branch "1.5") [ "vet" "cover" ])
      + "\\)";
  });
}
