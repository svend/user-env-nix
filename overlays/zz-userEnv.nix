self: super:
{
  userEnv = with self; super.buildEnv {
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
