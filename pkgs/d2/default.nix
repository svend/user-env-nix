{ buildGoModule, fetchFromGitHub, lib }:

buildGoModule rec {
  pname = "d2";
  version = "0.1.4";

  src = fetchFromGitHub {
    owner = "terrastruct";
    repo = "d2";
    rev = "v${version}";
    sha256 = "sha256-whxXMU9jQ/ixXUx6vqs1CdLWZGHTBFJcA6v1Z4aAV4s=";
  };

  vendorSha256 = "sha256-t94xCNteYRpbV2GzrD4ppD8xfUV1HTJPkipEzr36CaM=";
  doCheck = false;

  meta = with lib; {
    description = " D2 is a modern diagram scripting language that turns text to diagrams.";
    homepage = "https://d2lang.com/";
    license = licenses.mpl20;
    maintainers = with maintainers; [ ];
    platforms = platforms.unix;
  };
}
