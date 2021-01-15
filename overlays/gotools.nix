self: super:
{
  gotools = super.gotools.overrideAttrs (old: rec {
    # Do not install things like doc, link, and fix
    postConfigure = ''
      # # Make the builtin tools available here
      # mkdir -p $out/bin
      # eval $(go env | grep GOTOOLDIR)
      # find $GOTOOLDIR -type f | while read x; do
      #   ln -sv "$x" "$out/bin"
      # done
      # export GOTOOLDIR=$out/bin
    '';

    # Do not install bundle (conflicts with ruby bundler)

    excludedPackages = with super; "\\("
      + stdenv.lib.concatStringsSep "\\|" ([ "bundle" "testdata" "vet" "cover" ])
      + "\\)";
  });
}
