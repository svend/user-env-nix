self: super:
{
  linuxEnv = with self; super.buildEnv {
    name = "linuxEnv";
    paths = [
      display-switch # FTB darwin: libaio-0.3.111
      gitAndTools.git-annex # slow to build, linux has pre-built binaries
      # TODO: installing inetutils results in ping without root permissions
      # inetutils # (dnsdomainname ftp hostname ifconfig logger ping ping6 rcp rexec rlogin rsh talk telnet tftp traceroute whois)
      isync
      gthumb
      librecad
      notmuchWithConfig # FTB on darwin: gpg: can't connect to the agent: File name too long
    ];
  };
}
