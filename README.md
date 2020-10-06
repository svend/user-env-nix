# Nix User Environment Flake

## Initial Setup

See  https://nixos.wiki/wiki/Flakes

## Installation

Install flake into profile:

``` shell
nix profile install github:svend/user-env-nix/master
#  or
nix profile install github:svend/user-env-nix/<commit-sha>
```

## Updating

Update lock file:

``` shell
nix flake update --recreate-lock-file
# or
nix flake update --update-input nixos --update-input nixpkgs-unstable
```


