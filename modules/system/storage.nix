{ self, inputs, ... }: {
  flake.nixosModules.storage = { pkgs, lib, ... }: {
    # Disk mounting and GVFS backends for Dolphin / File managers
    services.udisks2.enable = true;
    services.gvfs.enable = true;
  };
}
