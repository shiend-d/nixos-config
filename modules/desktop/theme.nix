{ self, inputs, ... }: {
  flake.nixosModules.desktopTheme = { pkgs, lib, ... }: {

    xdg.terminal-exec = {
      enable = true;
      settings.default = [ "kitty.desktop" ];
    };

    environment.etc."xdg/kdeglobals".text = ''
      [General]
      TerminalApplication=kitty
      TerminalService=kitty.desktop
    '';

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
      "inode/directory" = [ "org.kde.dolphin.desktop" ];
      "application/pdf" = [ "onlyoffice-desktopeditors.desktop" ];
      "text/html" = [ "zen.desktop" ];
      "x-scheme-handler/http" = [ "zen.desktop" ];
      "x-scheme-handler/https" = [ "zen.desktop" ];
      "x-scheme-handler/chrome" = [ "zen.desktop" ];
      "application/msword" = [ "onlyoffice-desktopeditors.desktop" ];
      "application/rtf" = [ "onlyoffice-desktopeditors.desktop" ];
      "application/vnd.oasis.opendocument.text" = [ "onlyoffice-desktopeditors.desktop" ];
      "application/vnd.openxmlformats-officedocument.wordprocessingml.document" = [ "onlyoffice-desktopeditors.desktop" ];
      "application/vnd.ms-excel" = [ "onlyoffice-desktopeditors.desktop" ];
      "application/vnd.oasis.opendocument.spreadsheet" = [ "onlyoffice-desktopeditors.desktop" ];
      "application/vnd.openxmlformats-officedocument.spreadsheetml.sheet" = [ "onlyoffice-desktopeditors.desktop" ];
      "text/csv" = [ "onlyoffice-desktopeditors.desktop" ];
      "application/vnd.ms-powerpoint" = [ "onlyoffice-desktopeditors.desktop" ];
      "application/vnd.oasis.opendocument.presentation" = [ "onlyoffice-desktopeditors.desktop" ];
      "application/vnd.openxmlformats-officedocument.presentationml.presentation" = [ "onlyoffice-desktopeditors.desktop" ];
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

    fonts = {
      packages = with pkgs; [
        
        nerd-fonts.jetbrains-mono    
        nerd-fonts.fira-code         
        corefonts
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
