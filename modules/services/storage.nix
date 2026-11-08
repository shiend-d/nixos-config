{ self, inputs, ... }: {
  flake.nixosModules.storage = { pkgs, lib, ... }: {
    services.udisks2.enable = true;
    services.gvfs.enable = true;

    environment.systemPackages = with pkgs; [
      e2fsprogs
    ];
  };
}
