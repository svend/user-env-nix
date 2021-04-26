self: super:
{
  # Emacs native-comp on master soon:
  # https://lists.gnu.org/archive/html/emacs-devel/2021-04/msg00484.html

  emacsConfig = super.stdenv.mkDerivation
    {
      name = "emacs-config";
      buildInputs = [ self.emacsGcc ];
      src = ../config/emacs;

      unpackPhase = ''
        cp -r $src/* .
      '';

      buildPhase = ''
        emacs \
          --batch \
          --load ob-tangle \
          --eval "(org-babel-tangle-file \"init.org\" \"init.el\" \"emacs-lisp\")"
      '';

      installPhase = ''
        mkdir -p $out/share/emacs/site-lisp
        cp init.el $out/share/emacs/site-lisp/default.el
        cp -r themes $out/share/emacs/site-lisp/
      '';
    };

  emacsWithConfig = (super.pkgs.emacsPackagesGen self.emacsGcc).emacsWithPackages (epkgs:
    [
      self.emacsConfig
      self.unzip # required for Emacs nov.el package
      self.myPkgs
    ] ++
    (with epkgs.melpaStablePackages;
    [
      ace-link
      ace-window
      aggressive-indent
      cider
      company
      company-jedi
      counsel
      edit-indirect
      expand-region
      flycheck
      gnuplot
      magit
      notmuch
      nov
      package-lint
      py-isort
      smartparens
      super-save
      use-package
      yasnippet

      # Modes
      clojure-mode
      dockerfile-mode
      gitconfig-mode
      gitignore-mode
      go-mode
      haskell-mode
      json-mode
      ledger-mode
      lua-mode
      nginx-mode
      plantuml-mode
      terraform-mode
      yaml-mode
    ]) ++
    (with epkgs.melpaPackages; [
      amx
      blacken
      bpr
      company-go
      eglot # language server support
      epresent
      flycheck-rust
      flycheck-golangci-lint
      git-link
      gnus-alias
      minions # hide minor modes in mode-line
      native-complete
      ob-go
      ob-rust
      password-store
      pdf-tools
      projectile # 2.3.0..master fixes error with emacs master: Wrong number of arguments: (3 . 4)
      ripgrep # https://github.com/nlamirault/ripgrep.el/compare/0.4.0...master
      ruby-tools
      visual-fill-column # https://github.com/joostkremers/visual-fill-column/compare/1.11...master
      vterm

      # Themes
      nord-theme # bluish dark theme
      spacemacs-theme
      tango-plus-theme # simple light theme
      tao-theme # monochrome dark/light theme

      # Modes
      dhall-mode
      groovy-mode
      jsonnet-mode
      markdown-mode # something installs this from melpa non-stable
      nix-mode
      rust-mode # https://github.com/rust-lang/rust-mode/compare/0.4.0...master
      toml-mode
    ]) ++
    (with epkgs.elpaPackages; [
      csv-mode
      modus-themes # well designed dark/light theme
    ])
  );
}
