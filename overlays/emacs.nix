self: super:
{
  # Emacs native-comp on master soon:
  # https://lists.gnu.org/archive/html/emacs-devel/2021-04/msg00484.html
  # emacs = super.emacs.override { nativeComp = true; };

  emacsConfig = super.stdenv.mkDerivation
    {
      name = "emacs-config";
      buildInputs = [ self.emacs ];
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

  emacsWithConfig = super.emacsWithPackages (epkgs:
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
      hydra
      magit
      notmuch
      nov
      package-lint
      projectile
      py-isort
      robe
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
      minions
      native-complete
      ob-go
      ob-rust
      password-store
      pdf-tools
      ripgrep # https://github.com/nlamirault/ripgrep.el/compare/0.4.0...master
      ruby-tools
      visual-fill-column # https://github.com/joostkremers/visual-fill-column/compare/1.11...master
      vterm

      # Themes
      nord-theme
      spacemacs-theme
      tango-plus-theme
      tao-theme

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
      modus-themes
    ])
  );
}
