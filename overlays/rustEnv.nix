self: super:
{
  rustEnv = with self; super.buildEnv {
    name = "rustEnv";
    paths = [
      # Tools required by rustc
      # gcc
      # gnumake
      # binutils-unwrapped

      # rustup

      cargo-edit # cargo add/rm/upgrade (https://github.com/killercup/cargo-edit)

      # latest.rustChannels.stable.rust

      # cargo
      # rustc
      # rustfmt
      rust-analyzer # collision with rust from nixpkgs-mozilla
    ];
  };
}
