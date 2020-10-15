final: prev:
{
  display-switch = prev.callPackage ../pkgs/display-switch { };
  github-cli = prev.callPackage ../pkgs/github-cli { };
  # gopls = prev.callPackage ../pkgs/gopls { };
  multi-x509 = prev.callPackage ../pkgs/multi-x509 { inherit (prev.darwin.apple_sdk.frameworks) Security; };
  rust-scripts = prev.callPackage ../pkgs/rust-scripts { inherit (prev.darwin.apple_sdk.frameworks) Security; };
  rust-analyzer = prev.callPackage ../pkgs/rust-analyzer { inherit (prev.darwin.apple_sdk.frameworks) CoreServices; };
  scriptisto = prev.callPackage ../pkgs/scriptisto { inherit (prev.darwin.apple_sdk.frameworks) Security; };
}
