final: prev:
{
  kubernetesEnv = with final; prev.buildEnv {
    name = "kubernetesEnv";
    paths = [
      helm
      kind
      kubectl
      kustomize
    ];
  };
}
