self: super:
{
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
      emacs
      etcdctl
      file
      findutils
      gawk
      gettext # for envsubst
      git-crypt
      gitAndTools.hub
      gitMinimal
      gnugrep
      gnuplot
      gnused
      gnutar
      graphviz
      gzip
      htop
      imagemagick
      jq
      jsonnet
      keychain
      github-cli
      gnuplot
      ledger
      less
      mercurial
      mr
      multi-x509
      # notmuch # FTB on darwin: gpg: can't connect to the agent: File name too long
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
      nix-prefetch-scripts
      nixfmt
      nixpkgs-fmt
    ] ++ lib.optionals stdenv.isDarwin [
      gnupg # NixOS configuration includes gnupg
      passff-host # included with Firefox config on NixOS
      pinentry_mac
      terminal-notifier
    ] ++ lib.optionals stdenv.isLinux [
      gitAndTools.gitAnnex # slow to build, linux has pre-built binaries
      inetutils
      isync # mbsync
      # librecad # TODO: https://github.com/NixOS/nixpkgs/pull/96248
      notmuch # FTB on darwin: gpg: can't connect to the agent: File name too long
    ];
  };
}
