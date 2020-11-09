# nix repl repl.nix
#
# https://github.com/NixOS/nix/issues/3803
builtins.getFlake (toString ./.)
