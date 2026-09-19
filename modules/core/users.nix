{ self, inputs, ... }: {
  flake.nixosModules.users = { pkgs, lib, ... }: {
    # Shell configuration
    programs.fish.enable = true;
    programs.starship = {
      enable = true;
      enableFishIntegration = true;
    };

    # User account: shiend
    users.users."shiend" = {
      isNormalUser = true;
      description = "Shiend";
      extraGroups = [ "networkmanager" "wheel" "video" "audio" "i2c" ];
      shell = pkgs.fish;
    };
  };
}
