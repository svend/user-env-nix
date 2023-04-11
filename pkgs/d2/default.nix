{ buildGoModule, fetchFromGitHub, lib }:

buildGoModule rec {
  pname = "d2";
  version = "0.1.0";

  src = fetchFromGitHub {
    owner = "terrastruct";
    repo = "d2";
    rev = "v${version}";
    sha256 = "sha256-QRgHmQOrw1ZdZffjVnqY3epNkVvCNtR06fyQgKVXoRk=";
  };

  vendorSha256 = "sha256-SO3ZeAJu4XOPDlJ2gUSYFPNG8RcOHfCsn2RKPT+FZy4=";
  doCheck = false;

  meta = with lib; {
    description = " D2 is a modern diagram scripting language that turns text to diagrams.";
    homepage = "https://d2lang.com/";
    license = licenses.mpl20;
    maintainers = with maintainers; [ ];
    platforms = platforms.unix;
  };
}
