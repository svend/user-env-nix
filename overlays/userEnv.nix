self: super:
{
  myPkgs = with self; super.buildEnv {
    name = "myPkgs";
    paths = [
      myScripts
      # clojureEnv
      commonEnv
      goEnv
      javaEnv
      kubernetesEnv
      nodeEnv
      pythonEnv
      rubyEnv
      rustEnv
    ];
  };

  userEnv = with self; super.buildEnv {
    name = "userEnv";
    paths = [
      myPkgs
      emacsWithConfig
    ] ++ lib.optionals stdenv.isLinux [
      backupLaptopUnits
      mailSyncUnits
    ];
  };
}
