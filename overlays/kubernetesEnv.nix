self: super:
{
  kubernetesEnv = with self; super.buildEnv {
    name = "kubernetesEnv";
    paths = [
      kind
      kubectl
      kubernetes-helm
      kustomize
    ];
  };
}
