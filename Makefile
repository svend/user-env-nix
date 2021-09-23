install:
	nix profile install github:svend/user-env-nix#userEnv

upgrade:
	@# $ nix flake update github:svend/user-env-nix --no-write-lock-file)
	@# error: unrecognised flag '--no-write-lock-file'
	nix flake update github:svend/user-env-nix
	nix profile upgrade --verbose '.*\.userEnv'

update-lockfile:
	nix flake update

build:
	nix build --print-build-logs
