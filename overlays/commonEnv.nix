self: super:
{
  # iosevka-bin = super.iosevka-bin.override { variant = "sgr-iosevka"; };
  iosevka-aile-bin = super.iosevka-bin.override { variant = "aile"; };

  commonEnv = with self; super.buildEnv {
    name = "commonEnv";
    paths = [
      aspellWithDicts
      bashInteractive
      bash-completion
      # bats # bash shell testing framework TODO: 2022-12-21 FTB 
      # binutils # conflicts with rustEnv
      # cacert # nix default install includes nss-cacert-3.40.1
      coreutils
      cue
      cuelsp
      d2
      dhall
      dhall-json
      diffutils
      dtach
      # etcd # 2022-08-02 FTB: //go:linkname must refer to declared function or variable
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
      gnuplot
      ledger
      less
      mr
      multi-x509
      pandoc
      parallel
      postgresql
      pstree
      redis
      restic
      ripgrep
      rust-scripts
      sops
      steampipe
      stow
      time
      tokei # count lines of code
      tree
      unzip
      watch
      xsv # csv utility
      xz # file compression
      zookeeper
      zshWithConfig
      haskellPackages.ShellCheck

      # Version control
      github-cli # gh command
      git-crypt
      gitWithConfig
      mercurial

      # Password management
      age
      rage
      age-plugin-yubikey
      (self.passage.override { git = gitWithConfig; }) # requires homebrew gnu-getopt
      (self.pass.override { git = gitWithConfig; })
      pwgen
      yubikey-manager

      # Network tools
      # netcat # use nmap/ncat
      # netcat-gnu # use nmap/ncat
      curl
      # bind # 2022-08-04 FTB on darwin aarch64
      fping
      grpcurl
      hurl # HTTP request testing tool
      k6 # load testing tool
      ipcalc
      iperf
      nmap
      openssh
      openssl
      rsync
      step-cli
      vault
      wget
      whois
      # wrk2 # HTTP benchmarking tool # 2022-08-04  FTB on darwin aarch64

      # Terraform
      # terraform # Work version pinned
      # terraform-lsp # 2022-08-11 FTB
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
      # nix-prefetch-scripts # 2022-03-04 FTB: python3.9-httplib2> FAILED tests/test_other.py::test_connection_close - ConnectionResetError: [Er...
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
