self: super:
{
  linuxEnv = with self; super.buildEnv {
    name = "linuxEnv";
    paths = [
      display-switch # FTB darwin: libaio-0.3.111
      gitAndTools.gitAnnex # slow to build, linux has pre-built binaries
      # TODO: is inetutils installed by default?
      # inetutils # telnet, ping, etc.
      isync
      librecad
      notmuchWithConfig # FTB on darwin: gpg: can't connect to the agent: File name too long
    ];
  };
}
