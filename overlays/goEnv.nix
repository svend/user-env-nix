self: super:
{
  goEnv = with self; super.buildEnv {
    name = "goEnv";
    paths = [
      go

      # # Legacy dependency management tools
      # dep
      # glide

      # Development tools
      gofumpt # stricter gofmt/goimports
      golangci-lint # includes golint, errcheck, govet (https://golangci-lint.run/usage/linters)
      gopls
      gotools # godoc (doc web server), goimports
      govulncheck

      go2nix
      pprof
    ];
  };
}
