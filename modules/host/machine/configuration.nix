{ self, inputs, ... }: {
  flake.nixosModules.shiendConfiguration = { pkgs, lib, ... }: {
    imports = [
      # Core system
      self.nixosModules.boot
      self.nixosModules.nixSettings
      self.nixosModules.locale
      self.nixosModules.users

      # Hardware
      self.nixosModules.hardware

      # System services
      self.nixosModules.networking
      self.nixosModules.security
      self.nixosModules.storage
      self.nixosModules.audio
      self.nixosModules.packages

      # Desktop environment (Niri + Noctalia)
      self.nixosModules.desktopNiri
      self.nixosModules.desktopNoctalia
      self.nixosModules.desktopTheme
    ];
  };
}
