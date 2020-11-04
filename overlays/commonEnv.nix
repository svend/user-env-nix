self: super:
{
  gitConfig = super.runCommand "gitConfig"
    {
      config = ../config/git;
    } ''
    mkdir -p "$out"
    cp -r "$config" "$out/git"
  '';

  gitWithConfig = with self; super.buildEnv {
    name = "gitWithConfig";
    buildInputs = [ super.makeWrapper ];
    paths = [ self.git ];
    postBuild = ''
      unlink "$out/bin"
      mkdir -p "$out/bin"
      for path in "${git}"/bin/*; do
        bin=$(basename "$path")
        makeWrapper "$path" "$out/bin/$bin" --set XDG_CONFIG_HOME "${gitConfig}"
      done
    '';
  };

  isyncWithConfig = with self; super.runCommand "isyncWithConfig"
    {
      nativeBuildInputs = [ super.makeWrapper ];
      inherit isync;
      config = ../config/isync/mbsyncrc;
    } ''
    mkdir -p "$out/bin"
    bin=bin/mbsync
    makeWrapper "$isync/$bin" "$out/$bin"-with-config --add-flags "--config=$config"
  '';

  notmuchWithConfig =
    let
      config = ../config/notmuch/notmuch-config;
    in
    with self; super.buildEnv {
      name = "notmuchWithConfig";
      buildInputs = [ super.makeWrapper ];
      paths = [ notmuch ];
      postBuild = ''
        unlink "$out/bin"
        mkdir -p "$out/bin"
        for path in "${notmuch}"/bin/*; do
          bin=$(basename "$path")
          makeWrapper "$path" "$out/bin/$bin" --set-default NOTMUCH_CONFIG "${config}"
        done
      '';
    };

  zshWithConfig =
    let
      config = ../config/zsh;
    in
    with self; super.buildEnv {
      name = "zshWithConfig";
      buildInputs = [ super.makeWrapper ];
      paths = [ zsh ];
      postBuild = ''
        unlink "$out/bin"
        mkdir -p "$out/bin"
        for path in "${zsh}"/bin/*; do
          bin=$(basename "$path")
          makeWrapper "$path" "$out/bin/$bin" --set-default ZDOTDIR "${config}"
        done
      '';
    };

  commonEnv = with self; super.buildEnv {
    name = "commonEnv";
    paths = [
      aspellWithDicts
      bashInteractive
      bash-completion
      bats # bash shell testing framework
      # binutils # conflicts with rustEnv
      # cacert # nix default install includes nss-cacert-3.40.1
      coreutils
      dhall
      dhall-json
      dtach
      etcdctl
      file
      findutils
      gawk
      gettext # for envsubst
      gnugrep
      gnuplot
      gnused
      gnutar
      graphviz
      gzip
      htop
      imagemagick
      jsonnet
      jq
      keychain
      gnuplot
      ledger
      less
      mr
      multi-x509
      pandoc
      parallel
      (super.pass.override { git = gitWithConfig; })
      plantuml
      postgresql
      pwgen
      redis
      restic
      ripgrep
      rust-scripts
      scriptisto
      sops
      stow
      time
      tokei # count lines of code
      tree
      unzip
      watch
      xsv
      xz
      zookeeper
      zshWithConfig
      haskellPackages.ShellCheck

      # Version control
      github-cli
      git-crypt
      gitAndTools.hub
      gitWithConfig
      mercurial

      # Network tools
      # netcat # use nmap/ncat
      # netcat-gnu # use nmap/ncat
      curl
      bind
      fping
      grpcurl
      ipcalc
      nmap
      openssh
      openssl
      rsync
      wrk2 # HTTP benchmarking tool
      wget

      # Terraform
      # terraform # Work version pinned
      terraform-lsp
      tflint

      # Fonts
      dejavu_fonts
      fira
      fira-code
      iosevka
      # input-fonts # non-free
      jetbrains-mono
      go-font
      oxygenfonts
      source-code-pro

      # Nix
      nix-info # https://github.com/NixOS/nix/issues/3085
      nix-prefetch-scripts
      nixfmt
      nixpkgs-fmt
    ] ++ lib.optionals stdenv.isDarwin [
      gnupg # NixOS configuration includes gnupg
      passff-host # included with Firefox config on NixOS
      pinentry_mac
      terminal-notifier
    ];
  };
}
