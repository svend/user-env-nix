{
  description = "User environment";

  inputs = {
    nixos.url = "nixpkgs/release-20.03";
    nixpkgs-unstable.url = "nixpkgs/nixpkgs-unstable";
  };

  outputs = { self, nixos, nixpkgs-unstable }:
    let
      inherit (builtins) attrNames attrValues readDir;
      inherit (nixos) lib;

      utils = import ./lib/utils.nix { inherit lib; };

      systems = [
        "x86_64-darwin"
        "x86_64-linux"
      ];

      forAllSystems = f: lib.genAttrs systems (system: f system);

      pkgImport = pkgs: forAllSystems (system:
        import pkgs {
          inherit system;
          overlays = attrValues self.overlays;
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
        let
          overlayDir = ./overlays;
          fullPath = name: overlayDir + "/${name}";
          overlayPaths = map fullPath (attrNames (readDir overlayDir));
        in
        utils.pathsToImportedAttrs overlayPaths;

      defaultPackage = forAllSystems (system: nixpkgsFor."${system}".commonEnv);
    };
}
