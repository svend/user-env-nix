self: super:
{
  github-cli = super.callPackage ../pkgs/github-cli { };
  # gopls = super.callPackage ../pkgs/gopls { };
  multi-x509 = super.callPackage ../pkgs/multi-x509 { inherit (super.darwin.apple_sdk.frameworks) Security; };
  rust-scripts = super.callPackage ../pkgs/rust-scripts { inherit (super.darwin.apple_sdk.frameworks) Security; };
  rust-analyzer = super.callPackage ../pkgs/rust-analyzer { inherit (super.darwin.apple_sdk.frameworks) CoreServices; };
  scriptisto = super.callPackage ../pkgs/scriptisto { inherit (super.darwin.apple_sdk.frameworks) Security; };
}
