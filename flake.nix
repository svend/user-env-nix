{
  description = "User environment";

  inputs = {
    nixpkgs-unstable.url = "nixpkgs/nixpkgs-unstable";
    nixos.url = "nixpkgs/release-20.03";
  };

  outputs = { self, nixos, nixpkgs-unstable }:
    let
      inherit (builtins) attrNames attrValues readDir;
      inherit (nixos) lib;
      inherit (utils) pathsToImportedAttrs;

      systems = [
        "x86_64-darwin"
        "x86_64-linux"
      ];
      forAllSystems = f: lib.genAttrs systems (system: f system);

      utils = import ./lib/utils.nix { inherit lib; };

      # pkgImport = pkgs:
      #   import pkgs {
      #     inherit system;
      #     overlays = attrValues self.overlays;
      #     config = { allowUnfree = true; };
      #   };

      nixosFor = forAllSystems (
        system:
        import nixos {
          inherit system;
          config = {
            allowUnfree = true;
            allowUnsupportedSystem = true;
          };
          overlays = attrValues self.overlays;
        }
      );

      nixpkgsFor = forAllSystems (
        system:
        import nixpkgs-unstable {
          inherit system;
          config = {
            allowUnfree = true;
            allowUnsupportedSystem = true;
          };
          overlays = attrValues self.overlays;
        }
      );

      system = "x86_64-linux";
    in
    {
      overlays =
        let
          overlayDir = ./overlays;
          fullPath = name: overlayDir + "/${name}";
          overlayPaths = map fullPath (attrNames (readDir overlayDir));
        in
        pathsToImportedAttrs overlayPaths;

      packages = forAllSystems (system:
        let
          packages = nixpkgsFor.${system};
          overlays = lib.filterAttrs (n: v: n != "pkgs") self.overlays;
          overlayPkgs =
            lib.genAttrs
              (attrNames overlays)
              (name: (overlays."${name}" nixosFor nixosFor)."${name}");
        in
        lib.recursiveUpdate packages overlayPkgs
      );

      defaultPackage = forAllSystems (system: self.packages."${system}".userEnv);
    };
}
