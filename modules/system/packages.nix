{ self, inputs, ... }: {
  flake.nixosModules.packages = { pkgs, lib, ... }: {
    environment.systemPackages = with pkgs; [
      # --- Core CLI Utilities ---
      git
      wget
      curl
      kitty
      neovim
      btop
      fastfetch
      eza
      fzf

      # --- Wayland & Desktop Integration ---
      wl-clipboard
      cliphist
      bibata-cursors
      playerctl
      brightnessctl
      nwg-displays
      fuzzel
      ddcutil
      libnotify
      networkmanagerapplet
      qalculate-gtk
      xdg-user-dirs
      seahorse

      # --- Screenshots ---
      grim
      slurp
      satty

      # --- Audio Control ---
      pavucontrol

      # --- KDE & Dolphin File Manager Ecosystem ---
      kdePackages.dolphin
      kdePackages.konsole
      kdePackages.kio-extras
      kdePackages.kio-admin
      kdePackages.breeze-icons
      kdePackages.breeze
      kdePackages.plasma-integration
      kdePackages.polkit-kde-agent-1
      kdePackages.qqc2-desktop-style
      kdePackages.qtsvg

      # --- GUI Applications ---
      antigravity-ide
      equibop
    ] ++ [
      inputs.zen-browser.packages.${pkgs.stdenv.hostPlatform.system}.default
      (inputs.pixie-sddm.packages.${pkgs.stdenv.hostPlatform.system}.pixie-sddm.override {
        background = ../../assets/sddm/wallpaper.jpg;
        avatar = ../../assets/sddm/avatar.jpg;
      })
    ];
  };
}
