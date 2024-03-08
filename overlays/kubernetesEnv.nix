final: prev: {
  kubernetesEnv =
    with final;
    prev.buildEnv {
      name = "kubernetesEnv";
      paths = [
        kind
        krew # kubectl plugin manager
        kubectl
        kubernetes-helm
        kustomize
        stern # follow logs
      ];
    };
}
