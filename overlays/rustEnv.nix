self: super:
{
  rustEnv = with self; super.buildEnv {
    name = "rustEnv";
    paths = [
      # Tools required by rustc
      # gcc
      # gnumake
      # binutils-unwrapped

      # From rust-overlay
      (rust-bin.stable.latest.default.override { extensions = [ "rust-src" ]; })

      cargo-edit # cargo add/rm/upgrade (https://github.com/killercup/cargo-edit)
      rust-analyzer
      rust-script
    ];
  };
}
