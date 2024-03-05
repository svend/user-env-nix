self: super: {
  emacsConfig = super.stdenv.mkDerivation {
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
        --eval "(org-babel-tangle-file \"emacs-init.org\" \"init.el\" \"emacs-lisp\")"
    '';

    installPhase = ''
      mkdir -p $out/share/emacs/site-lisp
      cp init.el $out/share/emacs/site-lisp/default.el
      cp -r themes $out/share/emacs/site-lisp/
    '';
  };

  emacsWithConfig = (super.pkgs.emacsPackagesFor self.emacs29).emacsWithPackages (
    epkgs:
    [
      self.emacsConfig
      self.unzip # required for Emacs nov.el package
      self.myPkgs
      epkgs.treesit-grammars.with-all-grammars
    ]
    ++ (with epkgs.melpaStablePackages; [
      ace-link
      ace-window
      aggressive-indent
      cider # clojure development environment
      company
      edit-indirect # required by markdown-mode to edit blocks
      elfeed # RSS feed reader
      expand-region
      flycheck
      gnuplot
      magit
      notmuch
      nov # epub reader
      package-lint
      py-isort
      super-save
      use-package
      yasnippet

      # Modes
      clojure-mode
      cue-mode
      dockerfile-mode
      git-modes
      go-mode
      haskell-mode
      json-mode
      ledger-mode
      lua-mode
      nginx-mode
      terraform-mode
      yaml-mode
    ])
    ++ (with epkgs.melpaPackages; [
      blacken # support for python "black" code-formatter
      company-go
      detached
      epresent
      flycheck-rust
      flycheck-golangci-lint
      git-link
      gnus-alias
      minions # hide minor modes in mode-line
      native-complete # shell (bash/zsh) completion
      ob-go
      ob-rust
      orderless # completion style for regex in any order
      pass
      password-store
      pdf-tools
      ripgrep # https://github.com/nlamirault/ripgrep.el/compare/0.4.0...master
      smartparens # https://github.com/Fuco1/smartparens/compare/1.11.0...master
      swiper # isearch with an overview
      visual-fill-column # https://github.com/joostkremers/visual-fill-column/compare/1.11...master
      vterm

      # Themes
      nord-theme # bluish dark theme
      spacemacs-theme # purplish light/dark theme
      tango-plus-theme # simple light theme
      tao-theme # monochrome dark/light theme

      # Modes
      groovy-mode
      jsonnet-mode
      markdown-mode # something installs this from melpa non-stable
      nix-mode
      rust-mode # https://github.com/rust-lang/rust-mode/compare/0.4.0...master
      toml-mode
    ])
    ++ (with epkgs.elpaPackages; [
      csv-mode
      eglot # language server support
      modus-themes # well-designed dark/light theme
      project # required by eglot
    ])
  );
}
