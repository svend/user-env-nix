final: prev: {
  javaEnv =
    with final;
    prev.buildEnv {
      name = "javaEnv";
      paths = [ maven ];
    };
}
