final: prev: {
  myPkgs =
    with final;
    prev.buildEnv {
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

  userEnv =
    with final;
    prev.buildEnv {
      name = "userEnv";
      paths =
        [
          myPkgs
          emacsWithConfig
        ]
        ++ lib.optionals stdenv.isLinux [
          backupLaptopUnits
          mailSyncUnits
        ];
    };
}
