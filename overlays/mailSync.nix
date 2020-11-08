self: super:
{
  mbsyncService = super.writeTextDir "etc/xdg/systemd/user/mbsync.service" ''
    [Unit]
    Description=mbsync service

    [Service]
    Type=oneshot
    Environment=NOTMUCH_CONFIG=${../config/notmuch/notmuch-config}
    ExecStart=${self.isync}/bin/mbsync --config @mbsyncConfig@/mbsyncrc --all --verbose
    ExecStartPost=${self.notmuch}/bin/notmuch new
  '';

  mbsyncTimer = super.writeTextDir "etc/xdg/systemd/user/mbsync.timer" ''
    [Unit]
    Description=Start mbsync

    [Timer]
    OnBootSec=5min
    OnUnitActiveSec=5min
    Unit=mbsync.service

    [Install]
    WantedBy=timers.target
  '';

  commitMailService = super.writeTextDir "etc/xdg/systemd/user/commitmail@.service" ''
    [Unit]
    Description=Commit state of %i mail
    After=mbsync.service

    [Service]
    Type=oneshot
    WorkingDirectory=%h/.mail/%i
    Environment=SSH_AUTH_SOCK=%t/gnupg/S.gpg-agent.ssh
    ExecStart=${self.myScripts}/bin/git-autocommit

    ExecStartPre=-${self.gitWithConfig}/bin/git pull
    ExecStartPost=-${self.gitWithConfig}/bin/git push

    [Install]
    WantedBy=mbsync.service
  '';

  mailSyncService = with self; super.buildEnv {
    name = "systemdServices";
    paths = [
      mbsyncTimer
      mbsyncService
      commitMailService
    ];
  };
}
