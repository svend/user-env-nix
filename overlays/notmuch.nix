final: prev: {
  notmuchWithConfig = prev.buildEnv {
    name = "notmuchWithConfig";
    buildInputs = [ prev.makeWrapper ];
    paths = [ final.notmuch ];
    postBuild = ''
      unlink "$out/bin"
      mkdir -p "$out/bin"
      for path in "${final.notmuch}"/bin/*; do
        bin=$(basename "$path")
        makeWrapper "$path" "$out/bin/$bin" --set-default NOTMUCH_CONFIG "${../config/notmuch/notmuch-config}"
      done
    '';
  };
}
