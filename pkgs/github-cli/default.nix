{ stdenv, go, buildGoModule, fetchgit }:

buildGoModule rec {
  pname = "github-cli";
  version = "v0.8.0";
  rev = "${version}";

  src = fetchgit {
    inherit rev;
    url = "https://github.com/cli/cli.git";
    sha256 = "08fy3677yq52x40rab49ijhw4r25ls2807dbv9wpna6w07n7r8v7";
  };

  vendorSha256 = "0s99bjmsafnzhl3s2lcybxgsw1s4i1h3vh6p40gz4vsfhndidqrq";
}
