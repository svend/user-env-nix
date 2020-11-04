self: super:
{
  pass = with super; pass.overrideAttrs (old: {
    # Remove emacs package, installed via melpa
    postInstall = old.postInstall + ''
      rm -r "$out/share/emacs/site-lisp"
    '';
  });
}
