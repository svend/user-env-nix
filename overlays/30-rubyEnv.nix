self: super:
{
  rubyEnv = with self; super.buildEnv {
    name = "rubyEnv";
    paths = [
      ruby
    ];
  };
}
