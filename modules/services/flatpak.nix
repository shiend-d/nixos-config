{ self, inputs, ... }: {
  flake.nixosModules.flatpak = { pkgs, lib, ... }: {
    imports = [ inputs.nix-flatpak.nixosModules.nix-flatpak ];

    services.flatpak = {
      enable = true;

      remotes = [
        {
          name = "flathub";
          location = "https://dl.flathub.org/repo/flathub.flatpakrepo";
        }
      ];

      update.auto = {
        enable = true;
        onCalendar = "weekly";
      };
    };
  };
}
