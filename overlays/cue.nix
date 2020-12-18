# TODO: Difficult to override go modules
# Bug report: https://github.com/NixOS/nixpkgs/issues/86349
# Workaround: https://discourse.nixos.org/t/inconsistent-vendoring-in-buildgomodule-when-overriding-source/9225/3
self: super:
{
  # cue = super.cue.overrideAttrs (old: rec {
  #   version = "0.3.0-alpha6";

  #   src = fetchgit {
  #     url = "https://cue.googlesource.com/cue";
  #     rev = "v${version}";
  #     sha256 = "sha256-GhwfuC8Hb/LzPOvwB+VNcQxkB9hz0xxKJXWqKyJmIfg=";
  #   };

  #   vendorSha256 = "sha256-t03E/KGhwruyF39NJSeHhum3JprTUErMoOe3ixuvuXU=";
  # });
}
