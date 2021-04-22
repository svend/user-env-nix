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

For non-NixOS systems:

``` shell
mkdir -p ~/.config/nix
echo 'experimental-features = nix-command flakes ca-references' > ~/.config/nix/nix.conf
```

## Installation

Install flake into profile:

``` shell
nix profile install github:svend/user-env-nix
```

To update:

``` shell
nix profile upgrade <n>
# or
nix profile upgrade '.*'
```

On NixOS, refresh user systemd unit files.

``` shell
systemd --user daemon-reload
```

## Updating

Update lock file:

``` shell
nix flake update
```

Update a single input:

``` shell
nix flake lock --update-input nixpkgs-unstable
```

## Development

Running `nix build` will create `result/` which is a link to the build.

To run Emacs from the build, run:

``` shell
EMACSLOADPATH= result/bin/emacs
```

### REPL

```
$ nix repl repl.nix
nix-repl> :b outputs.packages.x86_64-linux.gitWithConfig
this derivation produced the following outputs:
  out -> /nix/store/1s5d89anqhq1f6a1bgyagvri4q82918j-gitWithConfig
```

## Flake Notes

Install the latest version of nix 2.4pre into user profile:

``` shell
nix profile install nixpkgs/nixpkgs-unstable#nixUnstable
```

To show build logs, use the `--print-build-logs|-L` flag. This flag does not
show up in `--help`.

``` shell
nix build --print-build-logs
```
