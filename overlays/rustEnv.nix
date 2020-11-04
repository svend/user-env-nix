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

      # latest.rustChannels.stable.rust

      cargo
      rustc

      cargo-edit # cargo add/rm/upgrade (https://github.com/killercup/cargo-edit)
      rust-analyzer # collision with rust from nixpkgs-mozilla
      rust-script
      rustfmt
    ];
  };
}
