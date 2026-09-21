{ self, inputs, ... }: {
  flake.nixosModules.desktopTheme = { pkgs, lib, ... }: {
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

    xdg.mime.enable = true;
    xdg.mime.defaultApplications = {
      "application/pdf" = [ "org.kde.okular.desktop" ];
    };

    xdg.portal = {
      enable = true;
      extraPortals = [
        pkgs.kdePackages.xdg-desktop-portal-kde
        pkgs.xdg-desktop-portal-gtk
        pkgs.xdg-desktop-portal-gnome
      ];
      config = {
        common = {
          default = [ "kde" "gtk" "gnome" ];
          "org.freedesktop.impl.portal.FileChooser" = [ "kde" ];
          "org.freedesktop.impl.portal.ScreenCast" = [ "gnome" ];
          "org.freedesktop.impl.portal.RemoteDesktop" = [ "gnome" ];
        };
        niri = lib.mkForce {
          default = [ "kde" "gtk" "gnome" ];
          "org.freedesktop.impl.portal.FileChooser" = [ "kde" ];
          "org.freedesktop.impl.portal.ScreenCast" = [ "gnome" ];
          "org.freedesktop.impl.portal.RemoteDesktop" = [ "gnome" ];
        };
      };
    };

    # Fonts
    fonts = {
      packages = with pkgs; [
        
        nerd-fonts.jetbrains-mono    
        nerd-fonts.fira-code         
        nerd-fonts.iosevka          
        nerd-fonts.noto             
        
        noto-fonts                  
        noto-fonts-color-emoji
        noto-fonts-cjk-sans
        inter                       
        liberation_ttf            
      ];
      fontconfig = {
        defaultFonts = {
          monospace = [ "JetBrainsMono Nerd Font" ];
          sansSerif  = [ "Inter" "Noto Sans" ];
          serif      = [ "Noto Serif" ];
          emoji      = [ "Noto Color Emoji" ];
        };
      };
    };
  };
}
