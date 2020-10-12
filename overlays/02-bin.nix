final: prev:
{
  myScripts = prev.stdenv.mkDerivation
    {
      name = "my-scripts";
      src = ../bin;

      unpackPhase = ''
        cp -r $src/* .
      '';

      buildPhase = "";

      installPhase = ''
        mkdir -p $out/bin
        cp * $out/bin
      '';
    };
}
