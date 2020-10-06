{
  description = "User environment";

  inputs = {
    master.url = "nixpkgs/master";
    nixos.url = "nixpkgs/release-20.03";
  };

  outputs = { self, nixos, master }:
    let
      inherit (builtins) attrNames attrValues readDir;
      inherit (nixos) lib;
      inherit (utils) pathsToImportedAttrs;

      forAllSystems = lib.genAttrs [
        "x86_64-linux"
        "x86_64-darwin"
      ];

      utils = import ./lib/utils.nix { inherit lib; };

      pkgImport = pkgs:
        import pkgs {
          inherit system;
          overlays = attrValues self.overlays;
          config = { allowUnfree = true; };
        };

      pkgset = {
        osPkgs = pkgImport nixos;
        pkgs = pkgImport master;
      };

      system = "x86_64-linux";
    in
    with pkgset; {
      # overlay = import ./pkgs;

      overlays =
        let
          overlayDir = ./overlays;
          fullPath = name: overlayDir + "/${name}";
          overlayPaths = map fullPath (attrNames (readDir overlayDir));
        in
        pathsToImportedAttrs overlayPaths;

      packages = forAllSystems (system:
        let
          packages = pkgs;
          overlays = lib.filterAttrs (n: v: n != "pkgs") self.overlays;
          overlayPkgs =
            lib.genAttrs
              (attrNames overlays)
              (name: (overlays."${name}" osPkgs osPkgs)."${name}");
        in
        lib.recursiveUpdate packages overlayPkgs
      );

      defaultPackage = forAllSystems (system: self.packages."${system}".userEnv);
    };
}
