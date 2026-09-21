{ self, inputs, ... }: {
  flake.nixosModules.boot = { pkgs, lib, ... }: {
    boot.loader.grub = {
      enable = true;
      device = "nodev";   
      efiSupport = true;
      useOSProber = true; 
    };
    boot.loader.efi.canTouchEfiVariables = true;
  };
}
