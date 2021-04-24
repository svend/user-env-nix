self: super:
let
  systemdDir = "etc/xdg/systemd/user";
in
{
  mbsyncService =
    let
      mbsyncConfig = super.writeText "mbsyncrc" ''
        IMAPAccount fastmail
        Host imap.fastmail.com
        User svend@svends.net
        PassCmd "${self.pass}/bin/pass show general/imap.fastmail.com"
        SSLType IMAPS

        IMAPStore fastmail-remote
        Account fastmail

        MaildirStore fastmail-local
        Path ~/.mail/fastmail/ # must append a slash to specify an entire directory
        Inbox ~/.mail/fastmail/Inbox
        SubFolders Verbatim

        Channel fastmail
        Far :fastmail-remote:
        Near :fastmail-local:
        Patterns *
        # Sync Both
        Create Near
        Expunge Near
        SyncState *
      '';
    in
    super.writeTextDir "${systemdDir}/mbsync.service" ''
      [Unit]
      Description=mbsync service

      [Service]
      Type=oneshot
      Environment=NOTMUCH_CONFIG=${../config/notmuch/notmuch-config}
      ExecStart=${self.isync}/bin/mbsync --config ${mbsyncConfig} --all --verbose
      ExecStartPost=${self.notmuch}/bin/notmuch new
    '';

  mbsyncTimer = super.writeTextDir "${systemdDir}/mbsync.timer" ''
    [Unit]
    Description=Start mbsync

    [Timer]
    OnBootSec=5min
    OnUnitActiveSec=5min
    Unit=mbsync.service

    [Install]
    WantedBy=timers.target
  '';

  commitMailService = super.writeTextDir "${systemdDir}/commit-mail@.service" ''
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
