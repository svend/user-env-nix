self: super:
{
  d2 = super.callPackage ../pkgs/d2 { };
  display-switch = super.callPackage ../pkgs/display-switch { };
  multi-x509 = super.callPackage ../pkgs/multi-x509 { };
  rust-script = super.callPackage ../pkgs/rust-script { };
  rust-scripts = super.callPackage ../pkgs/rust-scripts { };
}
