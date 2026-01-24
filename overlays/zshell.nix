final: prev: {
  zshWithConfig = prev.buildEnv {
    name = "zshWithConfig";
    buildInputs = [ prev.makeWrapper ];
    paths = [ final.zsh ];
    postBuild = ''
      unlink "$out/bin"
      mkdir -p "$out/bin"
      for path in "${final.zsh}"/bin/*; do
        bin=$(basename "$path")
        makeWrapper "$path" "$out/bin/$bin" --set-default ZDOTDIR "${../config/zsh}"
      done
    '';
    passthru = {
      shellPath = "/bin/zsh";
    };
  };
}
