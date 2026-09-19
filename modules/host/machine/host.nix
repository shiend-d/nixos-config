{ self, inputs, ... }: {
  flake.nixosConfigurations.shiend = inputs.nixpkgs.lib.nixosSystem {
    modules = [
      self.nixosModules.shiendConfiguration
    ];
  };
}
