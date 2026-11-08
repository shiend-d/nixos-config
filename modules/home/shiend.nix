{ inputs, ... }: {
  flake.nixosModules.homeManager = { ... }: {
    imports = [ inputs.home-manager.nixosModules.home-manager ];

    home-manager = {
      useGlobalPkgs = true;
      useUserPackages = true;
      users.shiend = import ../../home/shiend;
    };
  };
}
