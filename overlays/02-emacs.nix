final: prev:
rec {
  emacsConfig = prev.stdenv.mkDerivation
    {
      name = "emacs-config";
      buildInputs = [ prev.emacs ];
      src = ../emacs.org;

      unpackPhase = ''
        cp $src ./init.org
      '';

      buildPhase = ''
        emacs --batch --load ob-tangle --eval "(org-babel-tangle-file \"init.org\" \"init.el\" \"emacs-lisp\")"
      '';

      installPhase = ''
        mkdir -p $out/share/emacs/site-lisp
        cp init.el $out/share/emacs/site-lisp/default.el
      '';
    };

  myEmacs = prev.emacsWithPackages (epkgs:
    [ emacsConfig ] ++
    (with epkgs.melpaStablePackages;
    [
      ace-link
      ace-window
      aggressive-indent
      cider
      company
      company-jedi
      counsel
      diminish
      edit-indirect
      exec-path-from-shell
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
      ibuffer-tramp
      json-mode
      ledger-mode
      lua-mode
      nginx-mode
      nim-mode
      plantuml-mode
      terraform-mode
      yaml-mode
    ]) ++
    (with epkgs.melpaPackages; [
      amx
      blacken
      bpr
      company-go
      eglot
      epresent
      flycheck-rust
      flycheck-golangci-lint
      gnus-alias
      ivy # https://github.com/abo-abo/swiper/issues/2088
      kubernetes
      native-complete
      nix-mode
      ob-go
      ob-rust
      password-store
      ripgrep # https://github.com/nlamirault/ripgrep.el/compare/0.4.0...master
      ruby-tools
      visual-fill-column # https://github.com/joostkremers/visual-fill-column/compare/1.11...master

      # Themes
      modus-operandi-theme
      modus-vivendi-theme
      spacemacs-theme
      tango-plus-theme
      tao-theme

      # LSP
      company-lsp
      lsp-mode
      lsp-ui

      # Modes
      dhall-mode
      groovy-mode
      jsonnet-mode
      markdown-mode # something installs this from melpa non-stable
      rust-mode # https://github.com/rust-lang/rust-mode/compare/0.4.0...master
      toml-mode
    ]) ++
    (with epkgs.elpaPackages; [
      csv-mode
    ]) ++
    ([ prev.emacsPackagesNg.pdf-tools ])
  );
}
