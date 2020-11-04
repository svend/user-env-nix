final: prev:
{
  systemdServices = with final; prev.runCommand "systemdServices"
    {
      config = ../config/systemd;
    }
    ''
      mkdir -p "$out/etc/xdg/systemd/user"
      cp "$config"/* "$out/etc/xdg/systemd/user"
    '';
}
