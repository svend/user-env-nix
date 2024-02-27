self: super: {
  kubernetesEnv =
    with self;
    super.buildEnv {
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
