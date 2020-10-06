final: prev:
{
  clojureEnv = with final; prev.buildEnv {
    name = "clojureEnv";
    paths = [
      clojure
      leiningen
    ];
  };
}
