{
  description = "User environment";

  inputs = {
    nixos.url = "nixpkgs/release-24.11";
    nixpkgs-unstable.url = "nixpkgs/nixpkgs-unstable";
    emacs-overlay.url = "github:nix-community/emacs-overlay";
    rust-overlay.url = "github:oxalica/rust-overlay";
  };

  outputs =
    {
      self,
      nixos,
      nixpkgs-unstable,
      emacs-overlay,
      rust-overlay,
    }:
    let
      inherit (nixos) lib;

      systems = [
        "x86_64-linux"
        "aarch64-darwin"
        "x86_64-darwin"
      ];

      forAllSystems = f: lib.genAttrs systems (system: f system);

      overlays =
        [
          emacs-overlay.overlay
          rust-overlay.overlays.default
        ]
        ++
        # All overlays in the overlays directory
        map (name: import (./overlays + "/${name}")) (builtins.attrNames (builtins.readDir ./overlays));

      pkgImport =
        pkgs:
        forAllSystems (
          system:
          import pkgs {
            inherit system;
            inherit overlays;
            config = {
              allowUnfree = true;
              allowUnsupportedSystem = true;
            };
          }
        );

      nixosFor = pkgImport nixos;
      nixpkgsFor = pkgImport nixpkgs-unstable;
    in
    {
      packages = forAllSystems (system: nixpkgsFor."${system}");

      defaultPackage = forAllSystems (system: nixpkgsFor."${system}".userEnv);

      formatter = forAllSystems (system: nixosFor."${system}".nixfmt-rfc-style);
    };
}
