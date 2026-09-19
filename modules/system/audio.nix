{ self, inputs, ... }: {
  flake.nixosModules.audio = { pkgs, lib, ... }: {
    # PipeWire Audio
    services.pipewire = {
      enable = true;
      alsa.enable = true;
      alsa.support32Bit = true;
      pulse.enable = true;
      wireplumber.enable = true;
    };
  };
}
