self: super:
{
  gitConfig = super.runCommand "gitConfig"
    {
      config = ../config/git;
    } ''
    mkdir -p "$out"
    cp -r "$config" "$out/git"
  '';

  gitWithConfig =
    let
      inherit (self) git gitConfig;
    in
    super.buildEnv {
      name = "gitWithConfig";
      buildInputs = [ super.makeWrapper ];
      paths = [ git ];
      postBuild = ''
        unlink "$out/bin"
        mkdir -p "$out/bin"
        for path in "${self.git}"/bin/*; do
          bin=$(basename "$path")
          makeWrapper "$path" "$out/bin/$bin" --set XDG_CONFIG_HOME "${gitConfig}"
        done
      '';
    };

  notmuchWithConfig =
    let
      inherit (self) notmuch;
      config = ../config/notmuch/notmuch-config;
    in
    super.buildEnv {
      name = "notmuchWithConfig";
      buildInputs = [ super.makeWrapper ];
      paths = [ notmuch ];
      postBuild = ''
        unlink "$out/bin"
        mkdir -p "$out/bin"
        for path in "${notmuch}"/bin/*; do
          bin=$(basename "$path")
          makeWrapper "$path" "$out/bin/$bin" --set-default NOTMUCH_CONFIG "${config}"
        done
      '';
    };

  zshWithConfig =
    let
      inherit (self) zsh;
      config = ../config/zsh;
    in
    super.buildEnv {
      name = "zshWithConfig";
      buildInputs = [ super.makeWrapper ];
      paths = [ zsh ];
      postBuild = ''
        unlink "$out/bin"
        mkdir -p "$out/bin"
        for path in "${zsh}"/bin/*; do
          bin=$(basename "$path")
          makeWrapper "$path" "$out/bin/$bin" --set-default ZDOTDIR "${config}"
        done
      '';
    };
}
