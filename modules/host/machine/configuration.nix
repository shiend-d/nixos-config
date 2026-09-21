{ self, inputs, ... }: {
  flake.nixosModules.shiendConfiguration = { pkgs, lib, ... }: {
    imports = [
      self.nixosModules.boot
      self.nixosModules.nixSettings
      self.nixosModules.locale
      self.nixosModules.users
      self.nixosModules.hardware

      self.nixosModules.networking
      self.nixosModules.security
      self.nixosModules.storage
      self.nixosModules.audio
      self.nixosModules.power
      self.nixosModules.printing
      self.nixosModules.flatpak
      self.nixosModules.packages
      self.nixosModules.docker  
      self.nixosModules.database

      self.nixosModules.desktopNiri
      self.nixosModules.desktopNoctalia
      self.nixosModules.desktopTheme
      self.nixosModules.desktopRecorder
    ];
  };
}
