self: super:
{
  # See https://github.com/NixOS/nixpkgs/issues/10597#issuecomment-313908853
  pythonEnv = with self; super.buildEnv {
    name = "pythonEnv";
    ignoreCollisions = true;
    paths = [
      (with python37Packages; python.buildEnv.override {
        extraLibs = [
          black
          flake8
          isort
          pylint
          pyyaml
          requests
        ];
      })

      python36

      (with python27Packages; python.buildEnv.override {
        extraLibs = [
          pip
          virtualenv
        ];
      })

      pipenv
    ];
  };
}
