self: super:
{
  nodeEnv = with self; super.buildEnv {
    name = "nodeEnv";
    paths = [
      nodejs-14_x
    ];
  };
}
