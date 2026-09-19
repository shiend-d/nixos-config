{ self, inputs, ... }: {
  flake.nixosModules.desktopNiri = { pkgs, lib, ... }: {
    programs.niri = {
      enable = true;
      package = pkgs.niri;
    };
  };
}
