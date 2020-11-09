self: super:
{
  gitConfig = super.runCommand "gitConfig" { } ''
    mkdir -p "$out"
    cp -r "${../config/git}" "$out/git"
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
