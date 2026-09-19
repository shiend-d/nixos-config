{ self, inputs, ... }: {
  flake.nixosModules.boot = { pkgs, lib, ... }: {
    boot.loader.grub = {
      enable = true;
      device = "nodev";   # EFI (GPT)
      efiSupport = true;
      useOSProber = true; # Auto-detect Windows / Dual-boot
    };
    boot.loader.efi.canTouchEfiVariables = true;
  };
}
