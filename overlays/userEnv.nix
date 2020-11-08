self: super:
{
  myPkgs = with self; super.buildEnv {
    name = "myPkgs";
    paths = [
      myScripts
      clojureEnv
      commonEnv
      goEnv
      javaEnv
      nodeEnv
      pythonEnv
      rubyEnv
      rustEnv
    ] ++ lib.optionals stdenv.isLinux [
      linuxEnv
    ];
  };

  userEnv = with self; super.buildEnv {
    name = "userEnv";
    paths = [
      myPkgs
      emacsWithConfig
    ] ++ lib.optionals stdenv.isLinux [
      mailSyncService
    ];
  };
}
