self: super:
{
  # See https://github.com/NixOS/nixpkgs/issues/10597#issuecomment-313908853
  pythonEnv = with self; super.buildEnv {
    name = "pythonEnv";
    ignoreCollisions = true;
    paths = [
      (with python39Packages; python.buildEnv.override {
        extraLibs = [
          black
          flake8
          isort
          pylint
          pyyaml
          requests
        ];
      })

      python38
      python37
      python36

      # 2021-04-26: python 2.7 FTB
      # error: builder for '/nix/store/xsd3gx6zraxcpjdgi5xjyzqa1gcrfpmz-python2.7-importlib_resources-5.1.2.drv' failed with exit code 1;
      # > distutils.errors.DistutilsOptionError: find_namespace: directive is unsupported on Python < 3.3

      # (with python27Packages; python.buildEnv.override {
      #   extraLibs = [
      #     pip
      #     virtualenv
      #   ];
      # })

      pipenv
    ];
  };
}
