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

      nixosFor = pkgImport nixos;
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
