{ self, inputs, ... }: {
  flake.nixosModules.users = { pkgs, lib, ... }: {

    programs.fish.enable = true;
    programs.starship = {
      enable = true;
      enableFishIntegration = true;
    };

    programs.direnv = {
      enable = true;
      nix-direnv.enable = true;
    };

    users.users."shiend" = {
      isNormalUser = true;
      description = "Shiend";
      extraGroups = [
        "networkmanager"
        "wheel"
        "video"
        "audio"
        "i2c"
        "docker"
      ];
      shell = pkgs.fish;
    };
  };
}
