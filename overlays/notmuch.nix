self: super:
{
  notmuchWithConfig =
    super.buildEnv {
      name = "notmuchWithConfig";
      buildInputs = [ super.makeWrapper ];
      paths = [ self.notmuch ];
      postBuild = ''
        unlink "$out/bin"
        mkdir -p "$out/bin"
        for path in "${self.notmuch}"/bin/*; do
          bin=$(basename "$path")
          makeWrapper "$path" "$out/bin/$bin" --set-default NOTMUCH_CONFIG "${../config/notmuch/notmuch-config}"
        done
      '';
    };
}
