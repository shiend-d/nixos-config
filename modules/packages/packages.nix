{ self, inputs, ... }: {
  flake.nixosModules.packages = { pkgs, lib, ... }: {
    environment.systemPackages = with pkgs; [
      # Terminal and everyday CLI
      kitty
      neovim
      btop
      fastfetch
      eza
      fzf
      zellij
      zoxide
      tealdeer
      man-db
      just
      wget
      curl

      # Files, data, archives, and synchronization
      ripgrep
      fd
      bat
      file
      tree
      jq
      yq-go
      zip
      unzip
      p7zip
      unrar
      rsync

      # Version control
      git
      gh
      git-lfs
      lazygit
      delta

      # Disk and filesystem tools
      duf
      ncdu
      qdirstat
      exfatprogs
      ntfs3g

      # Hardware, power, and system diagnostics
      pciutils
      usbutils
      dmidecode
      lm_sensors
      smartmontools
      hwinfo
      powertop
      acpi
      lsof
      strace
      sysstat

      # Network, remote access, security, and device tools
      openssh
      mtr
      whois
      sshfs
      nmap
      tcpdump
      netcat-openbsd
      rustscan
      burpsuite
      age
      seahorse
      android-tools
      scrcpy

      # Development: build, debug, and code tools
      gcc
      clang
      cmake
      gnumake
      meson
      ninja
      pkg-config
      gdb
      lldb
      valgrind
      binutils
      tokei
      shellcheck
      shfmt
      tree-sitter

      # Development: language toolchains
      python3
      uv
      nodejs
      pnpm
      bun
      dotnet-sdk
      jdk
      maven
      gradle
      gfortran
      rustc
      cargo
      rust-analyzer
      clippy
      rustfmt
      go
      gopls

      # Wayland and desktop integration
      xwayland-satellite
      quickshell
      wl-clipboard
      cliphist
      wl-clip-persist
      wlrctl
      bibata-cursors
      brightnessctl
      nwg-displays
      ddcutil
      fuzzel
      libnotify
      networkmanagerapplet
      xdg-user-dirs
      xdg-utils
      zenity
      grim
      slurp
      satty
      qalculate-gtk
      glib
      mpvpaper
      socat

      # Audio
      pavucontrol
      cava
      playerctl

      # Multimedia playback and tools
      mpv
      imv
      ffmpeg
      yt-dlp

      # Documents
      onlyoffice-desktopeditors
      kdePackages.okular
      poppler-utils
      qpdf

      # KDE applications and integration
      kdePackages.dolphin
      kdePackages.konsole
      kdePackages.ark
      kdePackages.kio-extras
      kdePackages.kio-admin
      kdePackages.breeze-icons
      kdePackages.breeze
      kdePackages.plasma-integration
      kdePackages.qqc2-desktop-style
      kdePackages.qtsvg

      # Applications
      vscode
      virt-manager
      antigravity-cli
      codex
      (discord.override {
        withEquicord = true;
      })

    ] ++ [
      # Packages from external flakes
      (inputs.ytm-player.packages.${pkgs.stdenv.hostPlatform.system}.ytm-player-full.overrideAttrs (old: {
        patches = (old.patches or []) ++ [ ./patches/rpc.patch ];
      }))
      inputs.zen-browser.packages.${pkgs.stdenv.hostPlatform.system}.default
      (inputs.pixie-sddm.packages.${pkgs.stdenv.hostPlatform.system}.pixie-sddm.override {
        background = ../../assets/sddm/wallpaper.jpg;
        avatar = ../../assets/sddm/avatar.jpg;
      })
    ];

    environment.localBinInPath = true;

    programs.steam = {
      enable = true;
      package = pkgs.millennium-steam;
    };

    programs.gamemode.enable = true;

    nixpkgs.overlays = [
      inputs.millennium.overlays.default
      (final: prev: {
        equicord = prev.equicord.overrideAttrs (old: rec {
          version = "2026-11-06";
          src = prev.fetchFromGitHub {
            owner = "Equicord";
            repo = "Equicord";
            tag = version;
            hash = "sha256-poye0GWfucn/NsSuAmkXjJVP7qOc2g6n9KQWUFQVzak=";
          };
          pnpmDeps = prev.fetchPnpmDeps {
            pname = "equicord";
            inherit version src;
            pnpm = prev.pnpm_11;
            fetcherVersion = 4;
            hash = "sha256-YI+fviBbfyKPdPZtMqin3Sk2M1Rumdf+B8n68bsibnc=";
          };
        });
      })
    ];
  };
}
