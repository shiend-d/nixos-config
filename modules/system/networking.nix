{ self, inputs, ... }: {
  flake.nixosModules.networking = { pkgs, lib, ... }: {
    networking.hostName = "nixos";
    networking.networkmanager.enable = true;
  };
}
