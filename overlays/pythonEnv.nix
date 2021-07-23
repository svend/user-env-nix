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
          pylint
          pyyaml
          requests
        ];
      })

      # https://github.com/NixOS/nixpkgs/pull/121382
      (with python38Packages; python.buildEnv.override {
        extraLibs = [
          python-language-server
        ];
      })

      # python39 # is the default
      python38
      python37
      python36

      pipenv # pipenv needs to be outside python.buildEnv
    ];
  };
}
