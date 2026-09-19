{ self, inputs, ... }: {
  flake.nixosModules.nixSettings = { pkgs, lib, ... }: {
    nix.settings.experimental-features = [ "nix-command" "flakes" ];
    nixpkgs.config.allowUnfree = true;
    system.stateVersion = "26.05";
  };
}
