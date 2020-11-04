self: super:
{
  clojureEnv = with self; super.buildEnv {
    name = "clojureEnv";
    paths = [
      clojure
      leiningen
    ];
  };
}
