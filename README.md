# Nix User Environment Flake

> Reproducible development environment powered by Nix Flakes

## Initial Setup

See  https://nixos.wiki/wiki/Flakes

For NixOS, add the following to `/etc/nixos/configuration.nix`:

``` nix
{
  nix = {
    package = pkgs.nixUnstable;
    extraOptions = ''
      experimental-features = nix-command flakes ca-references
    '';
  };
}
```

Setting experimental-features in ~/.config/nix/nix.conf generates a warning on
NixOS, so set it in /etc/nix/nix.conf on non-NixOS systems:

``` shell
sudo mkdir -p /etc/nix
echo 'experimental-features = nix-command flakes ca-references' | sudo tee /etc/nix/nix.conf
```

## Installation

Install flake into profile:

``` shell
nix profile install github:svend/user-env-nix
```

To update:

``` shell
nix flake update github:svend/user-env-nix && nix profile upgrade <n>
# or
nix flake update github:svend/user-env-nix && nix profile upgrade '.*'
```

On NixOS, refresh user systemd unit files.

``` shell
systemd --user daemon-reload
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

## Flake Notes

Install the latest version of nix 3.0pre into user profile:

``` shell
nix profile install nixpkgs/nixpkgs-unstable#nixUnstable
```

To show build logs, use the `--print-build-logs|-L` flag. This flag does not
show up in `--help`.

``` shell
nix build --print-build-logs
```

