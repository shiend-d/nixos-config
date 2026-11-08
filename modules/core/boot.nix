{ self, inputs, ... }: {
  flake.nixosModules.boot = { pkgs, lib, ... }: {
    boot.loader = {
      efi = {
        canTouchEfiVariables = false;
        efiSysMountPoint = "/boot";
      };
      grub = {
        enable = true;
        efiSupport = true;
        device = "nodev";
        configurationLimit = 5;
        useOSProber = true;
        efiInstallAsRemovable = true;
      };
    };

    boot.extraModprobeConfig = ''
      options rtw88_core disable_lps_deep=1
      options rtw88_pci disable_aspm=1
    '';
  };
}
