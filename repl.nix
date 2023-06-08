# nix repl --file repl.nix
# nix repl --extra-experimental-features repl-flake .#
# nix repl (followed by ":lf .")
# https://github.com/NixOS/nix/issues/3803
builtins.getFlake (toString ./.)
