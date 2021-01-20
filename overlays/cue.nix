# TODO: Difficult to override go modules
# Bug report: https://github.com/NixOS/nixpkgs/issues/86349
# Workaround: https://discourse.nixos.org/t/inconsistent-vendoring-in-buildgomodule-when-overriding-source/9225/3
self: super: {
  cue = super.buildGoModule rec {
    # These are the attributes in cue/default.nix, except the ones that are
    # being overridden
    inherit (super.cue.drvAttrs) pname doCheck subPackages;
    inherit (super.cue) meta;
    # FIXME: cuelang/cue:0.3.0-beta.2: https://github.com/cuelang/cue/issues/650
    version = "0.3.0-beta.1";

    src = super.fetchgit {
      url = "https://cue.googlesource.com/cue";
      rev = "v${version}";
      sha256 = "sha256-dAgX+VBt88bHFCJCqNx++eECG4HRmootjcR+anGLGQk=";
    };

    vendorSha256 = "sha256-t03E/KGhwruyF39NJSeHhum3JprTUErMoOe3ixuvuXU=";

    buildFlagsArray = [
      "-ldflags=-X cuelang.org/go/cmd/cue/cmd.version=${version}"
    ];
  };
}
