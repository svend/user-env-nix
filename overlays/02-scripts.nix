self: super:
{
  myScripts = super.runCommand "myScripts"
    {
      scripts = ../config/scripts;
    } ''
    mkdir -p $out/bin
    cp "$scripts"/* $out/bin
  '';
}
