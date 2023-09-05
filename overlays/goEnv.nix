self: super:
{
  goEnv = with self; super.buildEnv {
    name = "goEnv";
    paths = [
      go_1_21 # TODO: switch to `go` when 1.21 becomes the default version (https://github.com/NixOS/nixpkgs/blob/97927dfad9abf6f2d1b3144d069024911a7ecf1f/pkgs/top-level/all-packages.nix#L25999)

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
