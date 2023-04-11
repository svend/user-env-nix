{ buildGoModule, fetchFromGitHub, lib }:

buildGoModule rec {
  pname = "d2";
  version = "0.1.2";

  src = fetchFromGitHub {
    owner = "terrastruct";
    repo = "d2";
    rev = "v${version}";
    sha256 = "sha256-O3T26Stau168hP7Hhv2bayamXQvaFD6feyW5AYoHf0U=";
  };

  vendorSha256 = "sha256-k9zaZ28vs3R5usWUW5N78zz0PuP5UrYEhgXxpQ+v5sE=";
  doCheck = false;

  meta = with lib; {
    description = " D2 is a modern diagram scripting language that turns text to diagrams.";
    homepage = "https://d2lang.com/";
    license = licenses.mpl20;
    maintainers = with maintainers; [ ];
    platforms = platforms.unix;
  };
}
