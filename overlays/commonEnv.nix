self: super:
{
  iosevka-bin = super.iosevka-bin.override { variant = "sgr-iosevka"; };
  iosevka-aile-bin = super.iosevka-bin.override { variant = "sgr-iosevka-aile"; };

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
      cue
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
      sops
      stow
      time
      tokei # count lines of code
      tree
      unzip
      watch
      xsv
      xz # file compression
      zookeeper
      zshWithConfig
      haskellPackages.ShellCheck
      # Version control
      github-cli # gh command
      git-crypt
      gitWithConfig
      mercurial

      # Network tools
      # netcat # use nmap/ncat
      # netcat-gnu # use nmap/ncat
      curl
      bind
      fping
      grpcurl
      hurl # HTTP request testing tool
      ipcalc
      iperf
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
      iosevka-bin
      iosevka-aile-bin
      # input-fonts # non-free
      jetbrains-mono
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
      # mkdir -p ~/'Library/Application Support/Mozilla/NativeMessagingHosts'
      # ln -s ../../../../.nix-profile/lib/mozilla/native-messaging-hosts/passff.json ~/'Library/Application Support/Mozilla/NativeMessagingHosts/passff.json'
      passff-host # included with Firefox config on NixOS
    ];
  };
}
