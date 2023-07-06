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
      bats # bash shell testing framework
      # binutils # conflicts with rustEnv
      # cacert # nix default install includes nss-cacert-3.40.1
      coreutils
      cue
      cuelsp
      d2
      dhall
      dhall-json
      diffutils
      dig
      dtach
      etcd
      file
      findutils
      gawk
      gettext # for envsubst
      gnugrep
      gnumake
      gnuplot
      gnused
      gnutar
      graphviz
      gzip
      htop
      imagemagick
      # jsonnet # 2023-06-22 TODO: FTB on Darwin
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
      # restic # 2023-07-06 TODO: FTB (rclone) https://github.com/NixOS/nixpkgs/issues/241706
      ripgrep
      rust-scripts
      sops
      sqlfluff # format SQL
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
      (self.passage.override { age = age; git = gitWithConfig; }) # requires homebrew gnu-getopt
      (self.pass.override { git = gitWithConfig; })
      pwgen
      qrencode
      yubikey-manager

      # Network tools
      # netcat # use nmap/ncat
      # netcat-gnu # use nmap/ncat
      curl
      bind
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
      # wrk2 # HTTP benchmarking tool # 2023-06-22 FTB on darwin aarch64

      # Terraform
      # terraform # Using tfenv from homebrew
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
      nixpkgs-fmt
    ] ++ lib.optionals stdenv.isLinux [
      display-switch # FTB darwin: libaio-0.3.111
      gitAndTools.git-annex # slow to build, linux has pre-built binaries
      # TODO: installing inetutils results in ping without root permissions
      # inetutils # (dnsdomainname ftp hostname ifconfig logger ping ping6 rcp rexec rlogin rsh talk telnet tftp traceroute whois)
      isync
      gthumb
      librecad
      notmuchWithConfig # FTB on darwin: gpg: can't connect to the agent: File name too long
      rclone
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
