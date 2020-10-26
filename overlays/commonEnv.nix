final: prev:
{
  gitConfig = prev.runCommand "gitConfig"
    {
      config = ../config/git;
    } ''
    mkdir -p "$out"
    cp -r "$config" "$out/git"
  '';

  myGit = with final; prev.runCommand "myGit"
    {
      nativeBuildInputs = [ prev.makeWrapper ];
      inherit git;
      config = gitConfig;
    } ''
    mkdir -p "$out/bin"
    bin=bin/git
    makeWrapper "$git/$bin" "$out/$bin" --set XDG_CONFIG_HOME "$config"
  '';

  myNotmuch = with final; prev.runCommand "myNotmuch"
    {
      nativeBuildInputs = [ prev.makeWrapper ];
      inherit notmuch;
      config = ../config/notmuch/notmuch-config;
    } ''
    mkdir -p "$out/bin"
    bin=bin/notmuch
    makeWrapper "$notmuch/$bin" "$out/$bin" --set-default NOTMUCH_CONFIG "$config"
  '';

  commonEnv = with final; prev.buildEnv {
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
      myEmacs
      etcdctl
      file
      findutils
      gawk
      gettext # for envsubst
      git-crypt
      gitAndTools.hub
      myGit
      gnugrep
      gnuplot
      gnused
      gnutar
      graphviz
      gzip
      htop
      imagemagick
      jsonnet
      keychain
      github-cli
      gnuplot
      ledger
      less
      mercurial
      mr
      multi-x509
      pandoc
      parallel
      pass
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
      unzip # required for Emacs nov.el package
      watch
      xsv
      xz
      zookeeper
      haskellPackages.ShellCheck

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

      # fonts
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
    ] ++ lib.optionals stdenv.isLinux [
      display-switch # FTB darwin: libaio-0.3.111
      gitAndTools.gitAnnex # slow to build, linux has pre-built binaries
      inetutils
      isync # mbsync
      librecad
      myNotmuch # FTB on darwin: gpg: can't connect to the agent: File name too long
    ];
  };
}
