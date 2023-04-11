install:
	nix profile install github:svend/user-env-nix#userEnv

upgrade:
	nix flake lock github:svend/user-env-nix
	nix profile upgrade --verbose '.*\.userEnv'

update-lockfile:
	nix flake update

build:
	nix build --print-build-logs
