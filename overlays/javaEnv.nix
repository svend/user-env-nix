self: super:
{
  javaEnv = with self; super.buildEnv {
    name = "javaEnv";
    paths = [
      maven
    ];
  };
}
