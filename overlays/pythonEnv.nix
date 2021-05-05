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
          python-language-server
          pyyaml
          requests
        ];
      })

      python39
      # python38 is the default
      python37
      python36

      pipenv # pipenv needs to be outside python.buildEnv
    ];
  };
}
