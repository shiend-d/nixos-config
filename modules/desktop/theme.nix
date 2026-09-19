{ self, inputs, ... }: {
  flake.nixosModules.desktopTheme = { pkgs, lib, ... }: {
    # Qt Theme Integration (Auto-match KDE / Noctalia dark mode)
    qt = {
      enable = true;
      platformTheme = "kde";
      style = "breeze";
    };

    environment.sessionVariables = {
      QT_QPA_PLATFORMTHEME = "kde";
      QT_STYLE_OVERRIDE = "breeze";
      XCURSOR_THEME = "Bibata-Modern-Classic";
      XCURSOR_SIZE = "24";
      HYPRCURSOR_THEME = "Bibata-Modern-Classic";
      HYPRCURSOR_SIZE = "24";
    };

    # XDG Portals for Wayland
    xdg.portal = {
      enable = true;
      extraPortals = [
        pkgs.kdePackages.xdg-desktop-portal-kde
        pkgs.xdg-desktop-portal-gtk
      ];
      config = {
        common = {
          default = [ "kde" "gtk" ];
          "org.freedesktop.impl.portal.FileChooser" = [ "kde" ];
        };
        niri = lib.mkForce {
          default = [ "kde" "gtk" ];
          "org.freedesktop.impl.portal.FileChooser" = [ "kde" ];
        };
      };
    };

    # Fonts
    fonts = {
      packages = with pkgs; [
        nerd-fonts.jetbrains-mono
        noto-fonts
        noto-fonts-color-emoji
      ];
      fontconfig = {
        defaultFonts = {
          monospace = [ "JetBrainsMono Nerd Font" ];
          sansSerif = [ "Noto Sans" ];
          serif = [ "Noto Serif" ];
        };
      };
    };
  };
}
