final: prev:
{
  userEnv = with final; prev.buildEnv {
    name = "userEnv";
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
    ];
  };
}
