install:
	nix profile install github:svend/user-env-nix#userEnv

upgrade:
	nix profile upgrade --refresh --verbose '.*\.userEnv'

update-lockfile:
	nix flake update

build:
	nix build --print-build-logs
