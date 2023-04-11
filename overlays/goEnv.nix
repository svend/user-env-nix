self: super:
{
  goEnv = with self; super.buildEnv {
    name = "goEnv";
    paths = [
      go_1_20 # TODO set to go after 1.20 becomes the default

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
