{ buildGoModule, fetchFromGitHub, lib }:

buildGoModule rec {
  pname = "d2";
  version = "0.1.1";

  src = fetchFromGitHub {
    owner = "terrastruct";
    repo = "d2";
    rev = "v${version}";
    sha256 = "sha256-3cglQEJo2rkIJ+ogqliE/JK4SfoeKwB2bNrHRBgDJSU=";
  };

  vendorSha256 = "sha256-MyvLHWg7GFSzYMtzgba7Bi7QEijDvK3B+NC84ZU/Jvs=";
  doCheck = false;

  meta = with lib; {
    description = " D2 is a modern diagram scripting language that turns text to diagrams.";
    homepage = "https://d2lang.com/";
    license = licenses.mpl20;
    maintainers = with maintainers; [ ];
    platforms = platforms.unix;
  };
}
