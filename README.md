# Nix User Environment Flake

> Reproducible development environment powered by Nix Flakes

## Initial Setup

See  https://nixos.wiki/wiki/Flakes

## Installation

Install flake into profile:

``` shell
nix profile install github:svend/user-env-nix
```

To update:

``` shell
nix flake update github:svend/user-env-nix && nix profile upgrade '.*'
```

## Updating

Update lock file:

``` shell
nix flake update --recreate-lock-file
# or
nix flake update --update-input nixpkgs-unstable
```

## Development

Running `nix build` will create `result/` which is a link to the build.

To run Emacs from the build, run:

``` shell
EMACSLOADPATH= result/bin/emacs
```

