# TODO: Difficult to override go modules
# Bug report: https://github.com/NixOS/nixpkgs/issues/86349
# Workaround: https://discourse.nixos.org/t/inconsistent-vendoring-in-buildgomodule-when-overriding-source/9225/3
self: super: {
  cue = super.buildGoModule rec {
    # These are the attributes in cue/default.nix, except the ones that are
    # being overridden
    inherit (super.cue.drvAttrs) pname doCheck subPackages;
    inherit (super.cue) meta;
    version = "0.3.0-beta.5";

    src = super.fetchgit {
      url = "https://cue.googlesource.com/cue";
      rev = "v${version}";
      sha256 = "sha256-H3PCMM7oVsZx6pVveIEeZjv6KcevhSL9NOhh3j3mS0Q=";
    };

    vendorSha256 = "sha256-9ai1Wbk6ftcXHjVEWaL8drxZnhgAwF8+OXNI95CrNjc=";

    buildFlagsArray = [
      "-ldflags=-X cuelang.org/go/cmd/cue/cmd.version=${version}"
    ];
  };
}
