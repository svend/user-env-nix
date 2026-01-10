final: prev:
let
  systemdDir = "etc/xdg/systemd/user";
in
{
  mbsyncService =
    let
      mbsyncConfig = prev.writeText "mbsyncrc" ''
        IMAPAccount fastmail
        Host imap.fastmail.com
        User svend@svends.net
        PassCmd "cat ~/.secrets/fastmail-imap-token"
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
        Patterns * !Spam
        # Sync Both
        Create Near
        Expunge Near
        SyncState *
      '';
    in
    prev.writeTextDir "${systemdDir}/mbsync.service" ''
      [Unit]
      Description=mbsync service

      [Service]
      Type=oneshot
      Environment=NOTMUCH_CONFIG=${../config/notmuch/notmuch-config}
      ExecStart=${final.isync}/bin/mbsync --config ${mbsyncConfig} --all --verbose
      ExecStartPost=${final.notmuch}/bin/notmuch new
    '';

  mbsyncTimer = prev.writeTextDir "${systemdDir}/mbsync.timer" ''
    [Unit]
    Description=Start mbsync

    [Timer]
    OnBootSec=5min
    OnUnitActiveSec=5min
    Unit=mbsync.service

    [Install]
    WantedBy=timers.target
  '';

  commitMailService = prev.writeTextDir "${systemdDir}/commit-mail@.service" ''
    [Unit]
    Description=Commit state of %i mail
    After=mbsync.service

    [Service]
    Type=oneshot
    WorkingDirectory=%h/.mail/%i
    Environment=SSH_AUTH_SOCK=%t/gnupg/S.gpg-agent.ssh
    ExecStart=${final.myScripts}/bin/git-autocommit

    ExecStartPre=-${final.gitWithConfig}/bin/git pull
    ExecStartPost=-${final.gitWithConfig}/bin/git push

    [Install]
    WantedBy=mbsync.service
  '';

  mailSyncUnits =
    with final;
    prev.buildEnv {
      name = "systemdServices";
      paths = [
        mbsyncTimer
        mbsyncService
        commitMailService
      ];
    };
}
