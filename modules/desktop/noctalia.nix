{ self, inputs, ... }: {
  flake.nixosModules.desktopNoctalia = { pkgs, lib, ... }: {
    imports = [
      inputs.noctalia.nixosModules.default
    ];

    programs.noctalia = {
      enable = true;
      recommendedServices.enable = true;
    };

    services.blueman.enable = true;
    services.upower.enable = true;
    services.power-profiles-daemon.enable = true;

    services.displayManager.sddm = {
      enable = true;
      wayland.enable = true;
      package = pkgs.kdePackages.sddm;
      theme = "pixie";
      settings = {
        Theme = {
          CursorTheme = "Bibata-Modern-Classic";
        };
      };
      extraPackages = [
        pkgs.kdePackages.qtsvg
        pkgs.kdePackages.qtdeclarative
        pkgs.kdePackages.qt5compat
      ];
    };
    services.xserver.enable = false;
  };
}
