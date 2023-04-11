self: super:
{
  # See https://github.com/NixOS/nixpkgs/issues/10597#issuecomment-313908853
  pythonEnv = with self; super.buildEnv {
    name = "pythonEnv";
    ignoreCollisions = true;
    paths = [
      (with python3Packages; python.buildEnv.override {
        extraLibs = [
          black
          flake8
          isort
          python-lsp-server
          pylint
          pyyaml
          requests
        ];
      })

      # python310 # default
      # python39 # is the default
      # python38

      pipenv # pipenv needs to be outside python.buildEnv
    ];
  };
}
