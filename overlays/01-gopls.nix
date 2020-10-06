self: super:
{
  # gopls = with super; gopls.overrideAttrs (old: rec {
  #   version = "0.4.3";

  #   src = fetchgit {
  #     rev = "gopls/v${version}";
  #     url = "https://go.googlesource.com/tools";
  #     sha256 = "1r670c7p63l0fhx671r3mb1jgvvfv1382079fv59z07j5j5hizbc";
  #   };

  #   # TODO: overriding vendorSha256 has no effect
  #   vendorSha256 = "1xdvkdkvk7a32jspzjcgxkfdn78d2zm53wxmc9c4sqysxsgy6lbw";
  # });
}
