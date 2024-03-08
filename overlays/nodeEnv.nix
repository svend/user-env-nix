final: prev: {
  nodeEnv =
    with final;
    prev.buildEnv {
      name = "nodeEnv";
      paths = [ nodejs ];
    };
}
