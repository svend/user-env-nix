{ buildGoModule, fetchFromGitHub, lib }:

buildGoModule rec {
  pname = "d2";
  version = "0.0.13";

  src = fetchFromGitHub {
    owner = "terrastruct";
    repo = "d2";
    rev = "v${version}";
    sha256 = "sha256-2abGQmgwqxWFk7NScdgfEjRYZF2rw8kxTKRwcl2LRg0=";
  };

  vendorSha256 = "sha256-/BEl4UqOL4Ux7I2eubNH2YGGl4DxntpI5WN9ggvYu80=";
  doCheck = false;

  meta = with lib; {
    description = " D2 is a modern diagram scripting language that turns text to diagrams.";
    homepage = "https://d2lang.com/";
    license = licenses.mpl20;
    maintainers = with maintainers; [ ];
    platforms = platforms.unix;
  };
}
