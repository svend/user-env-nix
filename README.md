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
      experimental-features = nix-command flakes
    '';
  };
}
```

For non-NixOS systems:

``` shell
mkdir -p ~/.config/nix
echo 'experimental-features = nix-command flakes' > ~/.config/nix/nix.conf
```

## Installation

Install flake into profile:

``` shell
nix profile install github:svend/user-env-nix#userEnv
```

Update to the latest version of the flake.

``` shell
nix profile upgrade --refresh --verbose '.*\.userEnv'
```

### Systemd

On NixOS, refresh user systemd unit files.

``` shell
systemctl --user daemon-reload
```

NixOS adds `~/.nix-profile/etc/xdg/systemd/user` to the user unit search path.

``` shell
systemd-path systemd-search-user-unit | tr : '\n'
```

Check for failed units.

``` shell
systemctl --user --failed
```

Check for broken unit files.

```shell
find ~/.config/systemd/user -xtype l
```

To start from scratch:

``` shell
# rm -rf ~/.config/systemd/user
systemctl --user enable --force --now backup-laptop.timer
systemctl --user enable --force --now mbsync.timer
systemctl --user add-wants --force mbsync.service commit-mail@fastmail.service
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
nix flake metadata
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

https://github.com/NixOS/nix/issues/8059

``` shell
nix repl --file repl.nix
nix repl --extra-experimental-features repl-flake .#
nix repl (followed by ":lf .")
```

```
$ nix repl --file repl.nix
nix-repl> :b outputs.packages.x86_64-linux.gitWithConfig
this derivation produced the following outputs:
  out -> /nix/store/1s5d89anqhq1f6a1bgyagvri4q82918j-gitWithConfig
```
