self: super:
{
  # https://github.com/NixOS/nixpkgs/blob/master/pkgs/applications/editors/emacs
  emacsHead = (super.emacs.override {
    # Not building from source tarball
    srcRepo = true;
  }).overrideAttrs (oldAttrs:
    let
      # nix-prefetch-git git://git.sv.gnu.org/emacs.git
      # nix-prefetch-git --rev refs/heads/emacs-27 git://git.sv.gnu.org/emacs.git
      version = "master";
      url = git://git.sv.gnu.org/emacs.git;
      rev = "5b0d8d0f288fd505ca90bd30df709a5e7ab540d6";
      sha256 = "17i0rwy9qgykbm65bm5i6pizfx6ph7asdi2ddaxfs0sfcl5kcn79";
    in
    rec {
      name = "emacs-${version}${versionModifier}";
      versionModifier = "-git-${builtins.substring 0 7 rev}";

      # tramp-detect-wrapped-gvfsd.patch fails to apply
      patches = builtins.filter (p: baseNameOf p != "tramp-detect-wrapped-gvfsd.patch") oldAttrs.patches;

      src = super.fetchgit {
        inherit url rev sha256;
      };
    });

  # https://github.com/NixOS/nixpkgs/blob/76dbece8e8240a911fcc5722f813a8453f90406f/pkgs/build-support/emacs/wrapper.nix
  emacs = with self; let customEmacsPackages =
    emacsPackagesNg.overrideScope' (self: super: {
      # use a custom version of emacs
      # emacs = emacsHead;
    });
  in
  customEmacsPackages.emacsWithPackages (epkgs:
    (with epkgs.melpaStablePackages; [
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
      # notmuch # FTB: Invalid version syntax: `0.31.-1.1'
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
      notmuch # stable FTB: Invalid version syntax: `0.31.-1.1'
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
    ([ emacsPackagesNg.pdf-tools ])
  );
}
