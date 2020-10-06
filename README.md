# Nix User Environment Flake

Install flake into profile:

``` shell
nix profile install github:svend/user-env-nix
# or
nix profile install github:svend/user-env-nix/<commit-sha>
```

Update lock file:

``` shell
nix flake update --update-input nixos --update-input master
```

See  https://nixos.wiki/wiki/Flakes
