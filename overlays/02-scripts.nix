final: prev:
{
  myScripts = prev.runCommand "myScripts"
    {
      scripts = ../config/scripts;
    } ''
    mkdir -p $out/bin
    cp "$scripts"/* $out/bin
  '';
}
