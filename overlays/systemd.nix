self: super:
{
  systemdServices = super.runCommand "systemdServices"
    {
      inherit (self) gitWithConfig isync mbsyncConfig notmuch;
      gitAutoCommit = self.myScripts;
      notmuchConfig = ../config/notmuch/notmuch-config;
      config = ../config/systemd;
    }
    ''
      mkdir -p "$out/etc/xdg/systemd/user"
      for f in "$config"/*; do
         substituteAll "$f" "$out/etc/xdg/systemd/user/$(basename "$f")"
      done
    '';
}
