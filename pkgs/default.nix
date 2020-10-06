final: prev:
{
  multi-x509 = prev.callPackage ../pkgs/multi-x509 { inherit (prev.darwin.apple_sdk.frameworks) Security; };
}
