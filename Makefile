build:
	nix build --print-build-logs

install:
	nix profile install github:svend/user-env-nix#userEnv

install-local:
	nix profile install .#userEnv

upgrade:
	nix profile upgrade --refresh --verbose '.*\.userEnv'

update-lockfile:
	nix flake update

emacs:
	EMACSLOADPATH= result/bin/emacs &
