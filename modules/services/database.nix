{ self, inputs, ... }: {
  flake.nixosModules.database = { pkgs, lib, config, ... }: {

    services.postgresql = {
      enable = true;
      package = pkgs.postgresql;
      enableTCPIP = false;

      ensureUsers = [
        {
          name = "shiend";
          ensureClauses = {
            superuser = true;
            login = true;
          };
        }
      ];
    };

    systemd.services.postgresql.wantedBy = lib.mkForce [];
    systemd.targets.postgresql = {
      requires = lib.mkForce [];
      wantedBy = lib.mkForce [];
    };

    services.redis.servers."" = {
      enable = true;
      port = 6379;
    };

    systemd.services.redis.wantedBy = lib.mkForce [];

    services.mysql = {
      enable = true;
      package = pkgs.mariadb;
      ensureUsers = [
        {
          name = "shiend";
          ensurePermissions = { "*.*" = "ALL PRIVILEGES"; };
        }
      ];
    };

    systemd.services.mysql.wantedBy = lib.mkForce [];

    # services.mongodb = {
    #   enable = true;
    #   package = pkgs.mongodb;
    # };

  };
}
