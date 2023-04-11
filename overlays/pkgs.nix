self: super:
{
  display-switch = super.callPackage ../pkgs/display-switch { };
  multi-x509 = super.callPackage ../pkgs/multi-x509 { };
  rust-script = super.callPackage ../pkgs/rust-script { };
  rust-scripts = super.callPackage ../pkgs/rust-scripts { };
}
