final: prev: {
  goEnv =
    with final;
    prev.buildEnv {
      name = "goEnv";
      paths = [
        # Default version of go:
        # https://search.nixos.org/packages?channel=unstable&show=go&from=0&size=50&sort=relevance&type=packages&query=go
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

        pprof
      ];
    };
}
