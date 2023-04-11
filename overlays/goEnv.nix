self: super:
{
  goEnv = with self; super.buildEnv {
    name = "goEnv";
    paths = [
      # TODO: Switch back to "go" when 1.19 becomes the default (https://github.com/NixOS/nixpkgs/issues/192333)
      # go
      go_1_19

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
