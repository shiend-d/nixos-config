{ self, inputs, ... }: {
  flake.nixosModules.networking = { pkgs, lib, ... }: {
    networking.hostName = "nixos";
    networking.networkmanager = {
      enable = true;
    };

    networking.modemmanager.enable = false;

    networking.networkmanager.wifi = {
      scanRandMacAddress = false;
      powersave = false;
    };

    networking.firewall.trustedInterfaces = lib.mkAfter [ "wlp2s0" ];

    networking.firewall = {
      allowedTCPPorts = [ 9998 ];
      allowedUDPPorts = [ 9999 ];
      allowedTCPPortRanges = [ { from = 1714; to = 1764; } ];
      allowedUDPPortRanges = [ { from = 1714; to = 1764; } ];
    };

    networking.networkmanager.settings.connectivity = {
      enabled = true;
      uri = "http://nmcheck.gnome.org/check_network_status.txt";
      interval = 300;
    };

    services.openssh = {
      enable = true;
      settings = {
        PermitRootLogin = "no";
        PasswordAuthentication = true;
      };
    };

    services.nginx = {
      enable = true;
      recommendedGzipSettings = true;
      recommendedOptimisation = true;
      recommendedProxySettings = true;

      virtualHosts."localhost" = {
        locations."/" = {
          proxyPass = "http://127.0.0.1:3000";
          proxyWebsockets = true;
        };
      };
    };

    services.tailscale = {
      enable = true;
      openFirewall = true;
      useRoutingFeatures = "client";
    };

    services.cloudflare-warp = {
      enable = true;
      openFirewall = true;
    };

    systemd.services.sshd.wantedBy = lib.mkForce [];
    systemd.services.nginx.wantedBy = lib.mkForce [];
  };
}
