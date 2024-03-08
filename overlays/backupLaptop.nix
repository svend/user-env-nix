final: prev:
let
  systemdDir = "etc/xdg/systemd/user";
in
{
  backupLaptopService = prev.writeTextDir "${systemdDir}/backup-laptop.service" ''
    [Unit]
    Description=Laptop backup service

    [Service]
    Type=oneshot
    ExecStart=${final.myScripts}/bin/backup-laptop /run/media/svend/usb-samsung-1tb/restic-repo
  '';

  backupLaptopTimer = prev.writeTextDir "${systemdDir}/backup-laptop.timer" ''
    [Unit]
    Description=Start laptop backup

    [Timer]
    OnBootSec=30min
    OnUnitActiveSec=30min
    Unit=backup-laptop.service

    [Install]
    WantedBy=timers.target
  '';

  backupLaptopUnits =
    with final;
    prev.buildEnv {
      name = "systemdServices";
      paths = [
        backupLaptopTimer
        backupLaptopService
      ];
    };
}
