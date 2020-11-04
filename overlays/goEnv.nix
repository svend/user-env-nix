self: super:
{
  goEnv = with self; super.buildEnv {
    name = "goEnv";
    paths = [
      go

      # Legacy dependency management tools
      dep
      glide

      # Development tools
      golangci-lint # includes golint, errcheck, govet (https://golangci-lint.run/usage/linters)
      gopls # replaces gocode and godef
      gotools # godoc (doc web server), goimports

      go2nix
      pprof
    ];
  };
}
