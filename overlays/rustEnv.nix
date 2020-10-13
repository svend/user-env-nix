final: prev:
{
  rustEnv = with final; prev.buildEnv {
    name = "rustEnv";
    paths = [
      # Tools required by rustc
      # gcc
      # gnumake
      # binutils-unwrapped

      # rustup

      # FTB on darwin: https://github.com/NixOS/nixpkgs/pull/100289
      # cargo-edit # cargo add/rm/upgrade (https://github.com/killercup/cargo-edit)

      # latest.rustChannels.stable.rust

      cargo
      rustc
      rustfmt
      rust-analyzer # collision with rust from nixpkgs-mozilla
    ];
  };
}
