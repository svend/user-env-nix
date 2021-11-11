# Nix User Environment Flake

> Reproducible development environment powered by Nix Flakes

## Initial Setup

Use nix version 2.4 or newer.

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
nix profile install github:svend/user-env-nix#userEnv
```

To update:

``` shell
nix flake update github:svend/user-env-nix; nix profile upgrade --verbose '.*\.userEnv'
```

### Systemd

On NixOS, refresh user systemd unit files.

``` shell
systemctl --user daemon-reload
```

NixOS adds `~/.nix-profile/etc/xdg/systemd/user` to the user unit search path.

``` shell
systemd-path | grep systemd-user-unit
```

(`systemd-path` prints two values for `systemd-user-unit`, and `systemd-path
systemd-user-unit` prints the one with only a single directory. I'm not sure
why.)

To start from scratch:

``` shell
rm -rf ~/.config/systemd/user
systemctl --user enable mbsync.timer
systemctl --user add-wants mbsync.service commit-mail@fastmail.service
systemctl --user add-wants mbsync.service commit-mail@gmail.service
systemctl --user daemon-reload
systemctl --user --failed
```

## Updating

Update lock file.

``` shell
nix flake update
```

Update a single input:

``` shell
nix flake lock --update-input nixpkgs-unstable
```

## Development

Running `nix build` will create `result/` which is a link to the build.

To print build logs, run `nix build --print-build-logs` or `nix build -L`.
(These flags do not show up in `--help`.)

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
