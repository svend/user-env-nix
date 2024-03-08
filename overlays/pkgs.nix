final: prev: {
  multi-x509 = prev.callPackage ../pkgs/multi-x509 { };
  rust-script = prev.callPackage ../pkgs/rust-script { };
  rust-scripts = prev.callPackage ../pkgs/rust-scripts { };
}
