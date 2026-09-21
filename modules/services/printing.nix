{ self, inputs, ... }: {
  flake.nixosModules.printing = { pkgs, lib, ... }: {

    services.printing = {
      enable = true;
      drivers = with pkgs; [
        gutenprint
        epson-escpr2
      ];
    };

    hardware.sane = {
      enable = true;
      extraBackends = with pkgs; [ sane-airscan ];
    };

    services.avahi = {
      enable = true;
      nssmdns4 = true;
      openFirewall = true;
    };

  };
}
