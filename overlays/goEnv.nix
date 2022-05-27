self: super:
{
  goEnv = with self; super.buildEnv {
    name = "goEnv";
    paths = [
      # TODO: Switch back to "go" when 1.18 becomes the default
      # go
      go_1_18

      # # Legacy dependency management tools
      # dep
      # glide

      # Development tools
      gofumpt # stricter gofmt/goimports
      golangci-lint # includes golint, errcheck, govet (https://golangci-lint.run/usage/linters)
      gopls # replaces gocode and godef
      gotools # godoc (doc web server), goimports

      go2nix
      pprof
    ];
  };
}
