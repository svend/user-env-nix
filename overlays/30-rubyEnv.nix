final: prev:
{
  rubyEnv = with final; prev.buildEnv {
    name = "rubyEnv";
    paths = [
      ruby
    ];
  };
}
