final: prev: {
  gitConfig =
    let
      gitIgnore = prev.fetchFromGitHub {
        owner = "github";
        repo = "gitignore";
        rev = "218a941be92679ce67d0484547e3e142b2f5f6f0";
        sha256 = "sha256-iNpWJxBO5UZoNtfxu27u2wJxTyphk51kywn3WEkHVPk=";
      };
    in
    prev.runCommand "gitConfig"
      {
        config = ../config/git/config;
        localIgnore = ../config/git/ignore.local;
      }
      ''
        mkdir -p "$out/git"
        cp "$config" "$out/git/config"
        cat "$localIgnore" > "$out/git/ignore"
        for f in Global/Emacs.gitignore Global/Vim.gitignore Global/macOS.gitignore; do
          cat "${gitIgnore}/$f" >> "$out/git/ignore"
        done
      '';

  gitWithConfig = prev.buildEnv {
    name = "gitWithConfig";
    buildInputs = [ prev.makeWrapper ];
    paths = [ final.git ];
    postBuild = ''
      unlink "$out/bin"
      mkdir -p "$out/bin"
      for path in "${final.git}"/bin/*; do
        bin=$(basename "$path")
        makeWrapper "$path" "$out/bin/$bin" --set XDG_CONFIG_HOME "${final.gitConfig}"
      done
    '';
  };
}
