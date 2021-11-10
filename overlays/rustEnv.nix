self: super:
{
  rustEnv = with self; super.buildEnv {
    name = "rustEnv";
    paths = [
      # From rust-overlay
      (rust-bin.stable.latest.default.override { extensions = [ "rust-src" ]; })

      cargo-edit # cargo add/rm/upgrade (https://github.com/killercup/cargo-edit)
      rust-analyzer
      # rust-script
    ] ++ lib.optionals stdenv.isLinux [
      # Tools required by rust-overlay on Linux
      gcc # for `cc`
      # TODO: Are these required?
      # gnumake
      # binutils-unwrapped
    ];
  };
}
