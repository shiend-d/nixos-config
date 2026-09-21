{ self, inputs, ... }: {
  flake.nixosModules.desktopRecorder = { pkgs, lib, ... }: {
    programs.obs-studio = {
      enable = true;
      enableVirtualCamera = true;
    };
  };
}
