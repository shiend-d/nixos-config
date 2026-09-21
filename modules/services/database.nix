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

    services.redis.servers."" = {
      enable = true;
      port = 6379;
    };

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

    # services.mongodb = {
    #   enable = true;
    #   package = pkgs.mongodb;
    # };

  };
}
