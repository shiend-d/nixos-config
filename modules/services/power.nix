{ self, inputs, ... }: {
  flake.nixosModules.power = { pkgs, lib, ... }: {

    services.thermald.enable = true;

    services.fwupd.enable = true;

    zramSwap.enable = true;

  };
}
