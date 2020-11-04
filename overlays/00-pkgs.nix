self: super:
{
  display-switch = super.callPackage ../pkgs/display-switch { };
  # gopls = super.callPackage ../pkgs/gopls { };
  multi-x509 = super.callPackage ../pkgs/multi-x509 { };
  # rust-analyzer = super.callPackage ../pkgs/rust-analyzer { inherit (prev.darwin.apple_sdk.frameworks) CoreServices; };
  rust-script = super.callPackage ../pkgs/rust-script { };
  rust-scripts = super.callPackage ../pkgs/rust-scripts { };
  scriptisto = super.callPackage ../pkgs/scriptisto { };
}
