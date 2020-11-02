final: prev:
{
  display-switch = prev.callPackage ../pkgs/display-switch { };
  # gopls = prev.callPackage ../pkgs/gopls { };
  multi-x509 = prev.callPackage ../pkgs/multi-x509 { };
  # rust-analyzer = prev.callPackage ../pkgs/rust-analyzer { inherit (prev.darwin.apple_sdk.frameworks) CoreServices; };
  rust-script = prev.callPackage ../pkgs/rust-script { };
  rust-scripts = prev.callPackage ../pkgs/rust-scripts { };
  scriptisto = prev.callPackage ../pkgs/scriptisto { };
}
