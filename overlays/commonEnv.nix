final: prev: {
  # iosevka-bin = prev.iosevka-bin.override { variant = "sgr-iosevka"; };
  iosevka-aile-bin = prev.iosevka-bin.override { variant = "Aile"; };

  commonEnv =
    with final;
    prev.buildEnv {
      name = "commonEnv";
      paths =
        [
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
          dnsutils # bind: dev, dig, nslookup
          dtach
          duckdb # query CSV files with SQL
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
          # rust-scripts # need to fix cargo keyerror
          sops
          sqlfluff # format SQL
          steampipe
          stow
          time
          tokei # count lines of code
          tree
          unzip
          watch
          xz # file compression
          yq-go # like jq, but for YAML
          zookeeper
          zshWithConfig
          haskellPackages.ShellCheck

          # Version control
          github-cli # gh command
          git-crypt
          gitWithConfig
          mercurial

          # Encryption/password management
          age
          rage
          age-plugin-yubikey
          (final.passage.override {
            age = age;
            git = gitWithConfig;
          }) # requires homebrew gnu-getopt
          (final.pass.override { git = gitWithConfig; })
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
          wrk2 # HTTP benchmarking tool # 2024-03-28 FTB on darwin aarch64

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
          nixfmt-rfc-style
        ]
        ++ lib.optionals stdenv.isLinux [
          bitwarden-cli # FTB on darwin: FileNotFoundError: [Errno 2] No such file or directory: 'xcrun'
          git-annex # slow to build, linux has pre-built binaries
          # TODO: installing inetutils results in ping without root permissions
          # inetutils # (dnsdomainname ftp hostname ifconfig logger ping ping6 rcp rexec rlogin rsh talk telnet tftp traceroute whois)
          isync
          joplin-desktop
          gthumb
          librecad
          notmuchWithConfig # FTB on darwin: gpg: can't connect to the agent: File name too long
          rclone
        ]
        ++ lib.optionals stdenv.isDarwin [
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
