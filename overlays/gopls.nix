# TODO: Difficult to override go modules
# Bug report: https://github.com/NixOS/nixpkgs/issues/86349
# Workaround: https://discourse.nixos.org/t/inconsistent-vendoring-in-buildgomodule-when-overriding-source/9225/3
final: prev: {
  # # TODO: Build with go 1.22
  # # https://github.com/NixOS/nixpkgs/pull/290212
  # # https://nixpk.gs/pr-tracker.html?pr=290212
  # # https://github.com/NixOS/nixpkgs/blob/nixos-unstable/pkgs/development/tools/language-servers/gopls/default.nix
  # gopls = with prev; buildGo122Module rec {
  #   pname = "gopls";
  #   version = "0.15.1";

  #   src = fetchFromGitHub {
  #     owner = "golang";
  #     repo = "tools";
  #     rev = "gopls/v${version}";
  #     hash = "sha256-GJ2zc5OgZXwEq12f0PyvgOOUd7cctUbFvdp095VQb9E=";
  #   };

  #   modRoot = "gopls";
  #   vendorHash = "sha256-Xxik0t1BHQPqzrE3Oh3VhODn+IqIVa+TCNqQSnmbBM0=";

  #   doCheck = false;

  #   # Only build gopls, and not the integration tests or documentation generator.
  #   subPackages = [ "." ];

  #   meta = with lib; {
  #     description = "Official language server for the Go language";
  #     homepage = "https://github.com/golang/tools/tree/master/gopls";
  #     changelog = "https://github.com/golang/tools/releases/tag/${src.rev}";
  #     license = licenses.bsd3;
  #     maintainers = with maintainers; [
  #       mic92
  #       rski
  #       SuperSandro2000
  #       zimbatm
  #     ];
  #     mainProgram = "gopls";
  #   };
  # };
}
