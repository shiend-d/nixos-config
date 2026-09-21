{ self, inputs, ... }: {
  flake.nixosModules.storage = { pkgs, lib, ... }: {
    services.udisks2.enable = true;
    services.gvfs.enable = true;
  };
}
