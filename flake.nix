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
      inherit (lib) removeSuffix recursiveUpdate genAttrs filterAttrs;
      inherit (utils) pathsToImportedAttrs;

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
    in with pkgset; {
      # overlay = import ./pkgs;

      overlays =
        let
          overlayDir = ./overlays;
          fullPath = name: overlayDir + "/${name}";
          overlayPaths = map fullPath (attrNames (readDir overlayDir));
        in
        pathsToImportedAttrs overlayPaths;


      packages."${system}" =
        let
          packages = osPkgs;
          overlays = lib.filterAttrs (n: v: n != "pkgs") self.overlays;
          overlayPkgs =
            genAttrs
              (attrNames overlays)
              (name: (overlays."${name}" osPkgs osPkgs)."${name}");
        in
        recursiveUpdate packages overlayPkgs;

      # defaultPackage.${system} = self.packages.${system}.multi-x509;

      # packages.${system}.hello = nixos.legacyPackages.${system}.hello;
      defaultPackage.${system} = self.packages.${system}.userEnv;
    };
}
