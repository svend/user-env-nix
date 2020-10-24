final: prev:
{
  myScripts = prev.stdenv.runCommand "myScripts"
    {
      scripts = ../config/scripts;
    } ''
    mkdir -p $out/bin
    cp "$scripts"/* $out/bin
  '';
}
