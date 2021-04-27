{
  description = "User environment";

  inputs = {
    nixos.url = "nixpkgs/release-20.09";
    nixpkgs-unstable.url = "nixpkgs/nixpkgs-unstable";
    emacs-overlay.url = "github:nix-community/emacs-overlay";
    rust-overlay.url = "github:oxalica/rust-overlay";
  };

  outputs = { self, nixos, nixpkgs-unstable, emacs-overlay, rust-overlay }:
    let
      inherit (nixos) lib;

      systems = [
        "x86_64-darwin"
        "x86_64-linux"
      ];

      forAllSystems = f: lib.genAttrs systems (system: f system);

      pkgImport = pkgs: forAllSystems (system:
        import pkgs {
          inherit system;
          overlays = self.overlays;
          config = {
            allowUnfree = true;
            allowUnsupportedSystem = true;
          };
        }
      );

      nixpkgsFor = pkgImport nixpkgs-unstable;
    in
    {
      overlays =
        [ emacs-overlay.overlay rust-overlay.overlay ] ++
        # All overlays in the overlays directory
        map
          (name: import (./overlays + "/${name}"))
          (builtins.attrNames (builtins.readDir ./overlays));

      packages = forAllSystems (system: nixpkgsFor."${system}");

      defaultPackage = forAllSystems (system: nixpkgsFor."${system}".userEnv);
    };
}
