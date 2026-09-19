{ self, inputs, ... }: {
  flake.nixosModules.hardware = { config, lib, pkgs, modulesPath, ... }: {
    imports = [
      (modulesPath + "/installer/scan/not-detected.nix")
    ];

    # Hardware & Kernel Modules
    boot.initrd.availableKernelModules = [ "xhci_pci" "ahci" "nvme" "usb_storage" "usbhid" "sd_mod" ];
    boot.initrd.kernelModules = [ ];
    boot.kernelModules = [ "kvm-intel" "i2c-dev" ];
    boot.extraModulePackages = [ ];

    # Filesystems & Mounts
    fileSystems."/" = {
      device = "/dev/disk/by-uuid/11212611-3fb3-4813-9254-f99475b8088e";
      fsType = "ext4";
    };

    fileSystems."/boot" = {
      device = "/dev/disk/by-uuid/878D-ED93";
      fsType = "vfat";
      options = [ "fmask=0077" "dmask=0077" ];
    };

    swapDevices = [ { device = "/var/lib/swapfile"; size = 4096; } ];

    # CPU & Architecture
    nixpkgs.hostPlatform = lib.mkDefault "x86_64-linux";
    hardware.cpu.intel.updateMicrocode = lib.mkDefault config.hardware.enableRedistributableFirmware;
    hardware.i2c.enable = true;
  };
}
