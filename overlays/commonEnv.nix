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
      (self.pass.override { git = gitWithConfig; })
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
      pinentry_mac
      terminal-notifier

      # On macOS, link passff.json:
      # ln -s ../../../../.nix-profile/lib/mozilla/native-messaging-hosts/passff.json ~/'Library/Application Support/Mozilla/NativeMessagingHosts/passff.json'
      passff-host # included with Firefox config on NixOS
    ];
  };
}
