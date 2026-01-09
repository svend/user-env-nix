build:
	nix build --print-build-logs

add:
	nix profile add github:svend/user-env-nix#userEnv

add-local:
	nix profile add .#userEnv

upgrade:
	nix profile upgrade --refresh userEnv

update-lockfile:
	nix flake update

repl:
	nix repl .

emacs:
	env -i result/bin/emacs &

format:
	find -name '*.nix' | xargs nixfmt --verify
