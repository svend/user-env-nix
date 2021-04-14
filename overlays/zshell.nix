self: super:
{
  zshWithConfig =
    super.buildEnv {
      name = "zshWithConfig";
      buildInputs = [ super.makeWrapper ];
      paths = [ self.zsh ];
      postBuild = ''
        unlink "$out/bin"
        mkdir -p "$out/bin"
        for path in "${self.zsh}"/bin/*; do
          bin=$(basename "$path")
          makeWrapper "$path" "$out/bin/$bin" --set-default ZDOTDIR "${../config/zsh}" --set MY_NIX_PATH "${self.myPkgs}/bin:$out/bin"
        done
      '';
    };
}
