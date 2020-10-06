final: prev:
{
  userEnv = with final; prev.buildEnv {
    name = "userEnv";
    paths = [
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
