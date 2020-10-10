{
  description = "User environment";

  inputs = {
    nixos.url = "nixpkgs/release-20.03";
    nixpkgs-unstable.url = "nixpkgs/nixpkgs-unstable";
    emacs-overlay.url = "github:nix-community/emacs-overlay";
  };

  outputs = { self, nixos, nixpkgs-unstable, emacs-overlay }:
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
        [ emacs-overlay.overlay ] ++
        # All overlays in the overlays directory
        map
          (name: import (./overlays + "/${name}"))
          (builtins.attrNames (builtins.readDir ./overlays));

      defaultPackage = forAllSystems (system: nixpkgsFor."${system}".userEnv);
    };
}
