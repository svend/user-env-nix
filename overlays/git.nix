self: super:
{
  gitIgnore = super.fetchFromGitHub {
    owner = "github";
    repo = "gitignore";
    rev = "218a941be92679ce67d0484547e3e142b2f5f6f0";
    sha256 = "sha256-iNpWJxBO5UZoNtfxu27u2wJxTyphk51kywn3WEkHVPk=";
  };

  gitConfig = super.runCommand "gitConfig"
    {
      config = ../config/git/config;
      localIgnore = ../config/git/ignore.local;
    } ''
    mkdir -p "$out/git"
    cp "$config" "$out/git"
    cat "$localIgnore" > "$out/git/ignore"
    for f in Global/Emacs.gitignore Global/Vim.gitignore Global/macOS.gitignore; do
      cat "${self.gitIgnore}/$f" >> "$out/git/ignore"
    done
  '';

  gitWithConfig =
    super.buildEnv {
      name = "gitWithConfig";
      buildInputs = [ super.makeWrapper ];
      paths = [ self.git ];
      postBuild = ''
        unlink "$out/bin"
        mkdir -p "$out/bin"
        for path in "${self.git}"/bin/*; do
          bin=$(basename "$path")
          makeWrapper "$path" "$out/bin/$bin" --set XDG_CONFIG_HOME "${self.gitConfig}"
        done
      '';
    };
}
