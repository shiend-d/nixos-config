{ self, inputs, ... }: {
  flake.nixosModules.security = { pkgs, lib, ... }: {
    # GNOME Keyring
    services.gnome.gnome-keyring.enable = true;
    security.pam.services.login.enableGnomeKeyring = true;

    # Polkit & Udisks2 Rules
    security.polkit = {
      enable = true;
      enablePkexecWrapper = true;
      extraConfig = ''
        polkit.addRule(function(action, subject) {
          if ((action.id == "org.freedesktop.udisks2.filesystem-mount" ||
               action.id == "org.freedesktop.udisks2.filesystem-mount-system" ||
               action.id == "org.freedesktop.udisks2.filesystem-mount-other-seat" ||
               action.id == "org.freedesktop.udisks2.encrypted-unlock" ||
               action.id == "org.freedesktop.udisks2.eject-media" ||
               action.id == "org.freedesktop.udisks2.power-off-drive") &&
              subject.isInGroup("wheel")) {
            return polkit.Result.YES;
          }
        });

        // Noctalia Greeter: passwordless appearance sync (NixOS nixpkgs module rule)
        polkit.addRule(function(action, subject) {
          var allowedUsers = ["shiend"];
          if (action.id == "org.noctalia.greeter.sync-appearance" &&
              action.lookup("program") == "${pkgs.noctalia-greeter}/bin/noctalia-greeter-apply-appearance" &&
              action.lookup("user") == "root" &&
              subject.local && subject.active &&
              allowedUsers.indexOf(subject.user) >= 0) {
            return polkit.Result.YES;
          }
        });
      '';
    };

    # Polkit KDE Agent Service (Fallback GUI Agent)
    systemd.user.services.polkit-kde-authentication-agent-1 = {
      description = "polkit-kde-authentication-agent-1";
      wantedBy = [ "graphical-session.target" ];
      wants = [ "graphical-session.target" ];
      after = [ "graphical-session.target" ];
      serviceConfig = {
        Type = "simple";
        ExecStart = "${pkgs.kdePackages.polkit-kde-agent-1}/libexec/polkit-kde-authentication-agent-1";
        Restart = "on-failure";
        RestartSec = 1;
        TimeoutStopSec = 10;
      };
    };
  };
}
